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
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
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
                        text: "Personal Details",
                        style: appstyle(
                          35,
                          Color(kDark.value),
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  imageUploaderProvider.imageFile.isEmpty
                                      ? IconButton(
                                          onPressed: () {
                                            imageUploaderProvider.pickImage();
                                          },
                                          icon: CircleAvatar(
                                            backgroundColor:
                                                Color(kLightBlue.value),
                                            child: Center(
                                              child: Icon(
                                                  Icons.photo_filter_rounded),
                                            ),
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            imageUploaderProvider.imageFile
                                                .clear();
                                            setState(() {});
                                          },
                                          icon: CircleAvatar(
                                            backgroundColor:
                                                Color(kLightBlue.value),
                                            backgroundImage: FileImage(
                                              File(imageUploaderProvider
                                                  .imageFile[0]),
                                            ),
                                          ),
                                        ),
                                  ReusableText(
                                    text: "Upload gambar profil",
                                    style: appstyle(
                                      10,
                                      Color(kDark.value),
                                      FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await imageUploaderProvider.pickPdf();
                                      setState(() {
                                        imageUploaderProvider.pdfUrl =
                                            imageUploaderProvider.pdfUrl;
                                      });
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Color(kOrange.value),
                                      child: Center(
                                        child: Icon(
                                            imageUploaderProvider.pdfUrl ==
                                                        null ||
                                                    imageUploaderProvider
                                                        .pdfUrl!.isEmpty
                                                ? Icons.picture_as_pdf
                                                : Icons.done),
                                      ),
                                    ),
                                  ),
                                  ReusableText(
                                    text: "Upload Cv",
                                    style: appstyle(
                                      10,
                                      Color(kDark.value),
                                      FontWeight.normal,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      )
                    ],
                  ),
                  HeightSpacer(size: 10),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: location,
                          hintText: "Location",
                          keyboardType: TextInputType.text,
                          validator: (location) {
                            if (location!.isEmpty) {
                              return "Please enter a valid location";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: phone,
                          hintText: "Phone Number",
                          keyboardType: TextInputType.phone,
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return "Please enter a valid number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        ReusableText(
                          text: "Profesional Skills",
                          style: appstyle(
                            30,
                            Color(kDark.value),
                            FontWeight.bold,
                          ),
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill0,
                          hintText: "Skill 1",
                          keyboardType: TextInputType.text,
                          validator: (skill0) {
                            if (skill0!.isEmpty) {
                              return "Please enter a valid number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill1,
                          hintText: "Skill 2",
                          keyboardType: TextInputType.text,
                          validator: (skill1) {
                            if (skill1!.isEmpty) {
                              return "Please enter a valid number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill2,
                          hintText: "Skill 3",
                          keyboardType: TextInputType.text,
                          validator: (skill2) {
                            if (skill2!.isEmpty) {
                              return "Please enter a valid number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill3,
                          hintText: "Skill 4",
                          keyboardType: TextInputType.text,
                          validator: (skill3) {
                            if (skill3!.isEmpty) {
                              return "Please enter a valid number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 10),
                        CustomTextField(
                          controller: skill4,
                          hintText: "Skill 5",
                          keyboardType: TextInputType.text,
                          validator: (skill4) {
                            if (skill4!.isEmpty) {
                              return "Please enter a valid number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        HeightSpacer(size: 20),
                        Consumer<ImageUploader>(
                            builder: (context, imageUploaderProvider, child) {
                          return CustomButton(
                            onTap: () {
                              if (imageUploaderProvider.imageFile.isEmpty &&
                                  imageUploaderProvider.imageUrl == null) {
                                Get.snackbar(
                                  "Belum upload gambar atau cv!",
                                  "Tolong upload terlebih dahulu",
                                  colorText: Color(kLight.value),
                                  backgroundColor: Color(kLightBlue.value),
                                  icon: Icon(Icons.add_alert),
                                );
                              } else {
                                ProfileUpdateReq model = ProfileUpdateReq(
                                  location: location.text,
                                  phone: phone.text,
                                  profile:
                                      imageUploaderProvider.imageUrl.toString(),
                                  cv: imageUploaderProvider.pdfUrl.toString(),
                                  skills: [
                                    skill0.text,
                                    skill1.text,
                                    skill2.text,
                                    skill3.text,
                                    skill4.text,
                                  ],
                                );

                                loginProvider.updateProfile(model);
                                imageUploaderProvider.imageFile.clear();
                              }
                            },
                            text: "Update Profile",
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
