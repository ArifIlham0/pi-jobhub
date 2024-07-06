import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:shimmer/shimmer.dart';

class VerticalShimmer extends StatelessWidget {
  const VerticalShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(kWhite.value),
      highlightColor: Color(kWhite.value).withOpacity(0.8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 120.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(kLightGrey.value).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.transparent,
            width: 0.3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 25,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: Color(kWhite.value),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            width: 150.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: Color(kWhite.value),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                      WidthSpacer(width: 40),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(kBlack.value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, bottom: 8.h),
              child: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Color(kWhite.value),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    width: 50.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Color(kWhite.value),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
