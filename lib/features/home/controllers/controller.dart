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
    final list = await _cr.getFullSchedule();
    final tempList = [];

    for (Document item in list) {
      try {
        tempList.add(
          Test.fromMap(item.data),
        );
      } catch (_) {
        tempList.add(Lecture.fromMap(item.data));
      }
    }
    final returnList = [];
    for (dynamic item in tempList) {
      if (item.startTime.year == date.year &&
          item.startTime.month == date.month &&
          item.startTime.day == date.day) {
        returnList.add(item);
      }
    }

    return returnList;
  }
}
