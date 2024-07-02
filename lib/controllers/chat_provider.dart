import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobhub/models/response/chats/get_chat.dart';
import 'package:jobhub/services/helpers/chat_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  List<String>? _online = [];
  bool? _typing = false;
  String? userId;

  List<String> get online => _online!;
  bool get typing => _typing!;

  set onlineUsers(List<String> value) {
    _online = value;
    notifyListeners();
  }

  set typingStatus(bool value) {
    _typing = value;
    notifyListeners();
  }

  getChat() {
    chats = ChatHelper.getChat();
  }

  getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    print("user id? ${userId}");
  }

  String messageTime(String? timestamp) {
    DateTime now = DateTime.now();
    DateTime date = DateTime.parse(timestamp!);

    if (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day) {
      return DateFormat.Hm().format(date);
    } else if (now.year == date.year &&
        now.month == date.month &&
        now.day - date.day == 1) {
      return "Kemarin";
    } else {
      return DateFormat.yMd().format(date);
    }
  }
}
