import 'dart:math';

Future<void> randomRequestTime({
  int minSec = 2,
  int maxSec = 8,
}) async {
  final delay = minSec + Random().nextInt(maxSec - minSec);
  await Future.delayed(Duration(seconds: delay));
}
