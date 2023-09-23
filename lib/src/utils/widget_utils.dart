import 'package:flutter/material.dart';

TextStyle textStyle(
  double? size, {
  Color? color,
  bool bold = false,
  TextDecoration decoration = TextDecoration.none,
}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    decoration: decoration,
  );
}

/// 测量字体大小
Size measureTextSize(
  String? text,
  TextStyle? style, {
  double minWidth = 0.0,
  double maxWidth = double.infinity,
}) {
  if (text == null || style == null) {
    return Size.zero;
  }
  TextPainter painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  );
  painter.layout(minWidth: minWidth, maxWidth: maxWidth);
  return painter.size;
}

/// 获取到 widget 大小
Rect getWidgetOfRect(GlobalKey key) {
  RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
  Offset offset = box.localToGlobal(Offset.zero);
  return Rect.fromLTWH(
      offset.dx, offset.dy, box.paintBounds.width, box.paintBounds.height);
}
