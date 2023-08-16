import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Notes {
  final String notesId;
  final String subject;
  final String std;
  final String board;
  final List<String> topics;
  final List<String> notesFileId;
  final List<String> practiceSheetFileId;
  const Notes({
    required this.notesId,
    required this.subject,
    required this.std,
    required this.board,
    required this.topics,
    required this.notesFileId,
    required this.practiceSheetFileId,
  });

  Notes copyWith({
    String? notesId,
    String? subject,
    String? std,
    String? board,
    List<String>? topics,
    List<String>? notesFileId,
    List<String>? practiceSheetFileId,
  }) {
    return Notes(
      notesId: notesId ?? this.notesId,
      subject: subject ?? this.subject,
      std: std ?? this.std,
      board: board ?? this.board,
      topics: topics ?? this.topics,
      notesFileId: notesFileId ?? this.notesFileId,
      practiceSheetFileId: practiceSheetFileId ?? this.practiceSheetFileId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'subject': subject});
    result.addAll({'std': std});
    result.addAll({'board': board});
    result.addAll({'topics': topics});
    result.addAll({'notesFileId': notesFileId});
    result.addAll({'practiceSheetFileId': practiceSheetFileId});

    return result;
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      notesId: map['\$id'] ?? '',
      subject: map['subject'] ?? '',
      std: map['std'] ?? '',
      board: map['board'] ?? '',
      topics: List<String>.from(map['topics']),
      notesFileId: List<String>.from(map['notesFileId']),
      practiceSheetFileId: List<String>.from(map['practiceSheetFileId']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) => Notes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notes(notesId: $notesId, subject: $subject, std: $std, board: $board, topics: $topics, notesFileId: $notesFileId, practiceSheetFileId: $practiceSheetFileId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notes &&
        other.notesId == notesId &&
        other.subject == subject &&
        other.std == std &&
        other.board == board &&
        listEquals(other.topics, topics) &&
        listEquals(other.notesFileId, notesFileId) &&
        listEquals(other.practiceSheetFileId, practiceSheetFileId);
  }

  @override
  int get hashCode {
    return notesId.hashCode ^
        subject.hashCode ^
        std.hashCode ^
        board.hashCode ^
        topics.hashCode ^
        notesFileId.hashCode ^
        practiceSheetFileId.hashCode;
  }
}
