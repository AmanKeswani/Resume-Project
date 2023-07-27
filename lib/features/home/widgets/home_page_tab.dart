import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/features/home/widgets/widgets.dart';
import 'package:personal_project/features/lectures/controllers/lecture_controller.dart';
import 'package:personal_project/utils/helpers/helpers.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class HomePageTab extends ConsumerWidget {
  const HomePageTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const HeightSpacer(height: 30),
        Container(
          alignment: Alignment.center,
          width: 313.w,
          height: 50.h,
          padding: EdgeInsets.symmetric(
            horizontal: 40.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomText(
            text: "Schedule",
            style: customStyle(
              size: 34,
              color: Colorss.appBarTextColor,
            ),
          ),
        ),
        const HeightSpacer(height: 20),
        Align(
          alignment: Alignment.topCenter,
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 700.h,
              width: 388.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 20.h,
                      // bottom: 3.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {},
                            child:
                                const Icon(Icons.arrow_back_ios_new_rounded)),
                        CustomText(
                          text: "19 July 2023",
                          style: customStyle(
                            size: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        InkWell(
                            onTap: () {},
                            child: const Icon(Icons.arrow_forward_ios_rounded)),
                      ],
                    ),
                  ),
                  const HeightSpacer(height: 10),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: ref.watch(getTodayLectures).when(
                            data: (lectures) {
                              if (lectures.isEmpty) {
                                return const Center(
                                    child: Text("No Lecture Today"));
                              } else {
                                return ListView.builder(
                                    itemCount: lectures.length,
                                    itemBuilder: (context, index) {
                                      return ScheduleListItem(
                                        date: DateHelper().formatDateTextMonth(
                                            date: lectures[index].startTime),
                                        startTime: TimeHelper().formatTime(
                                            time: lectures[index].startTime),
                                        endTime: TimeHelper().formatTime(
                                            time: lectures[index].endTime),
                                        subject: lectures[index].subject,
                                        faculty: lectures[index].facultyUID,
                                        std: lectures[index].std.toString(),
                                        batch: lectures[index].batch,
                                      );
                                    });
                              }
                            },
                            error: (error, stackTrace) =>
                                Text(error.toString()),
                            loading: () => Container(),
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
