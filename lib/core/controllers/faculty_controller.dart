import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/core/models/models.dart';
import 'package:personal_project/core/repositories/repos.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

final facultyControllerProvider =
    Provider((ref) => FacultyController(repo: ref.watch(facultyRepoProvider)));

class FacultyController {
  final FacultyRepo _repo;

  const FacultyController({required FacultyRepo repo}) : _repo = repo;

  void createFaculty({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String contactNumber,
    required List<String> subjects,
    required String emailID,
  }) async {
    final res = await _repo.createFaculty(
        faculty: Faculty(
      firstName: firstName,
      lastName: lastName,
      contactNumber: contactNumber,
      subjects: subjects,
      facultyId: '',
      emailID: emailID,
    ));
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, "Faculty Added"),
    );
  }

  Future<Faculty> getFacultyById({
    required BuildContext context,
    required String documentId,
  }) async {
    final faculty = await _repo.getFacultyById(documentId: documentId);
    return Faculty.fromMap(faculty.data);
  }
}
