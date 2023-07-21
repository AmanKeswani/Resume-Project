import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.faculty,
    required this.std,
    required this.batch,
    required this.date,
  });

  final String startTime;
  final String endTime;
  final String subject;
  final String faculty;
  final String std;
  final String batch;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colorss.backgroundFadeBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeightSpacer(height: 5),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.av_timer_rounded,
                    size: 24,
                  ),
                  CustomText(
                    text: "$startTime - $endTime",
                    style: customStyle(
                      size: 12,
                    ),
                  )
                ],
              ),
              const HeightSpacer(height: 5),
              CustomText(
                text: subject,
                style: customStyle(size: 26),
              ),
              CustomText(
                text: date,
                style: customStyle(size: 15),
              ),
            ],
          ),
          const VerticalDivider(
            color: Colors.black,
            thickness: 0.5,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeightSpacer(height: 5),
                  CustomText(
                    text: faculty,
                    style: customStyle(size: 16),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  ),
                  CustomText(
                    text: std,
                    style: customStyle(size: 16),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  ),
                  CustomText(
                    text: batch,
                    style: customStyle(size: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
