import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/auth/agent_update.dart';
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/models/request/auth/profile_update_model.dart';
import 'package:jobhub/models/request/auth/signup_agent_model.dart';
import 'package:jobhub/models/request/auth/signup_model.dart';
import 'package:jobhub/models/response/auth/login_res_model.dart';
import 'package:jobhub/models/response/auth/pending_user_res_model.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.loginUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = loginResponseModelFromJson(response.body).userToken;
      String? userId = loginResponseModelFromJson(response.body).id;
      String? profile = loginResponseModelFromJson(response.body).profile;

      DateTime now = DateTime.now();
      await prefs.setString("token", token!);
      await prefs.setString("tokenTime", now.toIso8601String());

      await prefs.setString("userId", userId!);
      await prefs.setString("profile", profile!);
      await prefs.setBool("loggedIn", true);

      print("Berhasil login ${jsonDecode(response.body)}");
      return true;
    } else {
      print("Gagal login ${jsonDecode(response.body)}");
      return false;
    }
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? tokenTime = prefs.getString("tokenTime");

    if (token != null && tokenTime != null) {
      DateTime storedTime = DateTime.parse(tokenTime);
      DateTime now = DateTime.now();

      if (now.difference(storedTime).inDays > 19) {
        await prefs.remove("token");
        await prefs.remove("tokenTime");
        token = null;
      }
    }

    return token;
  }

  static Future<bool> register(SignupModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.signupUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  static Future<bool> registerAgent(SignUpAgent model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.signupUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  static Future<bool> updateProfile(
      ProfileUpdateReq model, String? userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print("Token: $token");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateAgent(UpdateAgentReq model, String? userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print("Token: $token");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print("Token: $token");
    if (token == null) {
      throw Exception("Token is null");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var profile = profileResFromJson(response.body);
      print("Berhasil ambil profile ${response.body}");
      return profile;
    } else {
      throw Exception("Gagal ambil profil ${jsonDecode(response.body)}");
    }
  }

  static Future<List<PendingUserResponse>> getPendingUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print("Token: $token");
    if (token == null) {
      throw Exception("Token is null");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.pendingUser);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var pendingUser = pendingUserResponseFromJson(response.body);
      return pendingUser;
    } else {
      throw Exception("Gagal get pending user");
    }
  }

  static Future<bool> moveUser(String? userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.https(Config.apiUrl, "${Config.movePending}/$userId");
    var response = await client.put(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deletePendingUser(String? userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.https(Config.apiUrl, "${Config.deletePending}/$userId");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
