import 'dart:math';

Future<void> randomDelay(
  Random rnd, {
  int minSec = 2,
  int maxSec = 8,
}) async {
  final delay = minSec + rnd.nextInt(maxSec - minSec);
  await Future.delayed(Duration(seconds: delay));
}
