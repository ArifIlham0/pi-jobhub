import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kDarkPurple.value),
        child: Column(
          children: [
            HeightSpacer(size: 50),
            Image.asset("assets/images/page1.png"),
            HeightSpacer(size: 40),
            Column(
              children: [
                ReusableText(
                  text: "Temukan Pekerjaan Impianmu!",
                  style: appstyle(20, Color(kLight.value), FontWeight.w500),
                ),
                HeightSpacer(size: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    "Kami membantu karir mu dengan memberikan informasi lowongan pekerjaan terbaik",
                    style: appstyle(11, Color(kLight.value), FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
