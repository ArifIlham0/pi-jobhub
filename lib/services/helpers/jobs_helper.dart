import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/jobs/create_job.dart';
import 'package:jobhub/models/response/jobs/get_job.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<bool> createJob(CreateJobsRequest model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': '$token'
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<JobsResponse>> getJobs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print("Token: $token");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  static Future<JobsResponse> getRecentJob() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      var recentJob = jobList.last;
      return recentJob;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  static Future<GetJobRes> getJobById(String? id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    Map<String, String> requestHeadersToken = {
      'Content-type': 'application/json',
      'token': '$token',
    };

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.jobs}/$id");
    var response = await client.get(
      url,
      headers: token != null ? requestHeadersToken : requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobById = getJobResFromJson(response.body);
      print("Berhasil get job ${response.body}");
      return jobById;
    } else {
      print("Gagal get job ${response.body}");
      throw Exception('Failed to load jobs');
    }
  }

  static Future<List<JobsResponse>> searchJobs(String? text) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.search}/$text");
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to search jobs');
    }
  }
}
