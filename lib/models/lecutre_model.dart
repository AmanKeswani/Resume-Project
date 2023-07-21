import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class Lecture {
  final String subject;
  final DateTime startTime;
  final DateTime endTime;
  final String facultyUID;
  final String batch;
  final String std;
  final String lectureID;
  final String? attendanceID;
  const Lecture({
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.facultyUID,
    required this.batch,
    required this.std,
    required this.lectureID,
    this.attendanceID,
  });

  Lecture copyWith({
    String? subject,
    DateTime? startTime,
    DateTime? endTime,
    String? facultyUID,
    String? batch,
    String? std,
    String? lectureID,
    String? attendanceID,
  }) {
    return Lecture(
      subject: subject ?? this.subject,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      facultyUID: facultyUID ?? this.facultyUID,
      batch: batch ?? this.batch,
      std: std ?? this.std,
      lectureID: lectureID ?? this.lectureID,
      attendanceID: attendanceID ?? this.attendanceID,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'subject': subject});
    result.addAll({'startTime': startTime.millisecondsSinceEpoch});
    result.addAll({'endTime': endTime.millisecondsSinceEpoch});
    result.addAll({'facultyUID': facultyUID});
    result.addAll({'batch': batch});
    result.addAll({'std': std});
    if (attendanceID != null) {
      result.addAll({'attendanceID': attendanceID});
    }

    return result;
  }

  factory Lecture.fromMap(Map<String, dynamic> map) {
    return Lecture(
      subject: map['subject'] ?? '',
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      facultyUID: map['facultyUID'] ?? '',
      batch: map['batch'] ?? '',
      std: (map['std'] ?? '').toString(),
      lectureID: map['\$id'] ?? '',
      attendanceID: map['attendanceID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Lecture.fromJson(String source) =>
      Lecture.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Lecture(subject: $subject, startTime: $startTime, endTime: $endTime, facultyUID: $facultyUID, batch: $batch, std: $std, lectureID: $lectureID, attendanceID: $attendanceID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Lecture &&
        other.subject == subject &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.facultyUID == facultyUID &&
        other.batch == batch &&
        other.std == std &&
        other.lectureID == lectureID &&
        other.attendanceID == attendanceID;
  }

  @override
  int get hashCode {
    return subject.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        facultyUID.hashCode ^
        batch.hashCode ^
        std.hashCode ^
        lectureID.hashCode ^
        attendanceID.hashCode;
  }
}
