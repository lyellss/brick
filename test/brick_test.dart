import 'package:flutter_test/flutter_test.dart';
import 'package:brick/brick.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBrickPlatform
    with MockPlatformInterfaceMixin
    implements BrickPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BrickPlatform initialPlatform = BrickPlatform.instance;

  test('$MethodChannelBrick is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBrick>());
  });
}
