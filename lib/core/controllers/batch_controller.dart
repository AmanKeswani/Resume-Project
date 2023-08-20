import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/core/models/models.dart';
import 'package:personal_project/core/repositories/repos.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

final batchControllerProvider =
    Provider((ref) => BatchController(repo: ref.watch(batchRepoProvider)));

class BatchController {
  final BatchRepo _repo;

  BatchController({required BatchRepo repo}) : _repo = repo;

  void createBatch({
    required BuildContext context,
    required List<String> students,
    required String board,
    required String std,
    required String batchSymbol,
    required String batchCategory,
  }) async {
    final res = await _repo.createBatch(
        batch: Batch(
      batchId: '',
      students: students,
      board: board,
      std: std,
      batchSymbol: batchSymbol,
      batchCategory: batchCategory,
    ));
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, "Batch Created"),
    );
  }

  Future<List<Batch>> getAllBatches() async {
    final res = await _repo.getAllBatches();
    return res.map((document) => Batch.fromMap(document.data)).toList();
  }

  void editBatch(
      {required String documentId,
      required Batch batch,
      required BuildContext context}) async {
    final res = await _repo.editBatch(
      documentId: documentId,
      batch: batch,
    );

    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, "Batch Updated"),
    );
  }
}
