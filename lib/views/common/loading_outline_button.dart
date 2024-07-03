import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/width_spacer.dart';

class LoadingOutlineButton extends StatelessWidget {
  const LoadingOutlineButton({
    super.key,
    this.width,
    this.height,
    this.text,
    this.onTap,
    this.color,
    this.color2,
  });

  final double? width;
  final double? height;
  final String? text;
  final void Function()? onTap;
  final Color? color;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color2),
        minimumSize: MaterialStateProperty.all(Size(width ?? 0, height ?? 0)),
        overlayColor:
            MaterialStateProperty.all(Color(kLight.value).withOpacity(0.2)),
        maximumSize: MaterialStateProperty.all(
            Size(width ?? double.infinity, height ?? double.infinity)),
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
            child: CircularProgressIndicator(color: Color(kLight.value)),
          ),
          WidthSpacer(width: 10),
          ReusableText(
            text: "Loading..",
            style: appstyle(16, color ?? Color(kLight.value), FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
