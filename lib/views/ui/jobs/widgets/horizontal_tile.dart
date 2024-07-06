import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/width_spacer.dart';

class JobHorizontalTile extends StatefulWidget {
  const JobHorizontalTile({
    super.key,
    this.onTap,
    this.job,
  });

  final Function()? onTap;
  final JobsResponse? job;

  @override
  State<JobHorizontalTile> createState() => _JobHorizontalTileState();
}

class _JobHorizontalTileState extends State<JobHorizontalTile> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp() {
    setState(() {
      _isPressed = false;
    });
    widget.onTap!();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.95 : 1.0,
      duration: Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: _onTapUp,
        onTapCancel: _onTapCancel,
        onTapDown: _onTapDown,
        child: Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            width: width * 0.7,
            height: height * 0.27,
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
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.job!.imageUrl),
                    ),
                    WidthSpacer(width: 15),
                    ReusableText(
                      text: widget.job!.company,
                      style:
                          appstyle(26, Color(kWhite2.value), FontWeight.w600),
                    ),
                  ],
                ),
                HeightSpacer(size: 15),
                ReusableText(
                  text: widget.job!.title,
                  style: appstyle(18, Color(kWhite2.value), FontWeight.w600),
                ),
                ReusableText(
                  text: widget.job!.location,
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                ),
                HeightSpacer(size: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ReusableText(
                          text: widget.job!.salary,
                          style: appstyle(
                              20, Color(kWhite2.value), FontWeight.w600),
                        ),
                        ReusableText(
                          text: "/${widget.job!.period}",
                          style: appstyle(
                              20, Color(kDarkGrey.value), FontWeight.w600),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(kBlack2.value),
                      child: Icon(
                        Ionicons.chevron_forward,
                        color: Color(kGreen.value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
