// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/features/students/controller/student_controller.dart';
import 'package:personal_project/utils/widgets/widgets.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddStudentScreen extends ConsumerStatefulWidget {
  const AddStudentScreen({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const AddStudentScreen(),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddStudentScreenState();
}

class _AddStudentScreenState extends ConsumerState<AddStudentScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lasttNameController = TextEditingController();
  final TextEditingController _studentContactController =
      TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherContactController =
      TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherCotnactController =
      TextEditingController();
  final TextEditingController _stdController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextfieldTagsController _controller = TextfieldTagsController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lasttNameController.dispose();
    _studentContactController.dispose();
    _fatherContactController.dispose();
    _fatherNameController.dispose();
    _motherNameController.dispose();
    _motherCotnactController.dispose();
    _stdController.dispose();
    _emailIdController.dispose();
    _batchController.dispose();
    super.dispose();
  }

  void onStudentAdd(
          {required String firstName,
          required String lastName,
          required String emailID,
          required String contactNumber,
          required String fatherName,
          required String fatherContactNumber,
          required String motherContactNumber,
          required String motherName,
          required String batch,
          required String std,
          required List<String> subjects,
          required BuildContext context}) =>
      ref.watch(studentControllerProvider).createStudent(
            firstName: firstName,
            lastName: lastName,
            emailID: emailID,
            contactNumber: contactNumber,
            fatherName: fatherName,
            fatherContactNumber: fatherContactNumber,
            motherContactNumber: motherContactNumber,
            motherName: motherName,
            batch: batch,
            std: std,
            subjects: subjects,
            context: context,
          );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => onStudentAdd(
              firstName: _firstNameController.text,
              lastName: _lasttNameController.text,
              emailID: _emailIdController.text,
              contactNumber: _studentContactController.text,
              fatherName: _fatherNameController.text,
              fatherContactNumber: _fatherContactController.text,
              motherContactNumber: _motherCotnactController.text,
              motherName: _motherNameController.text,
              batch: _batchController.text,
              std: _stdController.text,
              subjects: _controller.getTags!,
              context: context,
            ),
            icon: const Icon(
              size: 20,
              Icons.done_rounded,
              color: Color.fromARGB(255, 0, 0, 255),
            ),
          )
        ],
        centerTitle: true,
        title: CustomText(
          text: "Add Student",
          style: customStyle(size: 25),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          child: CustomTextFormField(
                              labelText: "First Name",
                              controller: _firstNameController)),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: CustomTextFormField(
                          labelText: "Last Name",
                          controller: _lasttNameController,
                        ),
                      ),
                    ),
                  ],
                ),
                HeightSpacer(height: 20),
                CustomTextFormField(
                  // prefix: WidthSpacer(
                  //   width: 50.w,
                  //   child: CustomText(
                  //     text: "+91",
                  //     style: customStyle(
                  //       size: 18,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  controller: _studentContactController,
                  keyBoardType: TextInputType.phone,
                  labelText: "Student's Contact Number",
                ),
                HeightSpacer(height: 20),
                CustomTextFormField(
                  controller: _emailIdController,
                  labelText: "Enter Email ID",
                ),
                HeightSpacer(height: 20),
                CustomTextFormField(
                  controller: _fatherNameController,
                  labelText: "Father's Name",
                ),
                HeightSpacer(height: 20),
                CustomTextFormField(
                  controller: _fatherContactController,
                  labelText: "Father's Contact Number",
                  keyBoardType: TextInputType.phone,
                ),
                HeightSpacer(height: 20),
                CustomTextFormField(
                  controller: _motherNameController,
                  labelText: "Mother's Name",
                ),
                HeightSpacer(height: 20),
                CustomTextFormField(
                  controller: _motherCotnactController,
                  labelText: "Mother's Contact Number",
                  keyBoardType: TextInputType.phone,
                ),
                HeightSpacer(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          child: CustomTextFormField(
                              labelText: "Batch",
                              controller: _batchController)),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: CustomTextFormField(
                          labelText: "Std",
                          keyBoardType: TextInputType.phone,
                          controller: _stdController,
                        ),
                      ),
                    ),
                  ],
                ),
                HeightSpacer(height: 20),
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
                          labelText: "Enter Subjects",
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
                                              width: 0.5.w,
                                              color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.w),
                                          ),
                                          // color: Colors.white,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0.w,
                                            vertical: 5.0.h),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
