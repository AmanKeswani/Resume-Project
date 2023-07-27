import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/models/models.dart';

abstract class IStudentRepo {
  FutureEither<Document> createStudent({
    required Student student,
    required String documentId,
  });
}

final studentRepoProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  return StudentRepo(db: db);
});

class StudentRepo implements IStudentRepo {
  final Databases _db;

  StudentRepo({required Databases db}) : _db = db;

  @override
  FutureEither<Document> createStudent({
    required Student student,
    required String documentId,
  }) async {
    try {
      final doc = await _db.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.studentCollectionID,
        documentId: documentId,
        data: student.toMap(),
      );
      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "some unexpected error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
