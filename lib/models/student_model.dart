import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Student {
  final String studentId;
  final String firstName;
  final String lastName;
  final String contactNumber;
  final String fatherName;
  final String fatherContactNumber;
  final String motherName;
  final String motherContactNumber;
  final String batch;
  final String std;
  final List<String> subjects;
  final String emailID;
  const Student({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.fatherName,
    required this.fatherContactNumber,
    required this.motherName,
    required this.motherContactNumber,
    required this.batch,
    required this.std,
    required this.subjects,
    required this.emailID,
  });

  Student copyWith({
    String? studentId,
    String? firstName,
    String? lastName,
    String? contactNumber,
    String? fatherName,
    String? fatherContactNumber,
    String? motherName,
    String? motherContactNumber,
    String? batch,
    String? std,
    List<String>? subjects,
    String? emailID,
  }) {
    return Student(
      studentId: studentId ?? this.studentId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      contactNumber: contactNumber ?? this.contactNumber,
      fatherName: fatherName ?? this.fatherName,
      fatherContactNumber: fatherContactNumber ?? this.fatherContactNumber,
      motherName: motherName ?? this.motherName,
      motherContactNumber: motherContactNumber ?? this.motherContactNumber,
      batch: batch ?? this.batch,
      std: std ?? this.std,
      subjects: subjects ?? this.subjects,
      emailID: emailID ?? this.emailID,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'contactNumber': contactNumber});
    result.addAll({'fatherName': fatherName});
    result.addAll({'fatherContactNumber': fatherContactNumber});
    result.addAll({'motherName': motherName});
    result.addAll({'motherContactNumber': motherContactNumber});
    result.addAll({'batch': batch});
    result.addAll({'std': std});
    result.addAll({'subjects': subjects});
    result.addAll({'emailID': emailID});

    return result;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      studentId: map['\$id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      fatherName: map['fatherName'] ?? '',
      fatherContactNumber: map['fatherContactNumber'] ?? '',
      motherName: map['motherName'] ?? '',
      motherContactNumber: map['motherContactNumber'] ?? '',
      batch: map['batch'] ?? '',
      std: (map['std'] ?? '').toString(),
      subjects: List<String>.from(map['subjects']),
      emailID: map['emailID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(studentId: $studentId, firstName: $firstName, lastName: $lastName, contactNumber: $contactNumber, fatherName: $fatherName, fatherContactNumber: $fatherContactNumber, motherName: $motherName, motherContactNumber: $motherContactNumber, batch: $batch, std: $std, subjects: $subjects, emailID: $emailID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Student &&
        other.studentId == studentId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.contactNumber == contactNumber &&
        other.fatherName == fatherName &&
        other.fatherContactNumber == fatherContactNumber &&
        other.motherName == motherName &&
        other.motherContactNumber == motherContactNumber &&
        other.batch == batch &&
        other.std == std &&
        listEquals(other.subjects, subjects) &&
        other.emailID == emailID;
  }

  @override
  int get hashCode {
    return studentId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        contactNumber.hashCode ^
        fatherName.hashCode ^
        fatherContactNumber.hashCode ^
        motherName.hashCode ^
        motherContactNumber.hashCode ^
        batch.hashCode ^
        std.hashCode ^
        subjects.hashCode ^
        emailID.hashCode;
  }
}
