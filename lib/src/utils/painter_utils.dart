import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

typedef OnDrawText = Function(Paragraph paragraph, TextPainter painter);

/// 生成 Paint
Paint newPaint(Color color) {
  return Paint()
    ..strokeCap = StrokeCap.round
    ..color = color
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;
}

void drawText(
  String text,
  Offset offset,
  double fontSize,
  Color fontColor, {
  required OnDrawText toDrawText,
}) {
  ui.TextStyle textStyle = ui.TextStyle(color: fontColor, fontSize: fontSize);
  TextPainter painter = TextPainter(
      text: TextSpan(
          text: text, style: TextStyle(color: fontColor, fontSize: fontSize)),
      textDirection: TextDirection.ltr);
  painter.layout();
  ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(fontSize: fontSize))
    ..pushStyle(textStyle)
    ..addText(text);
  ParagraphConstraints pc = ParagraphConstraints(width: painter.size.width);
  Paragraph paragraph = pb.build()..layout(pc);
  toDrawText.call(paragraph, painter);
}
