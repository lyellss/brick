import 'package:flutter/foundation.dart';

abstract class BaseChangeNotifierModel with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

abstract class BaseSingleValueNotifierModel<T> extends BaseChangeNotifierModel {
  /// 数据
  T? value;

  BaseSingleValueNotifierModel({this.value});

  /// 有值
  bool get active => value != null;

  /// 更新数据并发送通知
  void update(T? data) {
    value = data;
    notifyListeners();
  }

  /// 更新数据但是不发送通知
  void updateWithoutNotify(T? data) {
    value = data;
  }
}
