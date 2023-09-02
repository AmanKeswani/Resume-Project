import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/core/models/marks_model.dart';
import 'package:personal_project/core/repositories/repos.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

final marksControllerProvider =
    Provider((ref) => MarksController(repo: ref.watch(marksRepoProvider)));

class MarksController {
  final MarksRepo _repo;

  const MarksController({required MarksRepo repo}) : _repo = repo;

  void createMarks({
    required BuildContext context,
    required String testID,
    required List<String> students,
    required List<double> marks,
  }) async {
    final res = await _repo.createMarks(
        marks: Marks(
      testID: testID,
      marksID: '',
      students: students,
      marks: marks,
    ));

    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => null,
    );
  }

  void editMarks({
    required BuildContext context,
    required String documentId,
    required Marks marks,
  }) async {
    final res = await _repo.editMarks(
      documentId: documentId,
      marks: marks,
    );

    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => null,
    );
  }
}
