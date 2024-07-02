import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/width_spacer.dart';

class JobHorizontalTile extends StatelessWidget {
  const JobHorizontalTile({
    super.key,
    this.onTap,
    this.job,
  });

  final Function()? onTap;
  final JobsResponse? job;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          width: width * 0.7,
          height: height * 0.27,
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(job!.imageUrl),
                  ),
                  WidthSpacer(width: 15),
                  ReusableText(
                    text: job!.company,
                    style: appstyle(26, Color(kDark.value), FontWeight.w600),
                  ),
                ],
              ),
              HeightSpacer(size: 15),
              ReusableText(
                text: job!.title,
                style: appstyle(18, Color(kDark.value), FontWeight.w600),
              ),
              ReusableText(
                text: job!.location,
                style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
              ),
              HeightSpacer(size: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ReusableText(
                        text: job!.salary,
                        style:
                            appstyle(20, Color(kDark.value), FontWeight.w600),
                      ),
                      ReusableText(
                        text: "/${job!.period}",
                        style: appstyle(
                            23, Color(kDarkGrey.value), FontWeight.w600),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(kLight.value),
                    child: Icon(Ionicons.chevron_forward),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
