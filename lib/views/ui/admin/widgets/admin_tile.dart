import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/models/response/auth/pending_user_res_model.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/exports.dart';

class AdminTile extends StatefulWidget {
  const AdminTile({
    super.key,
    this.pendingUser,
    this.onTap,
    this.onTapSheet,
  });

  final PendingUserResponse? pendingUser;
  final Function()? onTap;
  final Function()? onTapSheet;

  @override
  State<AdminTile> createState() => _AdminTileState();
}

class _AdminTileState extends State<AdminTile> {
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
    widget.onTapSheet!();
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
          padding: EdgeInsets.only(bottom: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: widget.pendingUser!.username!,
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w400),
                  ),
                  ReusableText(
                    text: widget.pendingUser!.address!,
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w400),
                  ),
                ],
              ),
              CustomOutlineBtn(
                onTap: widget.onTap,
                text: "Setujui",
                color: Color(kWhite.value),
                color2: Color(kGreen.value),
                height: height * 0.05,
                width: width * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
