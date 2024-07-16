import 'package:flutter/material.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/loading_indicator.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    this.color,
    this.onTap,
    this.isButton,
    this.color2,
  });

  final Color? color;
  final Color? color2;
  final void Function()? onTap;
  final bool? isButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            color2 == null ? Color(kGreen.value) : color2),
        minimumSize: MaterialStateProperty.all(Size(width, height * 0.065)),
        overlayColor:
            MaterialStateProperty.all(Color(kBlack2.value).withOpacity(0.2)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
      child: LoadingIndicator(isButton: isButton),
    );
  }
}
