import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/core/models/models.dart';

abstract class IBatchRepo {
  FutureEither<Document> createBatch({
    required Batch batch,
  });

  Future<List<Document>> getAllBatches();

  // FutureEither<List<Document>> getBatchesByStd();

  FutureEither<bool> editBatch({
    required String documentId,
    required Batch batch,
  });
}

final batchRepoProvider =
    Provider((ref) => BatchRepo(db: ref.watch(appwriteDatabaseProvider)));

class BatchRepo implements IBatchRepo {
  final Databases _db;

  const BatchRepo({required Databases db}) : _db = db;

  @override
  FutureEither<Document> createBatch({
    required Batch batch,
  }) async {
    try {
      final doc = await _db.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.batchesCollectioId,
        documentId: ID.unique(),
        data: batch.toMap(),
      );
      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some unexpected Argument", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<bool> editBatch({
    required String documentId,
    required Batch batch,
  }) async {
    try {
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseID,
          collectionId: AppwriteConstants.batchesCollectioId,
          documentId: documentId,
          data: batch.toMap());

      return right(true);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some unexpected Error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getAllBatches() async {
    final docs = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseID,
      collectionId: AppwriteConstants.batchesCollectioId,
    );
    return docs.documents;
  }
}
