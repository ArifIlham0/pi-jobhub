import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/views/common/exports.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    this.title,
    this.isCentre,
  });

  final String? title;
  final bool? isCentre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/optimized_search.png"),
          ReusableText(
            text: title!,
            isCentre: isCentre,
            style: appstyle(24, Color(kWhite2.value), FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
