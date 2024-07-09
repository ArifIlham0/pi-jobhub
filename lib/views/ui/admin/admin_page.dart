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
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loader.dart';
import 'package:jobhub/views/common/loading_indicator.dart';
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
          child: Consumer<AdminProvider>(
            builder: (context, adminProvider, child) {
              adminProvider.getPendingUser();

              return FutureBuilder<List<PendingUserResponse>>(
                future: adminProvider.pendingUserList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error ${snapshot.error}"));
                  } else if (snapshot.data!.isEmpty || snapshot.data == null) {
                    return NoData(title: "Tidak ada mitra");
                  } else {
                    final pendingUserSnapshot = snapshot.data;

                    return Column(
                      children: [
                        HeightSpacer(size: 25),
                        ReusableText(
                          text: "Mitra ini belum disetujui",
                          isCentre: true,
                          style: appstyle(
                              15, Color(kWhite2.value), FontWeight.normal),
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
                                  setState(() {});
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
      ),
    );
  }

  Future<dynamic> pendingSheet(PendingUserResponse? pendingUserLists) {
    var adminProviders = Provider.of<AdminProvider>(context, listen: false);
    return Get.bottomSheet(
      Container(
        height: 180.h,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: "Nama Perusahaan :    ${pendingUserLists?.username}",
                style: appstyle(13, Color(kWhite.value), FontWeight.normal),
              ),
              ReusableText(
                text: "Alamat :    ${pendingUserLists?.address}",
                style: appstyle(13, Color(kWhite.value), FontWeight.normal),
              ),
              ReusableText(
                text: "Website :    ${pendingUserLists?.website}",
                style: appstyle(13, Color(kWhite.value), FontWeight.normal),
              ),
              HeightSpacer(size: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutlineBtn(
                    onTap: () async {
                      await adminProviders.moveUser(pendingUserLists?.id);
                      Get.back();
                      setState(() {});
                    },
                    text: "Setujui",
                    color: Color(kWhite.value),
                    color2: Color(kGreen.value),
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
