import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Test {
  final String subject;
  final List<String> topics;
  final String batch;
  final String std;
  final DateTime startTime;
  final DateTime endTime;
  final String? attendanceID;
  final String? marksID;
  final String testId;
  const Test({
    required this.subject,
    required this.topics,
    required this.batch,
    required this.std,
    required this.startTime,
    required this.endTime,
    this.attendanceID,
    this.marksID,
    required this.testId,
  });

  Test copyWith({
    String? subject,
    List<String>? topics,
    String? batch,
    String? std,
    DateTime? startTime,
    DateTime? endTime,
    String? attendanceID,
    String? marksID,
    String? testId,
  }) {
    return Test(
      subject: subject ?? this.subject,
      topics: topics ?? this.topics,
      batch: batch ?? this.batch,
      std: std ?? this.std,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      attendanceID: attendanceID ?? this.attendanceID,
      marksID: marksID ?? this.marksID,
      testId: testId ?? this.testId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'subject': subject});
    result.addAll({'topics': topics});
    result.addAll({'batch': batch});
    result.addAll({'std': std});
    result.addAll({'startTime': startTime.millisecondsSinceEpoch});
    result.addAll({'endTime': endTime.millisecondsSinceEpoch});
    if (attendanceID != null) {
      result.addAll({'attendanceID': attendanceID});
    }
    if (marksID != null) {
      result.addAll({'marksID': marksID});
    }
    result.addAll({'testId': testId});

    return result;
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      subject: map['subject'] ?? '',
      topics: List<String>.from(map['topics']),
      batch: map['batch'] ?? '',
      std: map['std'] ?? '',
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      attendanceID: map['attendanceID'],
      marksID: map['marksID'],
      testId: map['testId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) => Test.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Test(subject: $subject, topics: $topics, batch: $batch, std: $std, startTime: $startTime, endTime: $endTime, attendanceID: $attendanceID, marksID: $marksID, testId: $testId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Test &&
        other.subject == subject &&
        listEquals(other.topics, topics) &&
        other.batch == batch &&
        other.std == std &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.attendanceID == attendanceID &&
        other.marksID == marksID &&
        other.testId == testId;
  }

  @override
  int get hashCode {
    return subject.hashCode ^
        topics.hashCode ^
        batch.hashCode ^
        std.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        attendanceID.hashCode ^
        marksID.hashCode ^
        testId.hashCode;
  }
}
