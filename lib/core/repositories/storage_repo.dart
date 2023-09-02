import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:personal_project/constants/constants.dart';
import 'package:personal_project/core/core.dart';

abstract class IStorageAPI {
  Future<List<String>> createNoteFiles({
    required List<File> files,
  });

  Future<List<String>> createPracticeSheetFile({
    required List<File> files,
  });

  FutureEitherVoid deleteNotesFile({
    required List<String> fileIds,
  });
}

final storageAPIProvider =
    Provider((ref) => StorageAPI(storage: ref.watch(appwriteStorageProvider)));

class StorageAPI implements IStorageAPI {
  final Storage _storage;

  const StorageAPI({required Storage storage}) : _storage = storage;

  @override
  Future<List<String>> createNoteFiles({
    required List<File> files,
  }) async {
    List<String> imageLinks = [];
    for (final file in files) {
      final uploadedImage = await _storage.createFile(
        bucketId: AppwriteConstants.notesBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
      );
      imageLinks.add(
        AppwriteConstants.notesBucketFileUrl(uploadedImage.$id),
      );
    }
    return imageLinks;
  }

  @override
  Future<List<String>> createPracticeSheetFile({
    required List<File> files,
  }) async {
    List<String> imageLinks = [];
    for (final file in files) {
      final uploadedImage = await _storage.createFile(
        bucketId: AppwriteConstants.notesBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
      );
      imageLinks.add(
        AppwriteConstants.practiceSheetsBucketFileUrl(uploadedImage.$id),
      );
    }
    return imageLinks;
  }

  @override
  FutureEitherVoid deleteNotesFile({
    required List<String> fileIds,
  }) async {
    try {
      for (String fileId in fileIds) {
        await _storage.deleteFile(
            bucketId: AppwriteConstants.notesBucketId, fileId: fileId);
      }
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some unexpected Error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
