import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/core/models/models.dart';
import 'package:personal_project/core/repositories/repos.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

final attendanceControllerProvider = Provider(
    (ref) => AttendanceController(repo: ref.watch(attendanceRepoProvider)));

class AttendanceController {
  final AttendanceRepo _repo;

  AttendanceController({required AttendanceRepo repo}) : _repo = repo;

  void createAttendance({
    required String lectureTestID,
    required List<String> students,
    required List<bool> presenty,
    required BuildContext context,
  }) async {
    final res = await _repo.createAttendance(
        attendance: Attendance(
      attendanceID: '',
      lectureTestID: lectureTestID,
      students: students,
      presenty: presenty,
    ));
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => null,
    );
  }

  void editAttendance({
    required String documentId,
    required Attendance attendance,
    required List<bool> newPresenty,
    required BuildContext context,
  }) async {
    attendance = attendance.copyWith(presenty: newPresenty);
    final res = await _repo.editAttendance(
      documentId: documentId,
      attendance: attendance,
    );
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        // Navigator.pop(context);
        showSnackBar(context, "Attendance Updated");
      },
    );
  }
}
