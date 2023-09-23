import 'package:flutter/material.dart';

mixin FrameCallbackMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onPostFrameCallback();
    });
  }

  void onPostFrameCallback() {}
}
