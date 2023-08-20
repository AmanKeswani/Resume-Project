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

  FutureEither<bool> deleteNotesFile({
    required String fileId,
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
        AppwriteConstants.notesBucketImageUrl(uploadedImage.$id),
      );
    }
    return imageLinks;
  }

  @override
  FutureEither<bool> deleteNotesFile({
    required String fileId,
  }) async {
    try {
      await _storage.deleteFile(
          bucketId: AppwriteConstants.notesBucketId, fileId: fileId);
      return right(true);
    } on AppwriteException catch (e, st) {
      return left(Failure(e.message ?? "Some unexpected Error", st));
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }
}
