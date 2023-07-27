import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeightSpacer extends StatelessWidget {
  const HeightSpacer({
    super.key,
    required this.height,
    this.child,
  });

  final Widget? child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: child,
    );
  }
}

class WidthSpacer extends StatelessWidget {
  const WidthSpacer({
    super.key,
    required this.width,
    this.child,
  });

  final double width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: width.w,
      child: child,
    );
  }
}
