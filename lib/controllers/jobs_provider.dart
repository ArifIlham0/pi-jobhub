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

  createJob(CreateJobsRequest model) {
    JobsHelper.createJob(model).then((response) {
      if (response) {
        Get.snackbar(
          "Berhasil menambahkan lowongan!",
          "",
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: Icon(Icons.work),
        );
        Get.back();
      } else {
        Get.snackbar(
          "Gagal membuat lowongan",
          "Tolong periksa kembali data yang diinputkan",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.work),
        );
      }
    });
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
