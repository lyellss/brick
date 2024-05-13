import 'dart:io';

import 'package:flutter/foundation.dart';

extension ExtensionString on String {
  String get img => "assets/images/$this";

  double get asDouble {
    if (isEmpty) {
      return 0.0;
    }
    try {
      double? parseValue = double.tryParse(this);
      return parseValue ?? 0.0;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 0.0;
    }
  }

  int get asInt {
    if (isEmpty) {
      return 0;
    }
    try {
      int? parseValue = int.tryParse(this);
      return parseValue ?? 0;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 0;
    }
  }

  bool equalsIgnoreCase(String other) {
    return toUpperCase() == other.toUpperCase();
  }

  bool containsIgnoreCase(String other) {
    return toUpperCase().contains(other.toUpperCase());
  }

  String get png => 'assets/images/$this.png';

  String get jpg => 'assets/images/$this.jpg';

  Future<void> fileSafeDelete() async {
    File file = File(this);
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}

/// 字符串扩展
extension ExtensionStringNullAble on String? {
  /// 空或者不存在
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// 非空
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isEmpty => this != null && this!.isEmpty;

  bool equalsIgnoreCase(String? other) {
    return (this == null && other == null) ||
        (this != null &&
            other != null &&
            this!.toLowerCase() == other.toLowerCase());
  }

  double get asDouble {
    if (isNullOrEmpty) {
      return 0;
    }
    return double.tryParse(this!) ?? 0;
  }
}
