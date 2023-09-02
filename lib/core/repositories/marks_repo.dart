import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/core/models/models.dart';

abstract class IMarksRepo {
  FutureEither<Document> createMarks({
    required Marks marks,
  });

  FutureEitherVoid editMarks({
    required String documentId,
    required Marks marks,
  });
}

final marksRepoProvider =
    Provider((ref) => MarksRepo(db: ref.watch(appwriteDatabaseProvider)));

class MarksRepo implements IMarksRepo {
  final Databases _db;

  const MarksRepo({required Databases db}) : _db = db;

  @override
  FutureEither<Document> createMarks({
    required Marks marks,
  }) async {
    try {
      final doc = await _db.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.marksCollectionId,
        documentId: ID.unique(),
        data: marks.toMap(),
      );

      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some unexpected Error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEitherVoid editMarks({
    required String documentId,
    required Marks marks,
  }) async {
    try {
      await _db.updateDocument(
        collectionId: AppwriteConstants.marksCollectionId,
        databaseId: AppwriteConstants.databaseID,
        documentId: documentId,
        data: marks.toMap(),
      );

      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some unexpected Error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
