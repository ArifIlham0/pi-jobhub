import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/heading_widget.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/search.dart';
import 'package:jobhub/views/common/vertical_shimmer.dart';
import 'package:jobhub/views/common/vertical_tile.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:jobhub/views/ui/auth/update_agent.dart';
import 'package:jobhub/views/ui/jobs/job_page.dart';
import 'package:jobhub/views/ui/jobs/jobs_list.dart';
import 'package:jobhub/views/ui/jobs/widgets/horizontal_shimmer.dart';
import 'package:jobhub/views/ui/jobs/widgets/horizontal_tile.dart';
import 'package:jobhub/views/ui/search/searchpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            token != null
                ? FutureBuilder<ProfileRes>(
                    future: profileProvider.profile,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox();
                      } else if (snapshot.hasError) {
                        return Text("Error ${snapshot.error}");
                      } else {
                        ProfileRes profile = snapshot.data!;
                        if (profile.isPending == true) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Get.offAll(() => UpdateAgent());
                          });
                        }
                        profileProvider.setCvUrl = profile.cv;
                        profileProvider.setAgentRole = profile.isAgent;
                        return Padding(
                          padding: EdgeInsets.all(12.h),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(profile.profile),
                          ),
                        );
                      }
                    },
                  )
                : TextButton(
                    onPressed: () => Get.offAll(
                      () => LoginPage(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 100),
                    ),
                    child: ReusableText(
                      text: "Login",
                      style: appstyle(
                        12,
                        Color(kWhite2.value),
                        FontWeight.w500,
                      ),
                    ),
                  ),
          ],
          child: token != null
              ? Padding(
                  padding: EdgeInsets.all(12.0.h),
                  child: DrawerWidget(),
                )
              : SizedBox.shrink(),
        ),
      ),
      body: Consumer<JobsProvider>(
        builder: (context, jobsProvider, child) {
          jobsProvider.getJobs();
          jobsProvider.getRecentJob();

          return SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    HeightSpacer(size: 10),
                    Text(
                      "Temukan Pekerjaan Impianmu!",
                      style:
                          appstyle(30, Color(kWhite2.value), FontWeight.bold),
                    ),
                    HeightSpacer(size: 40),
                    SearchWidget(
                      onTap: () {
                        Get.to(
                          () => SearchPage(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 100),
                        );
                      },
                    ),
                    HeightSpacer(size: 30),
                    HeadingWidget(
                      text: "Lowongan Kerja",
                      onTap: () {
                        Get.to(
                          () => JobListPage(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 100),
                        );
                      },
                    ),
                    HeightSpacer(size: 15),
                    SizedBox(
                      height: height * 0.28,
                      child: FutureBuilder(
                        future: jobsProvider.jobsList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  HorizontalShimmer(),
                                  WidthSpacer(width: 10),
                                  HorizontalShimmer(),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error ${snapshot.error}");
                          } else {
                            final jobsSnapshot = snapshot.data;

                            return ListView.builder(
                              itemCount: jobsSnapshot?.length,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final jobs = jobsSnapshot?[index];

                                return JobHorizontalTile(
                                  onTap: () {
                                    Get.to(
                                      () => JobPage(
                                        title: jobs!.company,
                                        id: jobs.id,
                                      ),
                                      transition: Transition.rightToLeft,
                                      duration: Duration(milliseconds: 100),
                                    );
                                  },
                                  job: jobs,
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    HeightSpacer(size: 20),
                    HeadingWidget(
                      text: "Lowongan Terbaru",
                      onTap: () {
                        Get.to(
                          () => JobListPage(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 100),
                        );
                      },
                    ),
                    HeightSpacer(size: 20),
                    FutureBuilder(
                      future: jobsProvider.recentJob,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return VerticalShimmer();
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error}");
                        } else {
                          final recentJob = snapshot.data;

                          return VerticalTile(
                            recentJob: recentJob,
                            onTap: () {
                              Get.to(
                                () => JobPage(
                                  title: recentJob!.company,
                                  id: recentJob.id,
                                ),
                                transition: Transition.rightToLeft,
                                duration: Duration(milliseconds: 100),
                              );
                            },
                          );
                        }
                      },
                    ),
                    HeightSpacer(size: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
