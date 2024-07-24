import 'package:http/http.dart' as https;
import 'package:jobhub/models/response/admin/all_agents_res.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHelper {
  static var client = https.Client();

  static Future<List<AllAgentsRes>> getAllAgents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print("Token: $token");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.https(Config.apiUrl, Config.allAgentsUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var agentList = allAgentsResFromJson(response.body);
      return agentList;
    } else {
      throw Exception('Failed to load agents list');
    }
  }

  static Future<List<AllAgentsRes>> getAllUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print("Token: $token");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.https(Config.apiUrl, Config.allUsersUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var userList = allAgentsResFromJson(response.body);
      return userList;
    } else {
      throw Exception('Failed to load users list');
    }
  }

  static Future<bool> deleteAgentOrUser(String? userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.https(Config.apiUrl, "${Config.profileUrl}/$userId");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      print("Berhasil delete akun ${response.body}");
      return true;
    } else {
      print("Gagal delete akun ${response.body}");
      return false;
    }
  }
}
