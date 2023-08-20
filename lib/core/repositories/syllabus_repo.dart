import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/appwrite_constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/core/models/models.dart';

abstract class ISyllabusRepo {
  FutureEither<Document> addSyllabus({
    required Syllabus syllabus,
  });

  FutureEither<bool> editSyllabus({
    required Syllabus syllabus,
    required String id,
  });
}

final syllabusRepoProvider =
    Provider((ref) => SyllabusRepo(db: ref.watch(appwriteDatabaseProvider)));

class SyllabusRepo implements ISyllabusRepo {
  final Databases _db;

  const SyllabusRepo({required Databases db}) : _db = db;

  @override
  FutureEither<Document> addSyllabus({
    required Syllabus syllabus,
  }) async {
    try {
      final doc = await _db.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.syllabusCollectionId,
        documentId: ID.unique(),
        data: syllabus.toMap(),
      );

      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Unexpected Appwrite Exception", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<bool> editSyllabus({
    required Syllabus syllabus,
    required String id,
  }) async {
    try {
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseID,
          collectionId: AppwriteConstants.syllabusCollectionId,
          documentId: id,
          data: syllabus.toMap());
      return right(true);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Unexpected Appwrite Exception", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
