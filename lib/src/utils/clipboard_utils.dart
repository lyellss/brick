import 'package:flutter/services.dart';

extension ExtensionClipboardString on String {
  void toClipboard() {
    if (isEmpty) {
      return;
    }
    Clipboard.setData(ClipboardData(text: this));
  }
}

/// 获取剪贴板数据
Future<String> getClipboardText() async {
  ClipboardData? value = await Clipboard.getData(Clipboard.kTextPlain);
  return value?.text ?? '';
}
