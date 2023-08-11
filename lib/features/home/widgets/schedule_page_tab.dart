import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/features/home/controllers/controller.dart';
import 'package:personal_project/features/home/widgets/widgets.dart';
import 'package:personal_project/utils/helpers/helpers.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class SchedulePageTab extends ConsumerStatefulWidget {
  const SchedulePageTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SchedulePageTabState();
}

class _SchedulePageTabState extends ConsumerState<SchedulePageTab> {
  @override
  Widget build(BuildContext context) {
    final date = ref.watch(chosenDateProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const HeightSpacer(height: 30),
        const HeightSpacer(height: 20),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 750.h,
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
                          onTap: () {
                            date.state = DateTime(
                              date.state.year,
                              date.state.month,
                              date.state.day - 1,
                            );
                            setState(() {});
                          },
                          child: const Icon(Icons.arrow_back_ios_new_rounded)),
                      CustomText(
                        text:
                            DateHelper().formatDateTextMonth(date: date.state),
                        style: customStyle(
                          size: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            date.state = DateTime(
                              date.state.year,
                              date.state.month,
                              date.state.day + 1,
                            );
                            setState(() {});
                          },
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
                    // child: ref.watch(scheduleProvider(DateTime.now())).when(
                    child: ref.watch(scheduleProvider(date.state)).when(
                          data: (lectures) {
                            if (lectures.isEmpty) {
                              return const Center(
                                  child: Text("No Lecture Today"));
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
                          loading: () => const Text("Loading"),
                        ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
