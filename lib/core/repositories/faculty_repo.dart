import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/core/models/models.dart';

abstract class IFacultyRepo {
  FutureEither<Document> createFaculty({
    required Faculty faculty,
  });

  Future<Document> getFacultyById({
    required String documentId,
  });

  // Future<List<Document>> getFacultyByName({
  //   required String name,
  // });
}

final facultyRepoProvider =
    Provider((ref) => FacultyRepo(db: ref.watch(appwriteDatabaseProvider)));

class FacultyRepo implements IFacultyRepo {
  final Databases _db;

  const FacultyRepo({required Databases db}) : _db = db;

  @override
  FutureEither<Document> createFaculty({
    required Faculty faculty,
  }) async {
    try {
      final doc = await _db.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.facultyCollectionId,
        documentId: ID.unique(),
        data: faculty.toMap(),
      );
      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "some unexpected error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<Document> getFacultyById({
    required String documentId,
  }) async {
    final doc = await _db.getDocument(
      databaseId: AppwriteConstants.databaseID,
      collectionId: AppwriteConstants.facultyCollectionId,
      documentId: documentId,
    );
    return doc;
  }

  // @override
  // Future<List<Document>> getFacultyByName({
  //   required String name,
  // }) async {
  //   final docs = await _db.listDocuments(
  //     collectionId: AppwriteConstants.facultyCollectionId,
  //     databaseId: AppwriteConstants.databaseID,
  //     queries: [
  //       Query.search('firstName', name),
  //       Query.search('lastName', name),
  //     ],
  //   );
  //   return docs.documents;
  // }
}
