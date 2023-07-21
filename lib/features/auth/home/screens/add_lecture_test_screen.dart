// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

class AddLectureTestScreen extends ConsumerStatefulWidget {
  const AddLectureTestScreen({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const AddLectureTestScreen(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddLectureTestScreenState();
}

class _AddLectureTestScreenState extends ConsumerState<AddLectureTestScreen> {
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
    _dateController.text = DateFormat('dd - MMMM - yyyy').format(_date);
    super.initState();
  }

  DateTime? _start;
  DateTime? _end;
  DateTime _date = DateTime.now();

  Future<TimeOfDay?> _getTime({
    required BuildContext context,
    required String helpText,
  }) async =>
      await showTimePicker(
        helpText: helpText,
        context: context,
        initialEntryMode: TimePickerEntryMode.inputOnly,
        initialTime: TimeOfDay.now(),
      );

  Future<DateTime?> _getDate({
    required BuildContext context,
  }) async =>
      await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 1),
          lastDate: DateTime(DateTime.now().year + 1));

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
              onPressed: () {},
              icon: Icon(
                size: 30,
                Icons.done_rounded,
                color: Color.fromARGB(255, 0, 0, 255),
              ),
            ),
          )
        ],
        centerTitle: true,
        title: CustomText(
          text: "Title",
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
                        final selectedTime = await _getTime(
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
                                DateFormat('h : mm a').format(_start!);
                          }
                        });
                      },
                      child: CustomTextFormField(
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
                        final selectedTime = await _getTime(
                            context: context, helpText: "Select End Time");
                        setState(() {
                          if (selectedTime != null) {
                            _end = DateTime(_date.year, _date.month, _date.day,
                                selectedTime.hour, selectedTime.minute);
                            _endTime.text =
                                DateFormat('h : mm a').format(_end!);
                          }
                        });
                      },
                      child: CustomTextFormField(
                        controller: _endTime,
                        enabled: false,
                        labelText: "End Time",
                      ),
                    ),
                  ),
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
                        final selected = await _getDate(context: context);
                        setState(() {
                          if (selected != null) {
                            _date = selected;
                            _dateController.text =
                                DateFormat('dd - MMMM -  yyyy').format(_date);
                          }
                        });
                      },
                      child: CustomTextFormField(
                        controller: _dateController,
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
                        enabled: false,
                        labelText: "Standard",
                      )),
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
