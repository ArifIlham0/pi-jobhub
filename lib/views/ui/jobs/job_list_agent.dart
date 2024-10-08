import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/ui/jobs/widgets/job_tile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobListAgent extends StatelessWidget {
  const JobListAgent({super.key});

  @override
  Widget build(BuildContext context) {
    var jobList = Provider.of<JobsProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Lowongan Saya",
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([
          SharedPreferences.getInstance(),
          jobList.jobsList,
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final prefs = snapshot.data![0] as SharedPreferences;
            final userId = prefs.getString('userId');
            final jobListSnapshot = snapshot.data![1] as List<JobsResponse>;

            final filteredJobList =
                jobListSnapshot.where((job) => job.agentId == userId).toList();

            return Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 15.h),
              child: ListView.builder(
                itemCount: filteredJobList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final jobLists = filteredJobList[index];

                  return VerticalTileWidget(
                    job: jobLists,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
