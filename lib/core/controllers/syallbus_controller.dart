import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/core/models/models.dart';
import 'package:personal_project/core/repositories/repos.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

final syllabusControllerProvider = Provider(
    (ref) => SyllabusController(repo: ref.watch(syllabusRepoProvider)));

class SyllabusController {
  final SyllabusRepo _repo;

  const SyllabusController({required SyllabusRepo repo}) : _repo = repo;

  void addSyllabus({
    required BuildContext context,
    required String subject,
    required String std,
    required String board,
    required List<String> topics,
  }) async {
    final res = await _repo.addSyllabus(
        syllabus: Syllabus(
      syllabusId: '',
      subject: subject,
      std: std,
      board: board,
      topics: topics,
    ));

    res.fold((l) => showSnackBar(context, l.message),
        (r) => showSnackBar(context, "Done"));
  }

  void editSyllabus({
    required BuildContext context,
    required String documentId,
    required Syllabus syllabus,
  }) async {
    final res = await _repo.editSyllabus(
      syllabus: syllabus,
      id: documentId,
    );
    res.fold((l) => showSnackBar(context, l.message),
        (r) => showSnackBar(context, "Done"));
  }
}
