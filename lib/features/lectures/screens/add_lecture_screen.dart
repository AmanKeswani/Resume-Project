// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/features/lectures/controllers/lecture_controller.dart';
import 'package:personal_project/utils/helpers/helpers.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class AddLectureScreen extends ConsumerStatefulWidget {
  const AddLectureScreen({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const AddLectureScreen(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddLectureScreenState();
}

class _AddLectureScreenState extends ConsumerState<AddLectureScreen> {
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _faculty = TextEditingController();
  final TextEditingController _batch = TextEditingController();
  final TextEditingController _std = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override
  void dispose() {
    _subject.dispose();
    _faculty.dispose();
    _dateController.dispose();
    _startTime.dispose();
    _endTime.dispose();
    _batch.dispose();
    _std.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _startTime.text = (_start ?? "Select Start Time").toString();
    _endTime.text = (_end ?? "Select End Time").toString();
    _dateController.text = DateHelper().formatDateTextMonth(date: _date);
    super.initState();
  }

  DateTime? _start;
  DateTime? _end;
  DateTime _date = DateTime.now();

  void _onLectuerAdd({
    required BuildContext context,
    required String subject,
    required DateTime startTime,
    required DateTime endTime,
    required String facultyUID,
    required String batch,
    required String std,
  }) {
    ref.watch(lectureControllerProvider).addLecture(
          subject: subject,
          startTime: startTime,
          endTime: endTime,
          facultyUID: facultyUID,
          batch: batch,
          std: std.toString(),
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: IconButton(
              onPressed: () => _onLectuerAdd(
                batch: _batch.text,
                context: context,
                endTime: _end!,
                facultyUID: _faculty.text,
                startTime: _start!,
                std: _std.text.toString(),
                subject: _subject.text,
              ),
              icon: Icon(
                size: 20,
                Icons.done_rounded,
                color: Color.fromARGB(255, 0, 0, 255),
              ),
            ),
          )
        ],
        centerTitle: true,
        title: CustomText(
          text: "Add Lecture",
          style: customStyle(size: 25),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            HeightSpacer(height: 20),
            CustomTextFormField(
              controller: _subject,
              labelText: "Subject",
            ),
            HeightSpacer(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 7.5.w),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () async {
                        final selected =
                            await DateHelper().getDate(context: context);
                        setState(() {
                          if (selected != null) {
                            _date = selected;
                            _dateController.text =
                                DateHelper().formatDateTextMonth(date: _date);
                            _start = DateTime(_date.year, _date.month,
                                _date.day, _start!.hour, _start!.minute);
                            _end = DateTime(_date.year, _date.month, _date.day,
                                _end!.hour, _end!.minute);
                          }
                        });
                      },
                      child: CustomTextFormField(
                        controller: _dateController,
                        suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                        enabled: false,
                        labelText: "Lecture Date",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 7.5.w),
                      child: CustomTextFormField(
                        controller: _std,
                        labelText: "Standard",
                      )),
                ),
              ],
            ),
            HeightSpacer(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 7.5.w),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () async {
                        final selectedTime = await TimeHelper().getTime(
                            context: context, helpText: "Select Start Time");
                        setState(() {
                          if (selectedTime != null) {
                            _start = DateTime(
                                _date.year,
                                _date.month,
                                _date.day,
                                selectedTime.hour,
                                selectedTime.minute);
                            _startTime.text =
                                TimeHelper().formatTime(time: _start!);
                          }
                        });
                      },
                      child: CustomTextFormField(
                        suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                        controller: _startTime,
                        enabled: false,
                        labelText: "Start Time",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 7.5.w),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () async {
                        final selectedTime = await TimeHelper().getTime(
                            context: context, helpText: "Select End Time");
                        setState(() {
                          if (selectedTime != null) {
                            _end = DateTime(_date.year, _date.month, _date.day,
                                selectedTime.hour, selectedTime.minute);
                            _endTime.text =
                                TimeHelper().formatTime(time: _end!);
                          }
                        });
                      },
                      child: CustomTextFormField(
                        controller: _endTime,
                        enabled: false,
                        suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                        labelText: "End Time",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            HeightSpacer(height: 20),
            CustomTextFormField(
              controller: _faculty,
              labelText: "Faculty",
            ),
            HeightSpacer(height: 20),
            CustomTextFormField(
              controller: _batch,
              labelText: "batch",
            ),
            HeightSpacer(height: 20),
          ],
        ),
      )),
    );
  }
}
