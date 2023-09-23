import 'package:flutter/material.dart';

/// Flutter key  扩展
extension ExtensionKey on GlobalKey {
  RenderBox get renderBox => currentContext!.findRenderObject() as RenderBox;

  /// 相对于屏幕左上角的便宜
  Offset get localToGlobalOffsetZero => renderBox.localToGlobal(Offset.zero);
}
