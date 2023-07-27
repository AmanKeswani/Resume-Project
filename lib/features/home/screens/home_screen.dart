// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/features/home/widgets/widgets.dart';
import 'package:personal_project/features/lectures/screens/add_lecture_screen.dart';
import 'package:personal_project/features/students/screens/add_student.dart';
import 'package:personal_project/features/tests/screens/add_test_screen.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  SpeedDial _buildSpeedDial() => SpeedDial(
        renderOverlay: false,
        curve: Curves.fastLinearToSlowEaseIn,
        backgroundColor: Colors.white,
        icon: Icons.add,
        children: [
          SpeedDialChild(
            label: "Add Lecture",
            child: Icon(Icons.book),
            onTap: () => navigagteToAddLecture(context: context),
          ),
          SpeedDialChild(
            label: "Add Test",
            child: Icon(Icons.book),
            onTap: () => navigagteToAddTest(context: context),
          ),
          SpeedDialChild(
            label: "Add Student",
            child: Icon(Icons.person),
            onTap: () => navigateToAddStudent(context: context),
          ),
        ],
      );
  void navigagteToAddLecture({required BuildContext context}) =>
      Navigator.of(context).push(AddLectureScreen.route());
  void navigagteToAddTest({required BuildContext context}) =>
      Navigator.of(context).push(AddTestScreen.route());
  void navigateToAddStudent({required BuildContext context}) =>
      Navigator.of(context).push(AddStudentScreen.route());

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    Widget selectedPage;
    if (selected == 0) {
      selectedPage = HomePageTab();
    } else if (selected == 1) {
      selectedPage = SchedulePageTab();
    } else if (selected == 2) {
      selectedPage = StudentsPageTab();
    } else {
      selectedPage = ProfilePageTab();
    }
    return Scaffold(
        floatingActionButton: _buildSpeedDial(),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(
            bottom: 10.h,
            left: 15.w,
            right: 15.w,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: GNav(
              onTabChange: (value) => setState(() {
                selected = value;
              }),
              selectedIndex: selected,
              padding: EdgeInsets.zero,
              tabMargin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              gap: 10.w,
              backgroundColor: Colors.white,
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: "Home",
                  textStyle: customStyle(size: 18),
                ),
                GButton(
                  icon: Icons.edit_calendar_outlined,
                  text: "Schedule",
                  textStyle: customStyle(size: 18),
                ),
                GButton(
                  icon: Icons.person_outline_rounded,
                  text: "Students",
                  textStyle: customStyle(size: 18),
                ),
                GButton(
                  icon: Icons.settings_outlined,
                  text: "Profile",
                  textStyle: customStyle(size: 18),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colorss.backgroundFadeBlue,
        body: SafeArea(
          child: selectedPage,
        ));
  }
}
