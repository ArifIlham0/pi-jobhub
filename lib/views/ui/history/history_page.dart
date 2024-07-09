import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/chat_provider.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/models/response/chats/get_chat.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loader.dart';
import 'package:jobhub/views/common/vertical_chat_shimmer.dart';
import 'package:jobhub/views/common/vertical_shimmer.dart';
import 'package:jobhub/views/ui/chat/chat_page.dart';
import 'package:jobhub/views/ui/jobs/widgets/job_tile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    var jobList = Provider.of<JobsProvider>(context, listen: false);
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Riwayat",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: FutureBuilder<ProfileRes>(
        future: profileProvider.profile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            ProfileRes profile = snapshot.data!;

            return profile.isAgent || profile.isAdmin == true
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 15.h),
                        child: Text(
                          "Riwayat lowongan yang anda buat",
                          style: appstyle(
                              16, Color(kWhite2.value), FontWeight.normal),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: Future.wait([
                            SharedPreferences.getInstance(),
                            jobList.jobsList,
                          ]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return VerticalShimmer();
                            } else if (snapshot.hasError) {
                              return Text("Error ${snapshot.error}");
                            } else if (snapshot.hasData == false ||
                                snapshot.data!.isEmpty) {
                              return NoData(
                                  title: "Anda belum membuat lowongan");
                            } else {
                              final prefs =
                                  snapshot.data![0] as SharedPreferences;
                              final userId = prefs.getString('userId');
                              final jobListSnapshot =
                                  snapshot.data![1] as List<JobsResponse>;

                              final filteredJobList = jobListSnapshot
                                  .where((job) => job.agentId == userId)
                                  .toList();

                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 12.w, right: 12.w, top: 15.h),
                                child: ListView.builder(
                                  itemCount: filteredJobList.length,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final jobLists = filteredJobList[index];

                                    return VerticalTileWidget(
                                      job: jobLists,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : Consumer<ChatProvider>(
                    builder: (context, chatProvider, child) {
                      chatProvider.getChat();
                      chatProvider.getUserId();
                      return FutureBuilder<List<GetChats>>(
                        future: chatProvider.chats,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  VerticalChatShimmer(),
                                  VerticalChatShimmer(),
                                  VerticalChatShimmer(),
                                  VerticalChatShimmer(),
                                  VerticalChatShimmer(),
                                  VerticalChatShimmer(),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.data!.isEmpty) {
                            return NoData(
                              title: "Anda belum pernah melamar pekerjaan",
                              isCentre: true,
                            );
                          } else {
                            final chatSnapshot = snapshot.data;
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 15.h),
                                  child: Text(
                                    "Riwayat perusahaan yang kamu lamar",
                                    style: appstyle(15, Color(kWhite2.value),
                                        FontWeight.normal),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.fromLTRB(
                                        20.w, 10.h, 20.w, 0),
                                    itemCount: chatSnapshot?.length,
                                    itemBuilder: (context, index) {
                                      final chat = chatSnapshot?[index];
                                      var user = chat?.users!.where((user) =>
                                          user.id != chatProvider.userId);
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => ChatPage(
                                                title: user.first.username,
                                                id: chat?.id,
                                                profile: user.first.profile,
                                                user: [
                                                  chat!.users![0].id!,
                                                  chat.users![1].id!
                                                ],
                                              ),
                                              transition:
                                                  Transition.rightToLeft,
                                              duration:
                                                  Duration(milliseconds: 100),
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h),
                                            child: Container(
                                              height: 80.h,
                                              width: width,
                                              decoration: BoxDecoration(
                                                color: Color(kLightGrey.value),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                border: Border.all(
                                                  color: Color(kWhite.value),
                                                  width: 0.3,
                                                ),
                                              ),
                                              child: ListTile(
                                                contentPadding: EdgeInsets.only(
                                                    right: 8.w, left: 10.w),
                                                minLeadingWidth: 0,
                                                minVerticalPadding: 0,
                                                leading: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      user!.first.profile!),
                                                ),
                                                title: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ReusableText(
                                                      text:
                                                          user.first.username!,
                                                      style: appstyle(
                                                        16,
                                                        Color(kWhite2.value),
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                    HeightSpacer(size: 5),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          MaterialIcons
                                                              .location_pin,
                                                          color: Color(
                                                              kDarkGrey.value),
                                                          size: 20,
                                                        ),
                                                        ReusableText(
                                                          maxLine: false,
                                                          text: user
                                                              .first.location!,
                                                          style: appstyle(
                                                            16,
                                                            Color(kDarkGrey
                                                                .value),
                                                            FontWeight.normal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                trailing: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 4.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ReusableText(
                                                        text: chatProvider
                                                            .messageTime(chat
                                                                ?.updatedAt
                                                                .toString()),
                                                        style: appstyle(
                                                          12,
                                                          Color(kWhite2.value),
                                                          FontWeight.normal,
                                                        ),
                                                      ),
                                                      Icon(
                                                        chat?.chatName ==
                                                                chatProvider
                                                                    .userId
                                                            ? Ionicons
                                                                .arrow_forward_circle_outline
                                                            : Ionicons
                                                                .arrow_back_circle_outline,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
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
                  );
          }
        },
      ),
    );
  }
}
