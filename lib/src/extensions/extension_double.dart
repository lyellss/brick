import 'dart:math' as math;
import 'dart:ui';

extension ExtensionNumNullAbleUtils on num? {
  int get asInt {
    if (this == null) {
      return 0;
    }
    return this!.toInt();
  }

  double get asDouble {
    if (this == null) {
      return 0.0;
    }
    return this!.toDouble();
  }
}

extension ExtensionDoubleNullAbleUtils on double {
  Size get size => Size(this, this);
}

extension ExtensionDoubleUtils on double? {
  /// 小数位数（会移除小数点后面无效的0）
  int get decimalBit {
    int count = 1;
    for (;;) {
      if (this! * math.pow(10, count) % 1 == 0) {
        break;
      }
      count++;
    }
    return count;
  }

  /// 小数转为百分数
  String get percentage {
    if (this == null) {
      return '0%';
    }
    return '${(this! * 100).toStringAsFixed(2)}%';
  }

  String get as2Decimal {
    if (this == null) {
      return '0.00';
    }
    return this!.toStringAsFixed(2);
  }
}
