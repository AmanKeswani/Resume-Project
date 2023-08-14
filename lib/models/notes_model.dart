import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Notes {
  final String notesId;
  final String subject;
  final List<String> topics;
  final List<String> notesFileId;
  final List<String> practiceSheetFileId;
  const Notes({
    required this.notesId,
    required this.subject,
    required this.topics,
    required this.notesFileId,
    required this.practiceSheetFileId,
  });

  Notes copyWith({
    String? notesId,
    String? subject,
    List<String>? topics,
    List<String>? notesFileId,
    List<String>? practiceSheetFileId,
  }) {
    return Notes(
      notesId: notesId ?? this.notesId,
      subject: subject ?? this.subject,
      topics: topics ?? this.topics,
      notesFileId: notesFileId ?? this.notesFileId,
      practiceSheetFileId: practiceSheetFileId ?? this.practiceSheetFileId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'subject': subject});
    result.addAll({'topics': topics});
    result.addAll({'notesFileId': notesFileId});
    result.addAll({'practiceSheetFileId': practiceSheetFileId});

    return result;
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      notesId: map['\$id'] ?? '',
      subject: map['subject'] ?? '',
      topics: List<String>.from(map['topics']),
      notesFileId: List<String>.from(map['notesFileId']),
      practiceSheetFileId: List<String>.from(map['practiceSheetFileId']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) => Notes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notes(notesId: $notesId, subject: $subject, topics: $topics, notesFileId: $notesFileId, practiceSheetFileId: $practiceSheetFileId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notes &&
        other.notesId == notesId &&
        other.subject == subject &&
        listEquals(other.topics, topics) &&
        listEquals(other.notesFileId, notesFileId) &&
        listEquals(other.practiceSheetFileId, practiceSheetFileId);
  }

  @override
  int get hashCode {
    return notesId.hashCode ^
        subject.hashCode ^
        topics.hashCode ^
        notesFileId.hashCode ^
        practiceSheetFileId.hashCode;
  }
}
