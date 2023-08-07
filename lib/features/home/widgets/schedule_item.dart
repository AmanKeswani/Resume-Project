import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/models/lecutre_model.dart';
import 'package:personal_project/utils/helpers/date_time.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class ScheduleLectureItem extends StatelessWidget {
  const ScheduleLectureItem({
    super.key,
    required this.object,
  });

  final Lecture object;

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
                    text:
                        "${TimeHelper().formatTime(time: object.startTime)} - ${TimeHelper().formatTime(time: object.endTime)}",
                    style: customStyle(
                      size: 12,
                    ),
                  )
                ],
              ),
              const HeightSpacer(height: 5),
              CustomText(
                text: object.subject,
                style: customStyle(size: 26),
              ),
              CustomText(
                text: DateHelper().formatDateTextMonth(date: object.startTime),
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
                    text: object.facultyUID,
                    style: customStyle(size: 16),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  ),
                  CustomText(
                    text: object.std.toString(),
                    style: customStyle(size: 16),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  ),
                  CustomText(
                    text: object.batch,
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

class ScheduleBinaryItem extends StatelessWidget {
  const ScheduleBinaryItem({
    super.key,
    required this.object,
  });

  final dynamic object;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.only(left: 5.w, top: 10.h, bottom: 10.h, right: 10.w),
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: object.runtimeType == Lecture
            ? Colorss.backgroundFadeBlue
            : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Container(
          //   margin: EdgeInsets.only(right: 5.w),
          //   width: 3.w,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(100),
          //     color:
          //         object.runtimeType == Lecture ? Colors.white : Colors.black,
          //   ),
          // ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
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
                      text:
                          "${TimeHelper().formatTime(time: object.startTime)} - ${TimeHelper().formatTime(time: object.endTime)}",
                      style: customStyle(
                        size: 12,
                      ),
                    )
                  ],
                ),
                const HeightSpacer(height: 5),
                CustomText(
                  text: object.subject,
                  style: customStyle(size: 26),
                ),
                CustomText(
                  text:
                      DateHelper().formatDateTextMonth(date: object.startTime),
                  style: customStyle(size: 15),
                ),
              ],
            ),
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
                  object.runtimeType == Lecture
                      ? CustomText(
                          text: object.facultyUID,
                          style: customStyle(size: 16),
                        )
                      : const SizedBox(),
                  object.runtimeType == Lecture
                      ? const Divider(
                          color: Colors.black,
                          thickness: 0.5,
                        )
                      : const SizedBox(),
                  CustomText(
                    text: object.std.toString(),
                    style: customStyle(size: 16),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.5,
                  ),
                  CustomText(
                    text: object.batch,
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
