import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  String formatDateTextMonth({required DateTime date}) {
    return DateFormat('dd - MMMM -  yyyy').format(date);
  }

  String formatDateNumberMonth({required DateTime date}) {
    return DateFormat('dd - mm -  yyyy').format(date);
  }

  Future<DateTime?> getDate({
    required BuildContext context,
  }) async =>
      await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
      );
  // const DateHelper._();
}

class TimeHelper {
  String formatTime({required DateTime time}) {
    return DateFormat('h : mm a').format(time);
  }

  Future<TimeOfDay?> getTime({
    required BuildContext context,
    required String helpText,
  }) async =>
      await showTimePicker(
        helpText: helpText,
        context: context,
        initialEntryMode: TimePickerEntryMode.inputOnly,
        initialTime: TimeOfDay.now(),
      );
  // const TimeHelper._();
}
