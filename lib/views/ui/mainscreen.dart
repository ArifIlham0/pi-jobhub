import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/drawer/drawer_screen.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/ui/agent/agent_page.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:jobhub/views/ui/auth/profile.dart';
import 'package:jobhub/views/ui/bookmarks/bookmarks.dart';
import 'package:jobhub/views/ui/chat/chat_list.dart';
import 'package:jobhub/views/ui/admin/admin_page.dart';
import 'package:jobhub/views/ui/history/history_page.dart';
import 'package:jobhub/views/ui/homepage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomProvider>(
      builder: (context, zoomProvider, child) {
        return ZoomDrawer(
          menuScreen: DrawerScreen(
            indexSetter: (index) {
              zoomProvider.currentIndex = index;
            },
          ),
          mainScreen: currentScreen(),
          borderRadius: 30,
          showShadow: true,
          angle: 0.0,
          menuBackgroundColor: Color(kGreen2.value),
        );
      },
    );
  }

  Widget currentScreen() {
    var zoomProvider = Provider.of<ZoomProvider>(context);
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    var onBoardProvider = Provider.of<OnBoardProvider>(context);

    switch (zoomProvider.currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return ChatList();
      case 2:
        return BookMarkPage();
      case 3:
        return HistoryList();
      case 4:
        return ProfilePage();
      case 5:
        return AgentPage();
      case 6:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Color(kLightGrey.value),
                title: Text(
                  'Anda yakin ingin keluar?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(kDarkGrey.value),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  TextButton(
                    child: ReusableText(
                      text: "Tidak",
                      style: appstyle(13, Color(kGreen.value), FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: ReusableText(
                      text: "Ya",
                      style: appstyle(13, Color(kGreen.value), FontWeight.w600),
                    ),
                    onPressed: () {
                      onBoardProvider.isLastPage = false;
                      zoomProvider.currentIndex = 0;
                      loginProvider.logout();
                      Get.to(() => LoginPage());
                    },
                  ),
                ],
              );
            },
          );
        });
        return HomePage();
      case 7:
        return AdminPage();
      default:
        return HomePage();
    }
  }
}
