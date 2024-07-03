import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/profile_update_model.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loading_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateAgent extends StatefulWidget {
  const UpdateAgent({super.key});

  @override
  State<UpdateAgent> createState() => _UpdateAgentState();
}

class _UpdateAgentState extends State<UpdateAgent> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<LoginProvider>(
          builder: (context, loginProvider, child) {
            return Form(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 60.h,
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text: "Detail Perusahaan",
                        style: appstyle(
                          28,
                          Color(kWhite2.value),
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<ImageUploader>(
                        builder: (context, imageUploaderProvider, child) {
                          return Column(
                            children: [
                              imageUploaderProvider.imageFile.isEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        imageUploaderProvider.pickImage();
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: Color(kGreen2.value),
                                        child: Center(
                                          child:
                                              Icon(Icons.photo_filter_rounded),
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        imageUploaderProvider.imageFile.clear();
                                        setState(() {});
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: Color(kGreen2.value),
                                        backgroundImage: FileImage(
                                          File(imageUploaderProvider
                                              .imageFile[0]),
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        },
                      ),
                      ReusableText(
                        text: "Upload Logo Perusahaan",
                        style: appstyle(
                          10,
                          Color(kWhite2.value),
                          FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  HeightSpacer(size: 20),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: location,
                          hintText: "Lokasi",
                          keyboardType: TextInputType.text,
                          validator: (location) {
                            if (location!.isEmpty) {
                              return "Tolong masukkan lokasi anda";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: phone,
                          hintText: "Nomor HP",
                          keyboardType: TextInputType.phone,
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return "Tolong masukkan nomor HP anda";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        ReusableText(
                          text: "Bidang Perusahaan",
                          style: appstyle(
                            30,
                            Color(kWhite2.value),
                            FontWeight.bold,
                          ),
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill0,
                          hintText: "Bidang 1",
                          keyboardType: TextInputType.text,
                          validator: (skill0) {
                            if (skill0!.isEmpty) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill1,
                          hintText: "Bidang 2",
                          keyboardType: TextInputType.text,
                          validator: (skill1) {
                            if (skill1!.isEmpty) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill2,
                          hintText: "Bidang 3",
                          keyboardType: TextInputType.text,
                          validator: (skill2) {
                            if (skill2!.isEmpty) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill3,
                          hintText: "Bidang 4",
                          keyboardType: TextInputType.text,
                          validator: (skill3) {
                            if (skill3!.isEmpty) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill4,
                          hintText: "Bidang 5",
                          keyboardType: TextInputType.text,
                          validator: (skill4) {
                            if (skill4!.isEmpty) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 20),
                        Consumer<ImageUploader>(
                            builder: (context, imageUploaderProvider, child) {
                          return loginProvider.isLoading
                              ? LoadingButton(
                                  onTap: () {},
                                )
                              : CustomButton(
                                  onTap: () async {
                                    if (imageUploaderProvider
                                            .imageFile.isEmpty &&
                                        imageUploaderProvider.imageUrl ==
                                            null) {
                                      Get.snackbar(
                                        "Belum upload gambar atau cv!",
                                        "Tolong upload terlebih dahulu",
                                        colorText: Color(kBlack2.value),
                                        backgroundColor: Color(kGreen2.value),
                                        icon: Icon(Icons.add_alert),
                                      );
                                    } else {
                                      loginProvider.setIsLoading = true;
                                      ProfileUpdateReq model = ProfileUpdateReq(
                                        location: location.text,
                                        phone: phone.text,
                                        profile: imageUploaderProvider.imageUrl
                                            .toString(),
                                        cv: imageUploaderProvider.pdfUrl
                                            .toString(),
                                        skills: [
                                          skill0.text,
                                          skill1.text,
                                          skill2.text,
                                          skill3.text,
                                          skill4.text,
                                        ],
                                      );
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool('agent', false);
                                      await loginProvider.updateAgent(model);
                                      loginProvider.setIsLoading = false;
                                      imageUploaderProvider.imageFile.clear();
                                    }
                                  },
                                  text: "Lanjut",
                                );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }
}
