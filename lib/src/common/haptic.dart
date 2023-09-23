import 'package:flutter/services.dart';

const _tag = 'Vibrator';

class Haptic {
  const Haptic._();

  static void lightImpact() {
    HapticFeedback.lightImpact();
  }
}
