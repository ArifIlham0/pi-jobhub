import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/pdf_viewer.dart.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:jobhub/views/ui/auth/profile_update.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var zoomProvider = Provider.of<ZoomProvider>(context);
    var onBoardProvider = Provider.of<OnBoardProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Profil",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          profileProvider.getProfile();

          return FutureBuilder(
            future: profileProvider.profile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text("Error: ${snapshot.error}");
              } else {
                final profileSnapshot = snapshot.data;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        width: width,
                        height: height * 0.12,
                        color: Color(kBlack2.value),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: CachedNetworkImage(
                                    imageUrl: profileSnapshot!.profile,
                                    width: 80.w,
                                    height: 100.h,
                                  ),
                                ),
                                WidthSpacer(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ReusableText(
                                      text: profileSnapshot.username,
                                      style: appstyle(20, Color(kWhite2.value),
                                          FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          MaterialIcons.location_pin,
                                          color: Color(kDarkGrey.value),
                                        ),
                                        WidthSpacer(width: 5),
                                        ReusableText(
                                          text: profileSnapshot.location,
                                          style: appstyle(
                                              16,
                                              Color(kDarkGrey.value),
                                              FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                profileSkills = profileSnapshot.skills;
                                locationConstant = profileSnapshot.location;
                                phoneConstant = profileSnapshot.phone;
                                Get.to(
                                  () => ProfileUpdate(
                                      isAgent: profileSnapshot.isAgent),
                                  transition: Transition.rightToLeft,
                                  duration: Duration(milliseconds: 100),
                                );
                              },
                              icon: Icon(
                                Feather.edit,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      HeightSpacer(size: 20),
                      Stack(
                        children: [
                          profileSnapshot.isAgent != true
                              ? InkWell(
                                  onTap: () async {
                                    final String pdfUrl = profileSnapshot.cv;
                                    File file = await profileProvider
                                        .downloadFile(pdfUrl, 'document.pdf');
                                    Get.to(
                                      () => PDFViewerPage(url: file.path),
                                      transition: Transition.rightToLeft,
                                      duration: Duration(milliseconds: 100),
                                    );
                                  },
                                  child: Container(
                                    width: width,
                                    height: height * 0.12,
                                    decoration: BoxDecoration(
                                      color: Color(kLightGrey.value),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 12.w),
                                          width: 60.w,
                                          height: 70.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(kBlack2.value),
                                          ),
                                          child: Icon(
                                            FontAwesome5Regular.file_pdf,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        ),
                                        ReusableText(
                                          text: "CV Kamu",
                                          style: appstyle(
                                              18,
                                              Color(kWhite2.value),
                                              FontWeight.w500),
                                        ),
                                        WidthSpacer(width: 1),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      HeightSpacer(size: 20),
                      Container(
                        padding: EdgeInsets.only(left: 14.w),
                        width: width,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          color: Color(kLightGrey.value),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ReusableText(
                            text: profileSnapshot.email,
                            style: appstyle(
                                16, Color(kWhite2.value), FontWeight.w600),
                          ),
                        ),
                      ),
                      HeightSpacer(size: 20),
                      Container(
                        padding: EdgeInsets.only(left: 14.w),
                        width: width,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          color: Color(kLightGrey.value),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/indonesia.png",
                                width: 20.w,
                                height: 20.h,
                              ),
                              WidthSpacer(width: 15),
                              ReusableText(
                                text: profileSnapshot.phone,
                                style: appstyle(
                                    16, Color(kWhite2.value), FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      HeightSpacer(size: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(kLightGrey.value),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 14.w),
                              child: ReusableText(
                                text: profileSnapshot.isAgent != true
                                    ? "Skills"
                                    : "Bidang Perusahaan",
                                style: appstyle(
                                    16, Color(kWhite2.value), FontWeight.w600),
                              ),
                            ),
                            HeightSpacer(size: 3),
                            SizedBox(
                              height: height * 0.5,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 8.h),
                                child: ListView.builder(
                                  itemCount: profileSnapshot.skills.length,
                                  itemBuilder: (context, index) {
                                    final skill = profileSnapshot.skills[index];

                                    return Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        width: width,
                                        height: height * 0.06,
                                        color: Color(kBlack2.value),
                                        child: Row(
                                          children: [
                                            ReusableText(
                                              text: skill,
                                              style: appstyle(
                                                  16,
                                                  Color(kWhite2.value),
                                                  FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<LoginProvider>(
                        builder: (context, loginProvider, child) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 90.w),
                            child: TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Color(kGreen.value).withOpacity(0.2)),
                              ),
                              onPressed: () {
                                onBoardProvider.isLastPage = false;
                                zoomProvider.currentIndex = 0;
                                loginProvider.logout();
                                Get.to(() => LoginPage());
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ReusableText(
                                  text: "Keluar",
                                  style: appstyle(
                                      16, Color(kGreen.value), FontWeight.w600),
                                ),
                              ),
                            ),
                          );
                        },
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
