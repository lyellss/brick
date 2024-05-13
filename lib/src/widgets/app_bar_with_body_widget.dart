import 'package:brick/brick.dart';
import 'package:flutter/material.dart';

class AppBarWithBodyWidget extends StatelessWidget {
  /// 考虑使用[AppBarBasicWidget]
  final Widget appbar;

  /// appbar 之下的body widget
  final Widget body;

  /// body 是否充满余下的空间
  final bool fillBody;

  const AppBarWithBodyWidget({
    super.key,
    required this.appbar,
    required this.body,
    this.fillBody = true,
  });

  @override
  Widget build(BuildContext context) {
    if (fillBody) {
      return Column(
        children: [appbar, Expanded(child: body)],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [appbar, body],
    );
  }
}
