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
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loading_button.dart';
import 'package:jobhub/views/common/loading_indicator.dart';
import 'package:jobhub/views/common/heading_widget.dart';
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
  TextEditingController requirement1 = TextEditingController();
  TextEditingController requirement2 = TextEditingController();
  TextEditingController requirement3 = TextEditingController();
  TextEditingController requirement4 = TextEditingController();
  TextEditingController requirement5 = TextEditingController();
  String dropdownValue = 'Teknologi';
  String contractType = 'Full-Time';

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    salary.dispose();
    requirement1.dispose();
    requirement2.dispose();
    requirement3.dispose();
    requirement4.dispose();
    requirement5.dispose();
    super.dispose();
  }

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
                return LoadingIndicator();
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
                          Color(kWhite2.value),
                          FontWeight.bold,
                        ),
                      ),
                      HeightSpacer(size: 20),
                      Form(
                        key: profileProvider.jobFormKey,
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
                            Container(
                              width: double.infinity,
                              child: DropdownButton(
                                value: dropdownValue,
                                iconSize: 24,
                                elevation: 0,
                                style: TextStyle(color: Color(kGreen.value)),
                                underline: Container(
                                  height: 2,
                                  color: Color(kGreen.value),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: [
                                  'Teknologi',
                                  'Bisnis',
                                  'Engineering',
                                  'Multimedia'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
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
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: ReusableText(
                                      text: "Full-Time",
                                      style: appstyle(12, Color(kWhite.value),
                                          FontWeight.normal),
                                    ),
                                    leading: Radio(
                                      fillColor: MaterialStateProperty.all(
                                          Color(kGreen.value)),
                                      value: 'Full-Time',
                                      groupValue: contractType,
                                      onChanged: (String? value) {
                                        setState(() {
                                          contractType = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: ReusableText(
                                      text: "Part-Time",
                                      style: appstyle(12, Color(kWhite.value),
                                          FontWeight.normal),
                                    ),
                                    leading: Radio(
                                      fillColor: MaterialStateProperty.all(
                                          Color(kGreen.value)),
                                      value: 'Part-Time',
                                      groupValue: contractType,
                                      onChanged: (String? value) {
                                        setState(() {
                                          contractType = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: requirement3,
                              hintText: "Persyaratan",
                              keyboardType: TextInputType.text,
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: requirement4,
                              hintText: "Persyaratan",
                              keyboardType: TextInputType.text,
                            ),
                            HeightSpacer(size: 10),
                            CustomTextField(
                              controller: requirement5,
                              hintText: "Persyaratan",
                              keyboardType: TextInputType.text,
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
                                    jobProvider.isLoading
                                        ? LoadingButton(
                                            onTap: () {},
                                          )
                                        : CustomButton(
                                            onTap: () async {
                                              if (profileProvider
                                                  .validateJob()) {
                                                jobProvider.setIsLoading = true;
                                                CreateJobsRequest model =
                                                    CreateJobsRequest(
                                                  title: title.text,
                                                  category: dropdownValue,
                                                  description: description.text,
                                                  salary: salary.text,
                                                  contract: contractType,
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

                                                await jobProvider
                                                    .createJob(model);
                                                jobProvider.setIsLoading =
                                                    false;
                                              } else {
                                                Get.snackbar(
                                                  "Gagal membuat lowongan",
                                                  "Tolong cek kembali inputan anda",
                                                  colorText:
                                                      Color(kBlack2.value),
                                                  backgroundColor: Colors.red,
                                                  icon: Icon(Icons.add_alert),
                                                  duration: Duration(
                                                      milliseconds: 1500),
                                                );
                                              }
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
}
