import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/jobs/job_page.dart';

class BookmarkTileWidget extends StatelessWidget {
  const BookmarkTileWidget({
    super.key,
    this.job,
  });

  final AllBookmarks? job;

  @override
  Widget build(BuildContext context) {
    if (job == null || job!.job == null) {
      return SizedBox.shrink();
    }

    final jobDetails = job!.job!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
      child: InkWell(
        onTap: () {
          Get.to(
            () => JobPage(
              title: jobDetails.company,
              id: jobDetails.id,
            ),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 100),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          height: height * 0.15,
          width: width,
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(kWhite.value),
              width: 0.3,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(jobDetails.imageUrl!),
                      ),
                      WidthSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: jobDetails.company!,
                            style: appstyle(
                              20,
                              Color(kWhite2.value),
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              maxLine: false,
                              text: jobDetails.title!,
                              style: appstyle(
                                20,
                                Color(kDarkGrey.value),
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Color(kBlack2.value),
                    radius: 18,
                    child: Icon(
                      Ionicons.chevron_forward,
                      color: Color(kGreen.value),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 65.w),
                child: Row(
                  children: [
                    ReusableText(
                      text: jobDetails.salary!,
                      style: appstyle(
                        22,
                        Color(kWhite2.value),
                        FontWeight.w600,
                      ),
                    ),
                    ReusableText(
                      text: "/${jobDetails.period}",
                      style: appstyle(
                        20,
                        Color(kDarkGrey.value),
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
