import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/core/models/models.dart';

abstract class IAttendanceRepo {
  FutureEither<Document> createAttendance({
    required Attendance attendance,
  });

  FutureEither<bool> editAttendance({
    required String documentId,
    required Attendance attendance,
  });
}

final attendanceRepoProvider =
    Provider((ref) => AttendanceRepo(db: ref.watch(appwriteDatabaseProvider)));

class AttendanceRepo implements IAttendanceRepo {
  final Databases _db;

  const AttendanceRepo({required Databases db}) : _db = db;

  @override
  FutureEither<Document> createAttendance({
    required Attendance attendance,
  }) async {
    try {
      final doc = await _db.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.attendanceCollectionId,
        documentId: ID.unique(),
        data: attendance.toMap(),
      );

      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some unexpected Error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<bool> editAttendance({
    required String documentId,
    required Attendance attendance,
  }) async {
    try {
      await _db.updateDocument(
        collectionId: AppwriteConstants.attendanceCollectionId,
        databaseId: AppwriteConstants.databaseID,
        documentId: documentId,
        data: attendance.toMap(),
      );

      return right(true);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some unexpected Error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
