import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/chats/create_chat.dart';
import 'package:jobhub/models/response/chats/get_chat.dart';
import 'package:jobhub/models/response/chats/initial_chat.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHelper {
  static var client = https.Client();

  static Future<List<dynamic>> applyJob(CreateChat model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': '$token',
    };

    var url = Uri.https(Config.apiUrl, Config.chatUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      var first = initialChatFromJson(response.body).id;
      return [true, first];
    } else {
      return [false];
    }
  }

  static Future<List<GetChats>> getChat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': '$token',
    };

    var url = Uri.https(Config.apiUrl, Config.chatUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var chats = getChatsFromJson(response.body);
      return chats;
    } else {
      throw Exception('Failed to load chats');
    }
  }
}
