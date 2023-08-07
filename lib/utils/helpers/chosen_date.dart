import 'package:flutter_riverpod/flutter_riverpod.dart';

final chosenDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);
