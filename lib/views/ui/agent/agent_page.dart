import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/jobs/create_job.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/heading_widget.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/jobs/job_list_agent.dart';
import 'package:provider/provider.dart';

class AgentPage extends StatefulWidget {
  const AgentPage({super.key});

  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController contract = TextEditingController();
  TextEditingController requirement1 = TextEditingController();
  TextEditingController requirement2 = TextEditingController();
  TextEditingController requirement3 = TextEditingController();
  TextEditingController requirement4 = TextEditingController();
  TextEditingController requirement5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Mitra",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return FutureBuilder<ProfileRes>(
            future: profileProvider.profile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                ProfileRes profile = snapshot.data!;
                return Form(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    children: [
                      ReusableText(
                        text: "Buat Lowongan",
                        style: appstyle(
                          35,
                          Color(kDark.value),
                          FontWeight.bold,
                        ),
                      ),
                      HeightSpacer(size: 20),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              controller: title,
                              hintText: "Posisi",
                              keyboardType: TextInputType.text,
                              validator: (title) {
                                if (title!.isEmpty) {
                                  return "Tolong masukkan posisi";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: description,
                              hintText: "Deskripsi",
                              isAgent: true,
                              keyboardType: TextInputType.multiline,
                              validator: (description) {
                                if (description!.isEmpty) {
                                  return "Tolong masukkan deskripsi";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: salary,
                              hintText: "Gaji per bulan",
                              keyboardType: TextInputType.number,
                              validator: (salary) {
                                if (salary!.isEmpty) {
                                  return "Tolong masukkan gaji";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: contract,
                              hintText: "Full-Time / Part-Time",
                              keyboardType: TextInputType.text,
                              validator: (contract) {
                                if (contract!.isEmpty) {
                                  return "Tolong masukkan periode kerja";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: requirement1,
                              hintText: "Persyaratan",
                              keyboardType: TextInputType.text,
                              validator: (requirement1) {
                                if (requirement1!.isEmpty) {
                                  return "Minimal isi 1 persyaratan";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: requirement2,
                              hintText: "Persyaratan",
                              keyboardType: TextInputType.text,
                              validator: (requirement2) {
                                if (requirement2!.isEmpty) {
                                  return "Minimal isi 1 persyaratan";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: requirement3,
                              hintText: "Persyaratan",
                              keyboardType: TextInputType.text,
                              validator: (requirement3) {
                                if (requirement3!.isEmpty) {
                                  return "Minimal isi 1 persyaratan";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: requirement4,
                              hintText: "Persyaratan",
                              keyboardType: TextInputType.text,
                              validator: (requirement4) {
                                if (requirement4!.isEmpty) {
                                  return "Minimal isi 1 persyaratan";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: requirement5,
                              hintText: "Persyaratan",
                              keyboardType: TextInputType.text,
                              validator: (requirement5) {
                                if (requirement5!.isEmpty) {
                                  return "Minimal isi 1 persyaratan";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            HeightSpacer(size: 20),
                            Consumer<JobsProvider>(
                              builder: (context, jobProvider, child) {
                                return Column(
                                  children: [
                                    HeadingWidget(
                                      text: "",
                                      isAgent: true,
                                      onTap: () {
                                        Get.to(
                                          () => JobListAgent(),
                                          transition: Transition.rightToLeft,
                                          duration: Duration(milliseconds: 100),
                                        );
                                      },
                                    ),
                                    HeightSpacer(size: 15),
                                    CustomButton(
                                      onTap: () {
                                        CreateJobsRequest model =
                                            CreateJobsRequest(
                                          title: title.text,
                                          description: description.text,
                                          salary: salary.text,
                                          contract: contract.text,
                                          period: "bulan",
                                          agentId: profile.id,
                                          company: profile.username,
                                          hiring: true,
                                          imageUrl: profile.profile,
                                          location: profile.location,
                                          requirements: [
                                            requirement1.text,
                                            requirement2.text,
                                            requirement3.text,
                                            requirement4.text,
                                            requirement5.text,
                                          ],
                                        );

                                        jobProvider.createJob(model);
                                      },
                                      text: "Buat",
                                    ),
                                  ],
                                );
                              },
                            ),
                            HeightSpacer(size: 35),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    salary.dispose();
    contract.dispose();
    requirement1.dispose();
    requirement2.dispose();
    requirement3.dispose();
    requirement4.dispose();
    requirement5.dispose();
    super.dispose();
  }
}
