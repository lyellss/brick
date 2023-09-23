import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'brick_platform_interface.dart';

/// An implementation of [BrickPlatform] that uses method channels.
class MethodChannelBrick extends BrickPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('brick');

  static const MethodChannel _channel = MethodChannel('brick_channel');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 根据包名打开三方APP
  static Future startActivityWithPackage(String packageName) {
    return _channel
        .invokeMethod('startActivityWithPackage', {'package': packageName});
  }

  /// 判断三方app是否已安装
  static Future<bool> isPackageInstalled(String packageName) async {
    bool installed = await _channel
        .invokeMethod('isPackageInstalled', {'package': packageName});
    return installed;
  }
}
