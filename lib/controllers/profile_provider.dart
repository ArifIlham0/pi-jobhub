import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/services/helpers/auth_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  Future<ProfileRes>? profile;
  String? _cvUrl;

  String get cvUrl => _cvUrl!;

  set setCvUrl(String value) {
    _cvUrl = value;
    notifyListeners();
  }

  getProfile() async {
    profile = AuthHelper.getProfile();
  }

  Future<File> downloadFile(String url, String filename) async {
    final response = await http.get(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.bodyBytes);
    await raf.close();

    return file;
  }
}
