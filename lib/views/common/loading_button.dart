import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key, this.color, this.onTap});

  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(kGreen.value)),
        minimumSize: MaterialStateProperty.all(Size(width, height * 0.065)),
        overlayColor:
            MaterialStateProperty.all(Color(kBlack2.value).withOpacity(0.2)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
            width: 20.w,
            child: CircularProgressIndicator(color: Color(kWhite.value)),
          ),
          WidthSpacer(width: 10),
          ReusableText(
            text: "Loading..",
            style: appstyle(16, color ?? Color(kWhite.value), FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
