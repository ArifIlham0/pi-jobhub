import 'package:flutter/material.dart';
import 'package:jobhub/views/common/exports.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
    this.text,
    this.onTap,
    this.isAgent,
  });

  final String? text;
  final Function? onTap;
  final bool? isAgent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ReusableText(
          text: text!,
          style: appstyle(18, Color(kWhite2.value), FontWeight.w600),
        ),
        InkWell(
          onTap: onTap! as void Function()?,
          child: ReusableText(
            text: isAgent == null ? "Lihat Semua" : "Lihat Lowongan Saya",
            style: appstyle(isAgent == null ? 18 : 14, Color(kGreen.value),
                FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
