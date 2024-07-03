import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/app_style.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.messageController,
    this.customSuffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.onTapOutside,
    this.onSubmitted,
  });

  final TextEditingController messageController;
  final Widget? customSuffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Color(kDarkGrey.value),
      controller: messageController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: appstyle(16, Color(kWhite2.value), FontWeight.w500),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
        filled: true,
        fillColor: Color(kBlack2.value),
        suffixIcon: customSuffixIcon,
        hintText: "Kirim pesan",
        hintStyle: appstyle(
          14,
          Color(kDarkGrey.value),
          FontWeight.normal,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.h)),
          borderSide: BorderSide(
            color: Color(kDarkGrey.value),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.h)),
          borderSide: BorderSide(
            color: Color(kDarkGrey.value),
          ),
        ),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
      onSubmitted: onSubmitted,
    );
  }
}
