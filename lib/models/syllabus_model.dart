import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Syllabus {
  final String syllabusId;
  final String subject;
  final int std;
  final String board;
  final List<String> topics;
  const Syllabus({
    required this.syllabusId,
    required this.subject,
    required this.std,
    required this.board,
    required this.topics,
  });

  Syllabus copyWith({
    String? syllabusId,
    String? subject,
    int? std,
    String? board,
    List<String>? topics,
  }) {
    return Syllabus(
      syllabusId: syllabusId ?? this.syllabusId,
      subject: subject ?? this.subject,
      std: std ?? this.std,
      board: board ?? this.board,
      topics: topics ?? this.topics,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'subject': subject});
    result.addAll({'std': std});
    result.addAll({'board': board});
    result.addAll({'topics': topics});

    return result;
  }

  factory Syllabus.fromMap(Map<String, dynamic> map) {
    return Syllabus(
      syllabusId: map['\$id'] ?? '',
      subject: map['subject'] ?? '',
      std: map['std']?.toInt() ?? 0,
      board: map['board'] ?? '',
      topics: List<String>.from(map['topics']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Syllabus.fromJson(String source) =>
      Syllabus.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Syllabus(syllabusId: $syllabusId, subject: $subject, std: $std, board: $board, topics: $topics)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Syllabus &&
        other.syllabusId == syllabusId &&
        other.subject == subject &&
        other.std == std &&
        other.board == board &&
        listEquals(other.topics, topics);
  }

  @override
  int get hashCode {
    return syllabusId.hashCode ^
        subject.hashCode ^
        std.hashCode ^
        board.hashCode ^
        topics.hashCode;
  }
}
