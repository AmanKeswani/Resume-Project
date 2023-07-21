import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/models/models.dart';

abstract class IUserRepo {
  FutureEitherVoid saveStudentData(Student student);
}

final studentRepoProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  return UserRepo(db: db);
});

class UserRepo implements IUserRepo {
  final Databases _db;

  UserRepo({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveStudentData(Student student) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.studentCollectionID,
        documentId: student.studentId,
        data: student.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "some unexpected error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
