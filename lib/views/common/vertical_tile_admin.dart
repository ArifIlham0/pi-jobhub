import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/admin/all_agents_res.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';

class VerticalTileAdmin extends StatefulWidget {
  const VerticalTileAdmin({
    super.key,
    this.allAgents,
    this.isAgent,
    this.onTap,
  });

  final AllAgentsRes? allAgents;
  final bool? isAgent;
  final Function()? onTap;

  @override
  State<VerticalTileAdmin> createState() => _VerticalTileAdminState();
}

class _VerticalTileAdminState extends State<VerticalTileAdmin> {
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
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
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
                          radius: 20,
                          backgroundImage:
                              NetworkImage(widget.allAgents!.profile!),
                        ),
                        WidthSpacer(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              maxLine: false,
                              text: widget.allAgents!.username!,
                              style: appstyle(
                                17,
                                Color(kWhite2.value),
                                FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.55,
                              child: ReusableText(
                                maxLine: false,
                                text: widget.allAgents!.email!,
                                style: appstyle(
                                  15,
                                  Color(kDarkGrey.value),
                                  FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: widget.onTap,
                      icon: CircleAvatar(
                        backgroundColor: Color(kBlack2.value),
                        radius: 18,
                        child: Icon(
                          Ionicons.trash,
                          color: Color(kRed.value),
                        ),
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
