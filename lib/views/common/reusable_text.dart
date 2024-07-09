import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText({
    super.key,
    required this.text,
    required this.style,
    this.maxLine,
    this.isCentre,
  });

  final String text;
  final TextStyle style;
  final bool? maxLine;
  final bool? isCentre;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine != null ? (maxLine == true ? 2 : 1) : null,
      softWrap: true,
      textAlign: isCentre == null ? TextAlign.left : TextAlign.center,
      overflow: TextOverflow.fade,
      style: style,
    );
  }
}
