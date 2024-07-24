import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/admin_provider.dart';
import 'package:jobhub/models/response/admin/all_agents_res.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/vertical_shimmer.dart';
import 'package:jobhub/views/common/vertical_tile_admin.dart';
import 'package:provider/provider.dart';

class AllAgentsPage extends StatefulWidget {
  const AllAgentsPage({super.key});

  @override
  State<AllAgentsPage> createState() => _AllAgentsPageState();
}

class _AllAgentsPageState extends State<AllAgentsPage> {
  @override
  Widget build(BuildContext context) {
    var agentProvider = Provider.of<AdminProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Semua Akun Mitra",
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: FutureBuilder<List<AllAgentsRes>>(
        future: agentProvider.agentList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return VerticalShimmer();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final agentListSnapshot = snapshot.data;

            return Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 15.h),
              child: ListView.builder(
                itemCount: agentListSnapshot?.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final agentLists = agentListSnapshot![index];

                  return VerticalTileAdmin(
                    allAgents: agentLists,
                    onTap: () async {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: Color(kLightGrey.value),
                          title: ReusableText(
                            text: "Hapus",
                            isCentre: true,
                            style: appstyle(
                                15, Color(kDarkGrey.value), FontWeight.w700),
                          ),
                          content: ReusableText(
                            isCentre: true,
                            text: "Apakah anda yakin ingin menghapus akun ini?",
                            style: appstyle(
                                15, Color(kDarkGrey.value), FontWeight.normal),
                          ),
                          actions: [
                            TextButton(
                              child: ReusableText(
                                text: "Tidak",
                                style: appstyle(
                                    15, Color(kGreen.value), FontWeight.normal),
                              ),
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Color(kWhite2.value).withOpacity(0.1)),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            TextButton(
                              child: ReusableText(
                                text: "Ya",
                                style: appstyle(
                                    15, Color(kGreen.value), FontWeight.normal),
                              ),
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Color(kWhite2.value).withOpacity(0.1)),
                              ),
                              onPressed: () async {
                                await agentProvider
                                    .deleteAgentOrUser(agentLists.id);
                                Get.back();
                                setState(() {
                                  agentListSnapshot.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
