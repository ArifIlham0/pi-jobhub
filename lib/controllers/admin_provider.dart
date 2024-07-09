import 'package:flutter/material.dart';
import 'package:jobhub/models/response/auth/pending_user_res_model.dart';
import 'package:jobhub/services/helpers/auth_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProvider extends ChangeNotifier {
  late Future<List<PendingUserResponse>> pendingUserList;
  String? userId;

  getPendingUser() {
    pendingUserList = AuthHelper.getPendingUsers();
  }

  getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    print("user id? ${userId}");
  }

  Future<void> moveUser(String? userId) async {
    await AuthHelper.moveUser(userId);
  }
}
