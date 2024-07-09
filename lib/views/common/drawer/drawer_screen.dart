import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key, this.indexSetter});

  final ValueSetter? indexSetter;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile();

    return Consumer<ZoomProvider>(
      builder: (context, zoomProvider, child) {
        return Container(
          child: GestureDetector(
            onTap: () {
              ZoomDrawer.of(context)!.toggle();
            },
            child: Scaffold(
              backgroundColor: Color(kGreen2.value),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  drawerItem(
                    AntDesign.home,
                    "Beranda",
                    0,
                    zoomProvider.currentIndex == 0
                        ? Color(kWhite.value)
                        : Color(kLightGrey.value),
                  ),
                  drawerItem(
                    Ionicons.chatbubble_outline,
                    "Chats",
                    1,
                    zoomProvider.currentIndex == 1
                        ? Color(kWhite.value)
                        : Color(kLightGrey.value),
                  ),
                  drawerItem(
                    Fontisto.bookmark,
                    "Bookmarks",
                    2,
                    zoomProvider.currentIndex == 2
                        ? Color(kWhite.value)
                        : Color(kLightGrey.value),
                  ),
                  drawerItem(
                    MaterialCommunityIcons.history,
                    "Riwayat",
                    3,
                    zoomProvider.currentIndex == 3
                        ? Color(kWhite.value)
                        : Color(kLightGrey.value),
                  ),
                  drawerItem(
                    FontAwesome5Regular.user_circle,
                    "Profil",
                    4,
                    zoomProvider.currentIndex == 4
                        ? Color(kWhite.value)
                        : Color(kLightGrey.value),
                  ),
                  FutureBuilder<ProfileRes>(
                    future: profileProvider.profile,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox();
                      } else if (snapshot.hasError) {
                        return Text("Error ${snapshot.error}");
                      } else {
                        ProfileRes profile = snapshot.data!;

                        return profile.isAgent || profile.isAdmin == true
                            ? drawerItem(
                                Icons.admin_panel_settings,
                                "Mitra",
                                5,
                                zoomProvider.currentIndex == 5
                                    ? Color(kWhite.value)
                                    : Color(kLightGrey.value),
                              )
                            : SizedBox.shrink();
                      }
                    },
                  ),
                  drawerItem(
                    MaterialCommunityIcons.logout,
                    "Keluar",
                    6,
                    zoomProvider.currentIndex == 4
                        ? Color(kWhite.value)
                        : Color(kLightGrey.value),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget drawerItem(IconData icon, String text, int index, Color color) {
    return GestureDetector(
      onTap: () {
        widget.indexSetter!(index);
        ZoomDrawer.of(context)!.close();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
        child: Row(
          children: [
            Icon(icon, color: color),
            WidthSpacer(width: 12),
            ReusableText(
              text: text,
              style: appstyle(12, color, FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
