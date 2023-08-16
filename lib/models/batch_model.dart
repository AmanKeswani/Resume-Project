import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Batch {
  final String batchId;
  final List<String> students;
  final String board;
  final String std;
  final String batchSymbol; //IC10B2
  final String batchCategory; //IC10
  const Batch({
    required this.batchId,
    required this.students,
    required this.board,
    required this.std,
    required this.batchSymbol,
    required this.batchCategory,
  });

  Batch copyWith({
    String? batchId,
    List<String>? students,
    String? board,
    String? std,
    String? batchSymbol,
    String? batchCategory,
  }) {
    return Batch(
      batchId: batchId ?? this.batchId,
      students: students ?? this.students,
      board: board ?? this.board,
      std: std ?? this.std,
      batchSymbol: batchSymbol ?? this.batchSymbol,
      batchCategory: batchCategory ?? this.batchCategory,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'students': students});
    result.addAll({'board': board});
    result.addAll({'std': std});
    result.addAll({'batchSymbol': batchSymbol});
    result.addAll({'batchCategory': batchCategory});

    return result;
  }

  factory Batch.fromMap(Map<String, dynamic> map) {
    return Batch(
      batchId: map['\$id'] ?? '',
      students: List<String>.from(map['students']),
      board: map['board'] ?? '',
      std: map['std'] ?? '',
      batchSymbol: map['batchSymbol'] ?? '',
      batchCategory: map['batchCategory'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Batch.fromJson(String source) => Batch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Batch(batchId: $batchId, students: $students, board: $board, std: $std, batchSymbol: $batchSymbol, batchCategory: $batchCategory)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Batch &&
        other.batchId == batchId &&
        listEquals(other.students, students) &&
        other.board == board &&
        other.std == std &&
        other.batchSymbol == batchSymbol &&
        other.batchCategory == batchCategory;
  }

  @override
  int get hashCode {
    return batchId.hashCode ^
        students.hashCode ^
        board.hashCode ^
        std.hashCode ^
        batchSymbol.hashCode ^
        batchCategory.hashCode;
  }
}
