import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobhub/views/common/exports.dart';

class CustomOutlineBtn extends StatelessWidget {
  const CustomOutlineBtn({
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
            MaterialStateProperty.all(Color(kBlack2.value).withOpacity(0.2)),
        maximumSize: MaterialStateProperty.all(
            Size(width ?? double.infinity, height ?? double.infinity)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
      child: Center(
        child: ReusableText(
          text: text!,
          style: appstyle(16, color!, FontWeight.w600),
        ),
      ),
    );
  }
}
