import 'package:flutter/material.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.text, this.color, this.onTap});

  final String? text;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(kOrange.value)),
        minimumSize: MaterialStateProperty.all(Size(width, height * 0.065)),
        overlayColor:
            MaterialStateProperty.all(Color(kLight.value).withOpacity(0.2)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
      child: Center(
        child: ReusableText(
          text: text!,
          style: appstyle(16, color ?? Color(kLight.value), FontWeight.w600),
        ),
      ),
    );
  }
}
