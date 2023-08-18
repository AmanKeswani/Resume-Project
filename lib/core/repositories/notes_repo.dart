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

  FutureEither<bool> deleteNotes({
    required Notes notes,
  });

  Future<List<Document>> getAllNotes();

  FutureEither<bool> editNote({
    required String documentId,
    required Notes note,
  });

  Future<List<Document>> getNotesById({
    required String documentId,
  });

  Future<List<Document>> getNotesByStdAndSubject({
    String? std,
    String? subject,
  });
}

final notesRepoProvider = Provider((ref) {
  final storage = ref.watch(appwriteStorageProvider);
  final db = ref.watch(appwriteDatabaseProvider);
  return NotesRepo(db: db, storage: storage);
});

class NotesRepo implements INotesRepo {
  final Databases _db;
  final Storage _storage;

  const NotesRepo({
    required Databases db,
    required Storage storage,
  })  : _db = db,
        _storage = storage;

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
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some Unexpected Error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<bool> deleteNotes({
    required Notes notes,
  }) {
    // TODO: implement deleteNotes
    throw UnimplementedError();
  }

  @override
  FutureEither<bool> editNote({
    required String documentId,
    required Notes note,
  }) {
    // TODO: implement editNote
    throw UnimplementedError();
  }

  @override
  Future<List<Document>> getAllNotes() {
    // TODO: implement getAllNotes
    throw UnimplementedError();
  }

  @override
  Future<List<Document>> getNotesById({
    required String documentId,
  }) {
    // TODO: implement getNotesById
    throw UnimplementedError();
  }

  @override
  Future<List<Document>> getNotesByStdAndSubject({
    String? std,
    String? subject,
  }) {
    // TODO: implement getNotesByStdAndSubject
    throw UnimplementedError();
  }
}
