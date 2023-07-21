import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Attendance {
  final String attendanceID;
  final String lectureTestID;
  final List<String> students;
  final List<String> presenty;
  const Attendance({
    required this.attendanceID,
    required this.lectureTestID,
    required this.students,
    required this.presenty,
  });

  Attendance copyWith({
    String? attendanceID,
    String? lectureTestID,
    List<String>? students,
    List<String>? presenty,
  }) {
    return Attendance(
      attendanceID: attendanceID ?? this.attendanceID,
      lectureTestID: lectureTestID ?? this.lectureTestID,
      students: students ?? this.students,
      presenty: presenty ?? this.presenty,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'attendanceID': attendanceID});
    result.addAll({'lectureTestID': lectureTestID});
    result.addAll({'students': students});
    result.addAll({'presenty': presenty});

    return result;
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      attendanceID: map['attendanceID'] ?? '',
      lectureTestID: map['lectureTestID'] ?? '',
      students: List<String>.from(map['students']),
      presenty: List<String>.from(map['presenty']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attendance(attendanceID: $attendanceID, lectureTestID: $lectureTestID, students: $students, presenty: $presenty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attendance &&
        other.attendanceID == attendanceID &&
        other.lectureTestID == lectureTestID &&
        listEquals(other.students, students) &&
        listEquals(other.presenty, presenty);
  }

  @override
  int get hashCode {
    return attendanceID.hashCode ^
        lectureTestID.hashCode ^
        students.hashCode ^
        presenty.hashCode;
  }
}
