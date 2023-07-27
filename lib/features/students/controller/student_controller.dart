import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/features/auth/controllers/auth_controller.dart';
import 'package:personal_project/models/models.dart';
import 'package:personal_project/repositories/repos.dart';
import 'package:personal_project/utils/helpers/helpers.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

final studentControllerProvider = Provider((ref) => StudentController(
      sr: ref.watch(studentRepoProvider),
      auth: ref.watch(authControllerProvider),
    ));

class StudentController {
  final StudentRepo _sr;
  final AuthController _auth;

  StudentController({required StudentRepo sr, required AuthController auth})
      : _sr = sr,
        _auth = auth;

  void createStudent({
    required String firstName,
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
    required BuildContext context,
  }) async {
    final password = generatePassword();

    final user = await _auth.createAuth(
      email: emailID,
      password: password,
      name: "$firstName $lastName",
      context: context,
    );
    if (user != null) {
      final res = await _sr.createStudent(
        student: Student(
          studentId: '',
          firstName: firstName,
          lastName: lastName,
          contactNumber: contactNumber,
          fatherName: fatherName,
          fatherContactNumber: fatherContactNumber,
          motherName: motherName,
          motherContactNumber: motherContactNumber,
          batch: batch,
          std: std,
          subjects: subjects,
          emailID: emailID,
        ),
        documentId: user.$id,
      );
      res.fold((l) => showSnackBar(context, l.message), (r) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomAlertDialogBasic(
            titleText: "Student Created",
            descriptionText: "Username : $emailID\nPassword : $password",
          ),
        );
        Navigator.of(context).pop();
      });
    } else {}
  }
}
