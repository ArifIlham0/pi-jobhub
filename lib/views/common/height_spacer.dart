import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeightSpacer extends StatelessWidget {
  const HeightSpacer({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size?.h,
    );
  }
}
