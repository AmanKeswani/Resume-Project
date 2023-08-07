import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/repositories/repos.dart';

abstract class ICommonRepo {
  Future<List<Document>> getFullSchedule({required DateTime date});
}

final commonRepoProvider = Provider(
  (ref) => CommonRepo(
    lr: ref.watch(lectureRepoProvider),
    tr: ref.watch(testRepoProvider),
  ),
);

class CommonRepo implements ICommonRepo {
  final TestRepo _tr;
  final LectureRepo _lr;

  CommonRepo({
    required TestRepo tr,
    required LectureRepo lr,
  })  : _lr = lr,
        _tr = tr;

  @override
  Future<List<Document>> getFullSchedule({required DateTime date}) async {
    final tests = await _tr.getAllTests();
    final lectures = await _lr.getAllLectures();

    final List<Document> finalList = [];
    for (Document item in tests) {
      finalList.add(item);
    }
    for (Document item in lectures) {
      finalList.add(item);
    }
    return finalList;
  }
}
