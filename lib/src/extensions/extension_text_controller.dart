import 'package:flutter/cupertino.dart';

extension ExtensionPluginTextEditingControllerUtils on TextEditingController {
  void selectionToLast() {
    selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  void updateValue(String value) {
    text = value;
    selectionToLast();
  }
}
