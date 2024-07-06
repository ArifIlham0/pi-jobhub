import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:shimmer/shimmer.dart';

class VerticalChatShimmer extends StatelessWidget {
  const VerticalChatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Shimmer.fromColors(
          baseColor: Color(kWhite.value),
          highlightColor: Color(kWhite.value).withOpacity(0.8),
          child: Container(
            height: 80.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(kLightGrey.value).withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(
                color: Colors.transparent,
                width: 0.3,
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(right: 8.w, left: 10.w),
              minLeadingWidth: 0,
              minVerticalPadding: 0,
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Color(kWhite.value),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Color(kWhite.value),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(height: 5),
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
              trailing: Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                        color: Color(kWhite.value),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Icon(
                      Icons.circle,
                      color: Color(kWhite.value),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
