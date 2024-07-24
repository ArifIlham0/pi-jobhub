import 'package:flutter/material.dart';
import 'package:jobhub/models/response/admin/all_agents_res.dart';
import 'package:jobhub/models/response/auth/pending_user_res_model.dart';
import 'package:jobhub/services/helpers/admin_helper.dart';
import 'package:jobhub/services/helpers/auth_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProvider extends ChangeNotifier {
  late Future<List<PendingUserResponse>> pendingUserList;
  late Future<List<AllAgentsRes>> agentList;
  late Future<List<AllAgentsRes>> userList;
  String? userId;

  getPendingUser() {
    pendingUserList = AuthHelper.getPendingUsers();
  }

  getAllAgents() {
    agentList = AdminHelper.getAllAgents();
  }

  getAllUsers() {
    userList = AdminHelper.getAllUsers();
  }

  getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    print("user id? ${userId}");
  }

  Future<void> moveUser(String? userId) async {
    await AuthHelper.moveUser(userId);
  }

  Future<void> deleteUser(String? userId) async {
    await AuthHelper.deletePendingUser(userId);
  }

  Future<void> deleteAgentOrUser(String? userId) async {
    await AdminHelper.deleteAgentOrUser(userId);
  }
}
