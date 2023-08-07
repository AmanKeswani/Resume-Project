import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/features/home/controllers/controller.dart';
import 'package:personal_project/features/home/widgets/widgets.dart';

class SchedulePageTab extends ConsumerWidget {
  const SchedulePageTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
            ),
            child: ref.watch(scheduleProvider(DateTime(2023, 09, 04))).when(
                  data: (lectures) {
                    if (lectures.isEmpty) {
                      return const Center(child: Text("No Lecture Today"));
                    } else {
                      return ListView.builder(
                          itemCount: lectures.length,
                          itemBuilder: (context, index) {
                            return ScheduleBinaryItem(
                              object: lectures[index],
                            );
                          });
                    }
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => Container(),
                ),
          ),
        ),
      ),
    );
  }
}
