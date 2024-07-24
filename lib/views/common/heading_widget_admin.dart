import 'package:flutter/material.dart';
import 'package:jobhub/views/common/exports.dart';

class HeadingWidgetAdmin extends StatelessWidget {
  const HeadingWidgetAdmin({
    super.key,
    this.text,
    this.onTap,
    this.onTap2,
    this.isAgent,
  });

  final String? text;
  final Function? onTap;
  final Function? onTap2;
  final bool? isAgent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onTap! as void Function()?,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              Color(kWhite.value).withOpacity(0.1),
            ),
          ),
          child: ReusableText(
            text: "Semua Akun Mitra",
            style: appstyle(isAgent == null ? 14 : 12, Color(kGreen.value),
                FontWeight.w500),
          ),
        ),
        TextButton(
          onPressed: onTap2! as void Function()?,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              Color(kWhite.value).withOpacity(0.1),
            ),
          ),
          child: ReusableText(
            text: "Semua Akun User",
            style: appstyle(isAgent == null ? 14 : 12, Color(kGreen.value),
                FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
