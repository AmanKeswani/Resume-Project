// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/features/tests/screens/add_test_screen.dart';
import 'package:personal_project/features/home/widgets/widgets.dart';
import 'package:personal_project/features/lectures/controllers/lecture_controller.dart';
import 'package:personal_project/features/lectures/screens/add_lecture_screen.dart';
import 'package:personal_project/utils/helpers/helpers.dart';
import 'package:personal_project/utils/widgets/widgets.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigagteToAddLecture({required BuildContext context}) =>
        Navigator.of(context).push(AddLectureScreen.route());
    void navigagteToAddTest({required BuildContext context}) =>
        Navigator.of(context).push(AddTestScreen.route());
    return Scaffold(
      floatingActionButton: SpeedDialFabWidget(
        secondaryIconsList: [
          Icons.book,
          Icons.book,
        ],
        secondaryIconsText: ["Add Lecture", "Add Test"],
        secondaryIconsOnPress: [
          () => navigagteToAddLecture(context: context),
          () => navigagteToAddTest(context: context),
        ],
        primaryIconCollapse: Icons.arrow_back_ios_new_rounded,
        rotateAngle: 3.14 / 2,
        primaryIconExpand: Icons.add,
        primaryElevation: 5,
        secondaryElevation: 5,
      ),

      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.white,
      //     shape: CircleBorder(),
      //     onPressed: () => navigagteToAddLecture(context: context),
      //     child: Icon(
      //       Icons.add,
      //       color: Colorss.backgroundFadeBlue,
      //     )),
      // bottomNavigationBar: Container(
      //   height: 60.h,
      //   width: 100.w,
      //   margin: EdgeInsets.only(
      //     bottom: 15.h,
      //     right: 20.w,
      //     left: 20.w,
      //   ),
      //   decoration: BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(0.4),
      //         blurRadius: 3.0,
      //         spreadRadius: 0.0,
      //         offset: Offset(2.0, 2.0),
      //       )
      //     ],
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(200),
      //   ),
      //   child: GNav(
      //     onTabChange: (index) {},
      //     tabs: [
      //       GButton(
      //         icon: Icons.home_max_rounded,
      //         iconSize: 200,
      //       ),
      //       GButton(
      //         icon: Icons.abc,
      //       ),
      //       GButton(
      //         icon: Icons.abc,
      //       )
      //     ],
      //   ),
      // ),
      backgroundColor: Colorss.backgroundFadeBlue,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeightSpacer(height: 30),
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
            HeightSpacer(height: 20),
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
                                child: Icon(Icons.arrow_back_ios_new_rounded)),
                            CustomText(
                              text: "19 July 2023",
                              style: customStyle(
                                size: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            InkWell(
                                onTap: () {},
                                child: Icon(Icons.arrow_forward_ios_rounded)),
                          ],
                        ),
                      ),
                      HeightSpacer(height: 10),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          child: ref.watch(getTodayLectures).when(
                                data: (lectures) {
                                  if (lectures.isEmpty) {
                                    return Center(
                                        child: Text("No Lecture Today"));
                                  } else {
                                    return ListView.builder(
                                        itemCount: lectures.length,
                                        itemBuilder: (context, index) {
                                          return ScheduleListItem(
                                            date: DateHelper()
                                                .formatDateTextMonth(
                                                    date: lectures[index]
                                                        .startTime),
                                            // date: DateFormat('dd - MMMM - yyyy')
                                            //     .format(
                                            //         lectures[index].startTime),
                                            startTime: TimeHelper().formatTime(
                                                time:
                                                    lectures[index].startTime),
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
        ),
      ),
    );
  }
}
