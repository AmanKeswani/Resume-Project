import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/core/models/models.dart';

final testRepoProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  return TestRepo(db: db);
});

abstract class ITestRepo {
  FutureEither<Document> addTest({required Test test});
  Future<List<Document>> getAllTests({DateTime? date});
}

class TestRepo implements ITestRepo {
  final Databases _db;

  TestRepo({required Databases db}) : _db = db;

  @override
  FutureEither<Document> addTest({required Test test}) async {
    try {
      final doc = await _db.createDocument(
          databaseId: AppwriteConstants.databaseID,
          collectionId: AppwriteConstants.testsCollectionId,
          documentId: ID.unique(),
          data: test.toMap());
      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Appwrite Exception", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getAllTests({DateTime? date}) async {
    final docs = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseID,
      collectionId: AppwriteConstants.testsCollectionId,
      queries: [],
    );
    return docs.documents;
  }
}
