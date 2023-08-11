import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class CustomAlertDialogBasic extends StatelessWidget {
  const CustomAlertDialogBasic({
    super.key,
    required this.titleText,
    required this.descriptionText,
  });

  final String titleText;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomText(
              text: titleText,
              style: customStyle(
                size: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomText(
              text: descriptionText,
              style: customStyle(
                size: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTapText(
                  onTap: () => Navigator.of(context).pop(),
                  text: "OK",
                  style: customStyle(
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () => Clipboard.setData(
                    ClipboardData(
                      text: descriptionText,
                    ),
                  ),
                  child: const Icon(Icons.copy),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
