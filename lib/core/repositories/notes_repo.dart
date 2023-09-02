import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/appwrite_constants.dart';
import 'package:personal_project/core/core.dart';
import 'package:personal_project/core/models/models.dart';

abstract class INotesRepo {
  FutureEither<Document> createNote({
    required Notes notes,
  });

  FutureEitherVoid deleteNotes({
    required String notesId,
  });

  Future<List<Document>> getAllNotes();

  FutureEitherVoid editNote({
    required String documentId,
    required Notes note,
  });

  Future<Document> getNotesById({
    required String documentId,
  });

  Future<List<Document>> getNotesByStdAndSubject({
    String? std,
    String? subject,
  });
}

final notesRepoProvider = Provider((ref) {
  final db = ref.watch(appwriteDatabaseProvider);
  return NotesRepo(db: db);
});

class NotesRepo implements INotesRepo {
  final Databases _db;

  const NotesRepo({
    required Databases db,
  }) : _db = db;

  @override
  FutureEither<Document> createNote({
    required Notes notes,
  }) async {
    try {
      final doc = await _db.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.notesCollectionId,
        documentId: ID.unique(),
        data: notes.toMap(),
      );
      return right(doc);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some Unexpected Error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEitherVoid deleteNotes({
    required String notesId,
  }) async {
    try {
      await _db.deleteDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.notesCollectionId,
        documentId: notesId,
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Unknown Appwrite Exception", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEitherVoid editNote({
    required String documentId,
    required Notes note,
  }) async {
    try {
      await _db.updateDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.notesCollectionId,
        documentId: documentId,
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Unknown Appwrite Exception", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getAllNotes() async {
    final docs = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.notesCollectionId);

    return docs.documents;
  }

  @override
  Future<Document> getNotesById({
    required String documentId,
  }) async =>
      await _db.getDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.notesCollectionId,
        documentId: documentId,
      );

  @override
  Future<List<Document>> getNotesByStdAndSubject({
    String? std,
    String? subject,
  }) async {
    if (std == null && subject == null) return getAllNotes();
    if (std != null && subject == null) {
      return (await _db.listDocuments(
              databaseId: AppwriteConstants.databaseID,
              collectionId: AppwriteConstants.notesCollectionId,
              queries: [Query.equal('std', std)]))
          .documents;
    }
    if (subject != null && std == null) {
      return (await _db.listDocuments(
              databaseId: AppwriteConstants.databaseID,
              collectionId: AppwriteConstants.notesCollectionId))
          .documents;
    }
    return (await _db.listDocuments(
            databaseId: AppwriteConstants.databaseID,
            collectionId: AppwriteConstants.notesCollectionId,
            queries: [
          Query.equal('std', std),
          Query.equal('subject', subject),
        ]))
        .documents;
  }
}
