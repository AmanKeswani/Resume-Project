import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Faculty {
  final String firstName;
  final String lastName;
  final String contactNumber;
  final List<String> subjects;
  final String facultyId;
  final String emailID;
  const Faculty({
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.subjects,
    required this.facultyId,
    required this.emailID,
  });

  Faculty copyWith({
    String? firstName,
    String? lastName,
    String? contactNumber,
    List<String>? subjects,
    String? facultyId,
    String? emailID,
  }) {
    return Faculty(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      contactNumber: contactNumber ?? this.contactNumber,
      subjects: subjects ?? this.subjects,
      facultyId: facultyId ?? this.facultyId,
      emailID: emailID ?? this.emailID,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'contactNumber': contactNumber});
    result.addAll({'subjects': subjects});
    result.addAll({'emailID': emailID});

    return result;
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      subjects: List<String>.from(map['subjects']),
      facultyId: map['\$id'] ?? '',
      emailID: map['emailID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Faculty.fromJson(String source) =>
      Faculty.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Faculty(firstName: $firstName, lastName: $lastName, contactNumber: $contactNumber, subjects: $subjects, facultyId: $facultyId, emailID: $emailID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Faculty &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.contactNumber == contactNumber &&
        listEquals(other.subjects, subjects) &&
        other.facultyId == facultyId &&
        other.emailID == emailID;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        contactNumber.hashCode ^
        subjects.hashCode ^
        facultyId.hashCode ^
        emailID.hashCode;
  }
}
