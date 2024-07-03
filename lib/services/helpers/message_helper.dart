import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/messages/send_message.dart';
import 'package:jobhub/models/response/messages/message_res.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageHelper {
  static var client = https.Client();

  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': '$token',
    };

    var url = Uri.https(Config.apiUrl, Config.messageUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      ReceivedMessage message =
          ReceivedMessage.fromJson(jsonDecode(response.body));

      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [true, message, responseMap];
    } else {
      return [false];
    }
  }

  static Future<List<ReceivedMessage>> getMessages(
      String? chatId, int? offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': '$token',
    };

    var url = Uri.https(
      Config.apiUrl,
      "${Config.messageUrl}/$chatId",
      {"page": offset.toString()},
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var messages = receivedMessageFromJson(response.body);
      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
