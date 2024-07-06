import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhub/services/helpers/book_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkProvider extends ChangeNotifier {
  List<String>? _jobs = [];
  Future<List<AllBookmarks>>? bookmarks;

  List<String> get jobs => _jobs!;

  set jobs(List<String> value) {
    _jobs = value;
    notifyListeners();
  }

  Future<void> addJob(String? jobId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_jobs != null) {
      _jobs?.insert(0, jobId!);
      prefs.setStringList('jobId', _jobs!);
      notifyListeners();
    }
  }

  Future<void> deleteJob(String? jobId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_jobs != null) {
      _jobs?.remove(jobId!);
      prefs.setStringList('jobId', _jobs!);
      notifyListeners();
    }
  }

  Future<void> loadJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList('jobId');

    if (jobs != null) {
      _jobs = jobs;
    }
  }

  Future<void> addBookmark(BookmarkReqResModel? model, String? jobId) async {
    await BookMarkHelper.addBookmarks(model!).then(
      (response) {
        if (response[0]) {
          addJob(jobId);
        } else {
          Get.snackbar(
            "Terjadi kesalahan",
            "Gagal menambahkan ke bookmark",
            colorText: Color(kBlack2.value),
            backgroundColor: Colors.red,
            icon: Icon(Icons.bookmark_add),
          );
        }
      },
    );
  }

  Future<void> deleteBookmark(String? jobId) async {
    await BookMarkHelper.deleteBookmarks(jobId).then(
      (response) {
        if (response) {
          deleteJob(jobId);
        }
      },
    );
  }

  void getBookmarks() {
    bookmarks = BookMarkHelper.getBookmarks();
  }
}
