import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/height_spacer.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kBlack2.value),
        child: Column(
          children: [
            HeightSpacer(size: 40),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Image.asset(
                "assets/images/page2.png",
                width: 400.w,
                height: 400.h,
              ),
            ),
            HeightSpacer(size: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Temukan Pekerjaan\nSesuai Passionmu!",
                  style: appstyle(20, Color(kWhite.value), FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                HeightSpacer(size: 10),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
                  child: Text(
                    "Kami membantu karir mu dengan memberikan informasi lowongan pekerjaan terbaik",
                    style: appstyle(12, Color(kWhite.value), FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
