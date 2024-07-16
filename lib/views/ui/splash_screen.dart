import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:jobhub/views/ui/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  void navigateUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final entrypoint = prefs.getBool('entrypoint') ?? false;
    final loggedIn = prefs.getBool('loggedIn') ?? false;
    String? token = prefs.getString("token");
    String? tokenTime = prefs.getString("tokenTime");

    if (token != null && tokenTime != null) {
      DateTime storedTime = DateTime.parse(tokenTime);
      DateTime now = DateTime.now();

      if (now.difference(storedTime).inDays > 19) {
        await prefs.remove("token");
        await prefs.remove("tokenTime");
        token = null;
      }
    }

    print("token ${token}");

    await Future.delayed(Duration(seconds: 1), () {
      if (entrypoint & !loggedIn & (token == null || token.isEmpty)) {
        Get.offAll(() => OnBoardingScreen());
      } else if (entrypoint && loggedIn && token != null && token.isNotEmpty) {
        Get.offAll(() => MainScreen());
      } else {
        Get.offAll(() => OnBoardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 120.w,
          height: 120.h,
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
