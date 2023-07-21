import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign,
  });

  final String text;
  final TextStyle style;
  final TextAlign? textAlign;

  @override
  Text build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class CustomTapText extends StatelessWidget {
  const CustomTapText({
    super.key,
    this.onTap,
    required this.text,
    required this.style,
    this.textAlign,
  });

  final void Function()? onTap;
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomText(
        textAlign: textAlign,
        text: text,
        style: style,
      ),
    );
  }
}

TextStyle customStyle({
  required double size,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return TextStyle(
    height: 1,
    fontSize: size.sp,
    fontFamily: 'Inter',
    fontWeight: fontWeight,
    color: color,
  );
}
