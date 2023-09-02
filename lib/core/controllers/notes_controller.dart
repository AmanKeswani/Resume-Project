import 'dart:io';

// import 'package:appwrite/models.dart';
import 'package:appwrite/models.dart' show Document;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/core/models/models.dart';
import 'package:personal_project/core/repositories/repos.dart';
import 'package:personal_project/utils/widgets/widgets.dart';

final notesControllerProvider = Provider((ref) => NotesController(
      repo: ref.watch(notesRepoProvider),
      storage: ref.watch(storageAPIProvider),
    ));

class NotesController {
  final NotesRepo _notesRepo;
  final StorageAPI _storageRepo;

  const NotesController({
    required NotesRepo repo,
    required StorageAPI storage,
  })  : _notesRepo = repo,
        _storageRepo = storage;

  void createNote({
    required BuildContext context,
    required String subject,
    required String std,
    required String board,
    required List<String> topics,
    required List<File> noteFiles,
    required List<File> practiceSheetFiles,
  }) async {
    final notesFileId = await _storageRepo.createNoteFiles(files: noteFiles);
    final practiceFileId =
        await _storageRepo.createPracticeSheetFile(files: practiceSheetFiles);

    final res = await _notesRepo.createNote(
        notes: Notes(
      notesId: '',
      subject: subject,
      std: std,
      board: board,
      topics: topics,
      notesFileId: notesFileId,
      practiceSheetFileId: practiceFileId,
    ));

    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, "Notes Added to Database"),
    );
  }

  void deleteNotes({
    required BuildContext context,
    required String notesId,
  }) async {
    final res = await _notesRepo.deleteNotes(notesId: notesId);
    res.fold((l) => showSnackBar(context, l.message),
        (r) => showSnackBar(context, "Deleted"));
  }

  Future<List<Notes>> getAllNotes() async {
    final notesDocs = (await _notesRepo.getAllNotes());
    final List<Notes> notesList = [];
    for (Document note in notesDocs) {
      notesList.add(Notes.fromMap(note.data)) as Notes;
    }
    return notesList;
  }

  void editNote({
    required BuildContext context,
    required String documentId,
    required Notes note,
  }) async {
    final res = await _notesRepo.editNote(
      documentId: documentId,
      note: note,
    );
    res.fold((l) => showSnackBar(context, l.message),
        (r) => showSnackBar(context, "Notes Edited"));
  }

  Future<Notes?> getNotesById({
    required BuildContext context,
    required String documentId,
  }) async {
    final doc = await _notesRepo.getNotesById(documentId: documentId);
    return Notes.fromMap(doc.data);
  }

  // void getNotesByStdAndSubject
}
