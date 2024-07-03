import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/chats/create_chat.dart';
import 'package:jobhub/models/request/jobs/create_job.dart';
import 'package:jobhub/models/request/messages/send_message.dart';
import 'package:jobhub/models/response/jobs/get_job.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/chat_helper.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';
import 'package:jobhub/services/helpers/message_helper.dart';
import 'package:jobhub/views/ui/chat/chat_list.dart';
import 'package:jobhub/views/ui/mainscreen.dart';

class JobsProvider extends ChangeNotifier {
  late Future<List<JobsResponse>> jobsList;
  late Future<JobsResponse> recentJob;
  late Future<GetJobRes> jobById;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getJobs() {
    jobsList = JobsHelper.getJobs();
  }

  getRecentJob() {
    recentJob = JobsHelper.getRecentJob();
  }

  getJobById(String? id) {
    jobById = JobsHelper.getJobById(id);
  }

  Future<void> createJob(CreateJobsRequest model) async {
    try {
      final response = await JobsHelper.createJob(model);
      if (response) {
        Get.snackbar(
          "Berhasil menambahkan lowongan!",
          "Kunjungi beranda untuk melihat lowongan yang telah dibuat",
          colorText: Color(kBlack2.value),
          backgroundColor: Color(kGreen2.value),
          icon: Icon(Icons.work),
        );
        Get.to(() => MainScreen());
      } else {
        Get.snackbar(
          "Gagal membuat lowongan",
          "Tolong periksa kembali data yang diinputkan",
          colorText: Color(kBlack2.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.work),
        );
      }
    } finally {
      setIsLoading = false;
    }
  }

  Future<void> applyJob(CreateChat model, String content, String receiver,
      ProfileProvider profileProvider) async {
    setIsLoading = true;
    try {
      final response = await ChatHelper.applyJob(model);
      if (response[0]) {
        SendMessage messageModel = SendMessage(
          chatId: response[1],
          content: content,
          receiver: receiver,
        );
        await MessageHelper.sendMessage(messageModel);
        Get.to(
          () => ChatList(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 100),
        );
      }
    } finally {
      setIsLoading = false;
    }
  }
}
