import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhub/models/response/bookmarks/bookmark_res.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkHelper {
  static var client = https.Client();

  static Future<List<dynamic>> addBookmarks(BookmarkReqResModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': '$token',
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      String? bookmarkId = bookmarkReqResFromJson(response.body).id;
      print("Berhasil add bookmark ${response.body}");
      return [true, bookmarkId];
    } else {
      return [false];
    }
  }

  static Future<bool> deleteBookmarks(String? jobId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': '$token',
    };

    var url = Uri.https(Config.apiUrl, "${Config.bookmarkUrl}/$jobId");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      print("Berhasil delete bookmark ${response.body}");
      return true;
    } else {
      return false;
    }
  }

  static Future<List<AllBookmarks>> getBookmarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': '$token',
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var bookmarks = allBookmarksFromJson(response.body);
      return bookmarks;
    } else {
      throw Exception('Failed to load bookmarks');
    }
  }
}
