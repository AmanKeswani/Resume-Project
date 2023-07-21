// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.keyBoardType,
    this.expands,
    this.maxLines,
    this.verticalPadding,
    required this.controller,
    this.enabled,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String? labelText;
  final TextInputType? keyBoardType;
  final bool? expands;
  final int? maxLines;
  final int? verticalPadding;
  final bool? enabled;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled ?? true,
      expands: expands ?? false,
      maxLines: maxLines ?? 1,
      controller: controller,
      keyboardType: keyBoardType ?? TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colorss.borderColor,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: verticalPadding?.h ?? 0.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colorss.borderColor),
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colorss.borderColor)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colorss.borderColor),
        ),
      ),
    );
  }
}
