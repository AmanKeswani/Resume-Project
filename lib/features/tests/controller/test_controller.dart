import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/models/models.dart';
import 'package:personal_project/repositories/repos.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

final testControllerProvider = Provider((ref) {
  final TestRepo testRepo = ref.watch(testRepoProvider);
  return TestController(testRepo: testRepo);
});

class TestController {
  final TestRepo _testRepo;

  TestController({required TestRepo testRepo}) : _testRepo = testRepo;

  void addTest(
      {required String subject,
      required List<String> topics,
      required String batch,
      required String std,
      required DateTime startTime,
      required DateTime endTime,
      required BuildContext context,
      required}) async {
    final res = await _testRepo.addTest(
      test: Test(
          subject: subject,
          topics: topics,
          batch: batch,
          std: std,
          startTime: startTime,
          endTime: endTime,
          testId: ''),
    );
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        Test test = Test.fromMap(r.data);
        showSnackBar(context, test.toString());
        Navigator.of(context).pop();
      },
    );
  }
}
