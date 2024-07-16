import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/agent/edit_job_agent.dart';
import 'package:jobhub/views/ui/jobs/job_page.dart';

class VerticalTileWidget extends StatefulWidget {
  const VerticalTileWidget({super.key, this.job, this.isAgent});

  final JobsResponse? job;
  final bool? isAgent;

  @override
  State<VerticalTileWidget> createState() => _VerticalTileWidgetState();
}

class _VerticalTileWidgetState extends State<VerticalTileWidget> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, right: 4.w),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: Duration(milliseconds: 100),
        child: GestureDetector(
          onTapCancel: _onTapCancel,
          onTapDown: _onTapDown,
          onTap: () {
            jobIdConstant = widget.job!.id;
            positionConstant = widget.job!.title;
            categoryConstant = widget.job!.category!;
            descriptionConstant = widget.job!.description;
            salaryConstant = widget.job!.salary;
            periodConstant = widget.job!.period;
            requirementConstant = widget.job!.requirements;
            setState(() {
              _isPressed = false;
            });

            widget.isAgent != true
                ? Get.to(
                    () => JobPage(
                      title: widget.job!.company,
                      id: widget.job!.id,
                    ),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 100),
                  )
                : Get.to(
                    () => EditJobPage(),
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
                          backgroundImage: NetworkImage(widget.job!.imageUrl),
                        ),
                        WidthSpacer(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              maxLine: false,
                              text: widget.job!.company,
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
                                text: widget.job!.title,
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
                        text: widget.job!.salary,
                        style: appstyle(
                          22,
                          Color(kWhite2.value),
                          FontWeight.w600,
                        ),
                      ),
                      ReusableText(
                        text: "/${widget.job!.period}",
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
      ),
    );
  }
}
