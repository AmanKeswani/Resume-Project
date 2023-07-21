import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/models/lecutre_model.dart';
import 'package:personal_project/repositories/lecture_repo.dart';

final getTodayLectures = FutureProvider((ref) {
  final lcp = ref.watch(lectureControllerProvider);
  return lcp.getLectures();
});

final lectureControllerProvider = Provider((ref) {
  final LectureRepo lr = ref.watch(lectureRepoProvider);
  return LectureController(lr: lr);
});

class LectureController {
  final LectureRepo _lr;

  LectureController({required LectureRepo lr}) : _lr = lr;

  void addLecture({
    required String subject,
    required DateTime startTime,
    required DateTime endTime,
    required String facultyUID,
    required String batch,
    required String std,
    required BuildContext context,
  }) async {
    final res = await _lr.addLecture(Lecture(
      subject: subject,
      startTime: startTime,
      endTime: endTime,
      facultyUID: facultyUID,
      batch: batch,
      std: std,
      lectureID: '',
    ));
    res.fold((l) => print(l.message), (r) => Navigator.of(context).pop);
  }

  Future<List<Lecture>> getLectures() async {
    // final today = DateTime.now();
    // final todayDate = DateTime(today.year, today.month, today.day);

    final lectureListData = await _lr.getAllLectures();
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
