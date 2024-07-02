import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/request/jobs/create_job.dart';
import 'package:jobhub/models/response/jobs/get_job.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';
import 'package:jobhub/views/ui/mainscreen.dart';

class JobsProvider extends ChangeNotifier {
  late Future<List<JobsResponse>> jobsList;
  late Future<JobsResponse> recentJob;
  late Future<GetJobRes> jobById;

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
        Get.off(() => MainScreen());
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
}
