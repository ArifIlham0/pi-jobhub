import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/jobs/create_job.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loading_button.dart';
import 'package:jobhub/views/common/loading_indicator.dart';
import 'package:provider/provider.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({super.key});

  @override
  State<EditJobPage> createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  TextEditingController title = TextEditingController(text: positionConstant);
  TextEditingController description =
      TextEditingController(text: descriptionConstant);
  TextEditingController salary = TextEditingController(text: salaryConstant);
  TextEditingController requirement1 =
      TextEditingController(text: requirementConstant[0]);
  TextEditingController requirement2 =
      TextEditingController(text: requirementConstant[1]);
  TextEditingController requirement3 =
      TextEditingController(text: requirementConstant[2]);
  TextEditingController requirement4 =
      TextEditingController(text: requirementConstant[3]);
  TextEditingController requirement5 =
      TextEditingController(text: requirementConstant[4]);
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
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.arrow_left),
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
                        text: "Perbarui Lowongan",
                        style: appstyle(
                          31,
                          Color(kWhite2.value),
                          FontWeight.bold,
                        ),
                      ),
                      HeightSpacer(size: 20),
                      Form(
                        key: profileProvider.editJobFormKey,
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
                                    HeightSpacer(size: 15),
                                    jobProvider.isLoading
                                        ? LoadingButton(
                                            onTap: () {},
                                          )
                                        : CustomButton(
                                            onTap: () async {
                                              if (profileProvider
                                                  .validateEditJob()) {
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

                                                await jobProvider.editJob(
                                                    jobIdConstant, model);
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
                                            text: "Perbarui",
                                          ),
                                    HeightSpacer(size: 15),
                                    jobProvider.isLoading
                                        ? LoadingButton(
                                            color2: Color(kRed.value),
                                            onTap: () {},
                                          )
                                        : CustomButton(
                                            color2: Color(kRed.value),
                                            onTap: () async {
                                              await jobProvider
                                                  .deleteJob(jobIdConstant);
                                              jobProvider.setIsLoading = false;
                                            },
                                            text: "Hapus",
                                          ),
                                  ],
                                );
                              },
                            ),
                            HeightSpacer(size: 25),
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
