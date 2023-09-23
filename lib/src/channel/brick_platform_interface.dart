import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'brick_method_channel.dart';

abstract class BrickPlatform extends PlatformInterface {
  /// Constructs a BrickPlatform.
  BrickPlatform() : super(token: _token);

  static final Object _token = Object();

  static BrickPlatform _instance = MethodChannelBrick();

  /// The default instance of [BrickPlatform] to use.
  ///
  /// Defaults to [MethodChannelBrick].
  static BrickPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BrickPlatform] when
  /// they register themselves.
  static set instance(BrickPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
