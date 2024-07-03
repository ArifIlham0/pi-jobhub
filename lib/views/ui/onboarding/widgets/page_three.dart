import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:jobhub/views/ui/auth/signup.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kGreen2.value),
        child: Column(
          children: [
            Image.asset("assets/images/page3.png"),
            HeightSpacer(size: 17),
            ReusableText(
              text: "Selamat Datang!",
              style: appstyle(20, Color(kBlack2.value), FontWeight.w600),
            ),
            HeightSpacer(size: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text("Temukan pekerjaan impianmu dengan mudah dan cepat!",
                  style: appstyle(10, Color(kBlack2.value), FontWeight.normal),
                  textAlign: TextAlign.center),
            ),
            HeightSpacer(size: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('entrypoint', true);
                    Get.to(() => LoginPage());
                  },
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                      color: Color(kGreen2.value),
                      borderRadius: BorderRadius.circular(7),
                      border:
                          Border.all(color: Color(kBlack2.value), width: 2.w),
                    ),
                    child: Center(
                      child: ReusableText(
                        text: "Login",
                        style:
                            appstyle(16, Color(kBlack2.value), FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => RegistrationPage());
                  },
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                      color: Color(kBlack2.value),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: ReusableText(
                        text: "Sign Up",
                        style:
                            appstyle(16, Color(kGreen2.value), FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            HeightSpacer(size: 10),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                    Color(kBlack2.value).withOpacity(0.1)),
              ),
              onPressed: () {
                Get.to(() => MainScreen());
              },
              child: ReusableText(
                text: "Lanjut tanpa login",
                style: appstyle(12, Color(kBlack2.value), FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
