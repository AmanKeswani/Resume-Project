import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/core/models/models.dart';
import 'package:personal_project/core/repositories/repos.dart';
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

  Future<List<Lecture>> getLectures() async {
    // final today = DateTime.now();
    // final todayDate = DateTime(today.year, today.month, today.day);

    final lectureListData = await _testRepo.getAllTests();
    var lectureList = lectureListData
        .map((lecture) => Lecture.fromMap(lecture.data))
        .toList();
    // List<Lecture> filteredLectureList = lectureList.where((element) {
    //   final lectureDate = DateTime(element.startTime.year,
    //       element.startTime.month, element.startTime.day);
    //   return lectureDate.isAtSameMomentAs(todayDate);
    // }).toList();
    return lectureList;
  }
}
