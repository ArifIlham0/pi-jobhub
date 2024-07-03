import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/chat_provider.dart';
import 'package:jobhub/models/response/chats/get_chat.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loader.dart';
import 'package:jobhub/views/ui/chat/chat_page.dart';
import 'package:provider/provider.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Chats",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          chatProvider.getChat();
          chatProvider.getUserId();
          return FutureBuilder<List<GetChats>>(
            future: chatProvider.chats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data!.isEmpty) {
                return NoData(title: "No Chats Available");
              } else {
                final chatSnapshot = snapshot.data;
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                  itemCount: chatSnapshot?.length,
                  itemBuilder: (context, index) {
                    final chat = chatSnapshot?[index];
                    var user = chat?.users!
                        .where((user) => user.id != chatProvider.userId);
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => ChatPage(
                              title: user.first.username,
                              id: chat.id,
                              profile: user.first.profile,
                              user: [chat.users![0].id!, chat.users![1].id!],
                            ),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 100),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Container(
                            height: 80.h,
                            width: width,
                            decoration: BoxDecoration(
                              color: Color(kLightGrey.value),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              border: Border.all(
                                color: Color(kWhite.value),
                                width: 0.3,
                              ),
                            ),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.only(right: 8.w, left: 10.w),
                              minLeadingWidth: 0,
                              minVerticalPadding: 0,
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage(user!.first.profile!),
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    text: user.first.username!,
                                    style: appstyle(
                                      16,
                                      Color(kWhite2.value),
                                      FontWeight.w600,
                                    ),
                                  ),
                                  HeightSpacer(size: 5),
                                  ReusableText(
                                    maxLine: false,
                                    text: chat!.latestMessage!.content!,
                                    style: appstyle(
                                      16,
                                      Color(kDarkGrey.value),
                                      FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                      text: chatProvider.messageTime(
                                          chat.updatedAt.toString()),
                                      style: appstyle(
                                        12,
                                        Color(kWhite2.value),
                                        FontWeight.normal,
                                      ),
                                    ),
                                    Icon(
                                      chat.chatName == chatProvider.userId
                                          ? Ionicons
                                              .arrow_forward_circle_outline
                                          : Ionicons.arrow_back_circle_outline,
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
                );
              }
            },
          );
        },
      ),
    );
  }
}
