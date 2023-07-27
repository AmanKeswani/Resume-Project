import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/colors.dart';
import 'package:personal_project/features/tests/controller/test_controller.dart';
import 'package:personal_project/utils/helpers/helpers.dart';
import 'package:personal_project/utils/widgets/widgets.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddTestScreen extends ConsumerStatefulWidget {
  const AddTestScreen({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const AddTestScreen(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTestScreenState();
}

class _AddTestScreenState extends ConsumerState<AddTestScreen> {
  final TextfieldTagsController _controller = TextfieldTagsController();

  final TextEditingController _subject = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _faculty = TextEditingController();
  final TextEditingController _batch = TextEditingController();
  final TextEditingController _std = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
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

  void _onTestAdd({
    required BuildContext context,
    required List<String> topics,
    required String subject,
    required DateTime startTime,
    required DateTime endTime,
    required String batch,
    required String std,
  }) {
    ref.watch(testControllerProvider).addTest(
        subject: subject,
        topics: topics,
        batch: batch,
        std: std,
        startTime: startTime,
        endTime: endTime,
        context: context);
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
              onPressed: () => _onTestAdd(
                context: context,
                topics: _controller.getTags!,
                subject: _subject.text,
                startTime: _start!,
                endTime: _end!,
                batch: _batch.text,
                std: _std.text.toString(),
              ),
              icon: const Icon(
                size: 20,
                Icons.done_rounded,
                color: Color.fromARGB(255, 0, 0, 255),
              ),
            ),
          )
        ],
        centerTitle: true,
        title: CustomText(
          text: "Add Test",
          style: customStyle(size: 25),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            const HeightSpacer(height: 20),
            CustomTextFormField(
              controller: _subject,
              labelText: "Subject",
            ),
            const HeightSpacer(height: 20),
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
                        suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
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
            const HeightSpacer(height: 20),
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
                        labelText: "End Time",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const HeightSpacer(height: 20),
            TextFieldTags(
              textfieldTagsController: _controller,
              textSeparators: const [','],
              inputfieldBuilder:
                  (context, tec, fn, error, onChanged, onSubmitted) {
                return ((context, sc, tags, onTagDelete) {
                  return TextField(
                    controller: tec,
                    focusNode: fn,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 0.h,
                      ),
                      labelText: "Enter Topics",
                      labelStyle: const TextStyle(
                        color: Colorss.borderColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colorss.borderColor,
                          width: 3.0.w,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colorss.borderColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colorss.borderColor)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colorss.borderColor),
                      ),
                      errorText: error,
                      prefixIcon: tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: sc,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: tags.map((String tag) {
                                return InkWell(
                                  onTap: () => onTagDelete(tag),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5.w, color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.w),
                                      ),
                                      // color: Colors.white,
                                    ),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0.w, vertical: 5.0.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          tag,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        const SizedBox(width: 4.0),
                                        const Icon(
                                          Icons.cancel,
                                          size: 14.0,
                                          color: Color.fromARGB(
                                              255, 233, 233, 233),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList()),
                            )
                          : null,
                    ),
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                  );
                });
              },
            ),
            const HeightSpacer(height: 20),
            CustomTextFormField(
              controller: _faculty,
              labelText: "Faculty",
            ),
            const HeightSpacer(height: 20),
            CustomTextFormField(
              controller: _batch,
              labelText: "batch",
            ),
            const HeightSpacer(height: 20),
          ],
        ),
      )),
    );
  }
}
