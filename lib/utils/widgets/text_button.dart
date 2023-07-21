import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.height,
    required this.width,
    required this.onTap,
    required this.text,
    required this.style,
  });

  final double height;
  final double width;
  final void Function() onTap;
  final String text;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.w),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colorss.borderColor),
        ),
        onPressed: onTap,
        child: CustomText(
          text: text,
          style: style,
        ),
      ),
    );
  }
}
