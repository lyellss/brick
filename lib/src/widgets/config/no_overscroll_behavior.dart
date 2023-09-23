import 'dart:io';

import 'package:flutter/material.dart';

/// 移除 Android 下拉纹理波纹
class NoOverScrollBehavior extends ScrollBehavior {
  const NoOverScrollBehavior();

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isIOS) {
      return child;
    } else {
      return GlowingOverscrollIndicator(
        showLeading: false,
        //不显示尾部水波纹
        showTrailing: false,
        axisDirection: axisDirection,
        color: Theme.of(context).colorScheme.secondary,
        child: child,
      );
    }
  }
}
