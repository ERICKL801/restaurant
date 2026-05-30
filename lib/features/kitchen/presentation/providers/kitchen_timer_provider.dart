import 'package:flutter_riverpod/flutter_riverpod.dart';

final kitchenTimerProvider = StreamProvider.autoDispose<int>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (count) => count);
});
