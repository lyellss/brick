import 'dart:io';

import 'package:flutter/material.dart';

/// 移除 Android 下拉纹理波纹
class NoOverScrollBehavior extends ScrollBehavior {
  const NoOverScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          axisDirection: details.direction,
          color: Theme.of(context).colorScheme.secondary,
          showTrailing: false,
          child: child,
        );
    }
  }
}
