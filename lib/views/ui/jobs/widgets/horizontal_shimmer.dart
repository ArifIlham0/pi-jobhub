import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalShimmer extends StatelessWidget {
  const HorizontalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(kWhite.value),
      highlightColor: Color(kWhite.value).withOpacity(0.8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.27,
        decoration: BoxDecoration(
          color: Color(kLightGrey.value).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.transparent,
            width: 0.3,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(kWhite.value),
                  radius: 25,
                ),
                SizedBox(width: 15.w),
                Container(
                  width: 150.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Color(kWhite.value),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Container(
              width: 200.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Color(kWhite.value),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: 100.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Color(kWhite.value),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Color(kWhite.value),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Color(kWhite.value),
                  radius: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
