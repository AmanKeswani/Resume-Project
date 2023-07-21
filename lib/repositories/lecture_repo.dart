import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/models/models.dart';

abstract class ILectureRepo {
  Future<List<Document>> getAllLectures();
  FutureEither<Document> addLecture(Lecture lecture);
}

final lectureRepoProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  return LectureRepo(db: db);
});

class LectureRepo implements ILectureRepo {
  final Databases _db;

  LectureRepo({required Databases db}) : _db = db;

  @override
  Future<List<Document>> getAllLectures() async {
    final docs = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseID,
      collectionId: AppwriteConstants.lectureCollectionID,
      queries: [
        // Query.orderAsc("startTime"),
      ],
    );
    return docs.documents;
  }

  @override
  FutureEither<Document> addLecture(Lecture lecture) async {
    try {
      final doc = await _db.createDocument(
          databaseId: AppwriteConstants.databaseID,
          collectionId: AppwriteConstants.lectureCollectionID,
          documentId: ID.unique(),
          data: lecture.toMap());
      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(
          Failure(e.message ?? "Some Unexpected Appwrite Exception", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
