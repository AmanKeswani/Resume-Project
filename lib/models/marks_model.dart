import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Marks {
  final String testID;
  final String marksID;
  final List<String> students;
  final List<double> marks;
  const Marks({
    required this.testID,
    required this.marksID,
    required this.students,
    required this.marks,
  });

  Marks copyWith({
    String? testID,
    String? marksID,
    List<String>? students,
    List<double>? marks,
  }) {
    return Marks(
      testID: testID ?? this.testID,
      marksID: marksID ?? this.marksID,
      students: students ?? this.students,
      marks: marks ?? this.marks,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'testID': testID});
    result.addAll({'marksID': marksID});
    result.addAll({'students': students});
    result.addAll({'marks': marks});

    return result;
  }

  factory Marks.fromMap(Map<String, dynamic> map) {
    return Marks(
      testID: map['testID'] ?? '',
      marksID: map['marksID'] ?? '',
      students: List<String>.from(map['students']),
      marks: List<double>.from(map['marks']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Marks.fromJson(String source) => Marks.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Marks(testID: $testID, marksID: $marksID, students: $students, marks: $marks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Marks &&
        other.testID == testID &&
        other.marksID == marksID &&
        listEquals(other.students, students) &&
        listEquals(other.marks, marks);
  }

  @override
  int get hashCode {
    return testID.hashCode ^
        marksID.hashCode ^
        students.hashCode ^
        marks.hashCode;
  }
}
