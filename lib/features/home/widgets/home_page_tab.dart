// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/core/controllers/schedule_controller.dart';
import 'package:personal_project/features/home/widgets/widgets.dart';
import 'package:personal_project/utils/helpers/helpers.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class HomePageTab extends ConsumerStatefulWidget {
  const HomePageTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageTabState();
}

class _HomePageTabState extends ConsumerState<HomePageTab> {
  Map<String, dynamic> data = {"collectionName": "abc"};
  @override
  Widget build(BuildContext context) {
    final date = ref.watch(chosenDateProvider.notifier);
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
            text: "Lectures",
            style: customStyle(
              size: 34,
              color: Colorss.appBarTextColor,
            ),
          ),
        ),
        const HeightSpacer(height: 20),
        Align(
          alignment: Alignment.topCenter,
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
                          onTap: () {
                            date.state = DateTime(
                              date.state.year,
                              date.state.month,
                              date.state.day - 1,
                            );
                            setState(() {});
                          },
                          child: const Icon(Icons.arrow_back_ios_new_rounded)),
                      GestureDetector(
                        onTap: () async {
                          final ans = await ref
                              .watch(appwriteFunctionsProvider)
                              .createExecution(
                                functionId:
                                    AppwriteConstants.createBatchFunctionId,
                                data: json.encode(data),
                              );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CustomAlertDialogBasic(
                              descriptionText: ans.response,
                              titleText: ans.$id,
                            ),
                          );
                        },
                        child: CustomText(
                          text: DateHelper()
                              .formatDateTextMonth(date: date.state),
                          style: customStyle(
                            size: 25,
                            fontWeight: FontWeight.w400,
                          ),
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
