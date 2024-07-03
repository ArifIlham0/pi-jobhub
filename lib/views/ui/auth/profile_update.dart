import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/profile_update_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:provider/provider.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({
    super.key,
    this.isAgent,
  });

  final bool? isAgent;

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController phone = TextEditingController(text: phoneConstant);
  TextEditingController location =
      TextEditingController(text: locationConstant);
  TextEditingController skill0 = TextEditingController(text: profileSkills[0]);
  TextEditingController skill1 = TextEditingController(text: profileSkills[1]);
  TextEditingController skill2 = TextEditingController(text: profileSkills[2]);
  TextEditingController skill3 = TextEditingController(text: profileSkills[3]);
  TextEditingController skill4 = TextEditingController(text: profileSkills[4]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Perbarui Profile",
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          return Form(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: "Detail Profil",
                      style: appstyle(
                        35,
                        Color(kWhite2.value),
                        FontWeight.bold,
                      ),
                    ),
                    Consumer<ImageUploader>(
                      builder: (context, imageUploaderProvider, child) {
                        imageUploaderProvider.imageFile.clear();

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
                                        child: Icon(Icons.photo_filter_rounded),
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
                                        File(
                                            imageUploaderProvider.imageFile[0]),
                                      ),
                                    ),
                                  ),
                            widget.isAgent != true
                                ? IconButton(
                                    onPressed: () {
                                      imageUploaderProvider.pickPdf();
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: Color(kGreen.value),
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
                                  )
                                : SizedBox.shrink(),
                          ],
                        );
                      },
                    )
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
                            return "Please enter a valid location";
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
                            return "Please enter a valid number";
                          } else {
                            return null;
                          }
                        },
                      ),
                      HeightSpacer(size: 10),
                      ReusableText(
                        text: widget.isAgent != true
                            ? "Profesional Skills"
                            : "Bidang Perusahaan",
                        style: appstyle(
                          28,
                          Color(kWhite2.value),
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
                                  "Image missing",
                                  "Please upload an image to proceed",
                                  colorText: Color(kBlack2.value),
                                  backgroundColor: Color(kGreen2.value),
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
                              }
                            },
                            text: "Perbarui",
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
