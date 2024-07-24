import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/admin_provider.dart';
import 'package:jobhub/models/response/auth/pending_user_res_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/heading_widget_admin.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loader.dart';
import 'package:jobhub/views/common/loading_indicator.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/admin/all_agents_page.dart';
import 'package:jobhub/views/ui/admin/all_users_page.dart';
import 'package:jobhub/views/ui/admin/widgets/admin_tile.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Admin",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              HeightSpacer(size: 20),
              HeadingWidgetAdmin(
                text: "Semua Akun Mitra",
                onTap: () {
                  Get.to(
                    () => AllAgentsPage(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 100),
                  );
                },
                onTap2: () {
                  Get.to(
                    () => AllUsersPage(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 100),
                  );
                },
              ),
              HeightSpacer(size: 20),
              Expanded(
                child: Consumer<AdminProvider>(
                  builder: (context, adminProvider, child) {
                    adminProvider.getPendingUser();
                    adminProvider.getAllAgents();
                    adminProvider.getAllUsers();

                    return FutureBuilder<List<PendingUserResponse>>(
                      future: adminProvider.pendingUserList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoadingIndicator();
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error ${snapshot.error}"));
                        } else if (snapshot.data!.isEmpty ||
                            snapshot.data == null) {
                          return NoData(
                              title: "Tidak ada mitra yang belum disetujui");
                        } else {
                          final pendingUserSnapshot = snapshot.data;

                          return Column(
                            children: [
                              ReusableText(
                                text: "Mitra ini belum disetujui",
                                isCentre: true,
                                style: appstyle(15, Color(kWhite2.value),
                                    FontWeight.normal),
                              ),
                              HeightSpacer(size: 35),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: pendingUserSnapshot?.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final pendingUserLists =
                                        pendingUserSnapshot?[index];

                                    return AdminTile(
                                      pendingUser: pendingUserLists,
                                      onTap: () async {
                                        await adminProvider
                                            .moveUser(pendingUserLists?.id);
                                        setState(() {
                                          pendingUserSnapshot?.removeAt(index);
                                        });
                                      },
                                      onTapReject: () async {
                                        await adminProvider
                                            .deleteUser(pendingUserLists?.id);
                                        setState(() {
                                          pendingUserSnapshot?.removeAt(index);
                                        });
                                      },
                                      onTapSheet: () {
                                        pendingSheet(pendingUserLists);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> pendingSheet(PendingUserResponse? pendingUserLists) {
    var adminProviders = Provider.of<AdminProvider>(context, listen: false);
    return Get.bottomSheet(
      Container(
        height: 230.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(kLightGrey.value),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: "Nama Perusahaan :    ${pendingUserLists?.username}",
                style: appstyle(13, Color(kWhite.value), FontWeight.normal),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: "Alamat :    ",
                    style: appstyle(13, Color(kWhite.value), FontWeight.normal),
                  ),
                  Flexible(
                    child: ReusableText(
                      text: pendingUserLists!.address!,
                      style:
                          appstyle(13, Color(kWhite.value), FontWeight.normal),
                    ),
                  )
                ],
              ),
              ReusableText(
                text: "Website :   ${pendingUserLists.website}",
                style: appstyle(13, Color(kWhite.value), FontWeight.normal),
              ),
              HeightSpacer(size: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlineBtn(
                    onTap: () async {
                      await adminProviders.moveUser(pendingUserLists.id);
                      Get.back();
                      setState(() {});
                    },
                    text: "Setujui",
                    color: Color(kWhite.value),
                    color2: Color(kGreen.value),
                    height: height * 0.05,
                    width: width * 0.3,
                  ),
                  WidthSpacer(width: 15.w),
                  CustomOutlineBtn(
                    onTap: () async {
                      await adminProviders.deleteUser(pendingUserLists.id);
                      Get.back();
                      setState(() {});
                    },
                    text: "Tolak",
                    color: Color(kWhite.value),
                    color2: Color(kRed.value),
                    height: height * 0.05,
                    width: width * 0.3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
