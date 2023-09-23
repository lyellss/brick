import 'package:flutter/cupertino.dart';

extension ExtensionPluginTextEditingControllerUtils on TextEditingController {
  void selectionToLast() {
    this.selection =
        TextSelection.fromPosition(TextPosition(offset: this.text.length));
  }

  void updateValue(String value) {
    this.text = value;
    this.selectionToLast();
  }
}
