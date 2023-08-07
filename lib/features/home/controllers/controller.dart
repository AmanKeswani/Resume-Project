import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_project/models/models.dart';
import 'package:personal_project/repositories/repos.dart';

final scheduleProvider = FutureProvider.family((Ref ref, DateTime date) async {
  final cr = ref.watch(controllerProvider);
  return cr.getSchedule(date: date);
});

final controllerProvider =
    Provider((ref) => Controller(cr: ref.watch(commonRepoProvider)));

class Controller {
  final CommonRepo _cr;

  Controller({required CommonRepo cr}) : _cr = cr;

  Future<List<dynamic>> getSchedule({required DateTime date}) async {
    final list = await _cr.getFullSchedule(date: date);
    final returnList = [];

    for (Document item in list) {
      try {
        returnList.add(
          Test.fromMap(item.data),
        );
      } catch (_) {
        returnList.add(Lecture.fromMap(item.data));
      }
    }

    return returnList;
  }
}
