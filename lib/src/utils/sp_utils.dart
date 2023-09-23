import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 使用前必须先调用 init()
/// 示例如下：
///
/// ```dart
/// WidgetsFlutterBinding.ensureInitialized();
/// sp.init();
/// runApp(const MyApp());
/// ```

final Sp sp = Sp();

class Sp {
  late SharedPreferences _sharedPreferences;

  /// 将匿名构造方法私有化
  Sp._();

  /// 创建外部使用的类属性
  /// static表示属性是类属性，final表示属性是常量，只能被赋值一次。这两者结合，就能够实现单例。
  static final Sp _instance = Sp._();

  /// 使用工厂方法，将类属性的调用给隐藏起来
  factory Sp() => _instance;

  Future init() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> put<T>(String key, T value) {
    debugPrint('value ${value.runtimeType}');
    if (value is String) {
      return _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return _sharedPreferences.setBool(key, value);
    } else {
      throw Exception('Sp not support type');
    }
  }

  String getString(String key, {String def = ''}) {
    return _sharedPreferences.getString(key) ?? def;
  }

  int getInt(String key, {int def = 0}) {
    return _sharedPreferences.getInt(key) ?? def;
  }

  double getDouble(String key, {double def = 0.0}) {
    return _sharedPreferences.getDouble(key) ?? def;
  }

  bool getBool(String key, {bool def = false}) {
    return _sharedPreferences.getBool(key) ?? def;
  }

  Future<bool> putStringList(String key, List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  List<String> getStringList(String key, {List<String> def = const []}) {
    return _sharedPreferences.getStringList(key) ?? def;
  }

  Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }

  Future<void> reload() async {
    return _sharedPreferences.reload();
  }

  bool containsKey(String key) => _sharedPreferences.containsKey(key);

  Set<String> getKeys() => _sharedPreferences.getKeys();
}
