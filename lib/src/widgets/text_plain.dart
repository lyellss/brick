import 'package:flutter/material.dart';

class TextPlain extends StatelessWidget {
  final String? text;

  final double size;

  final Color? color;

  final bool bold;

  /// 对齐方式
  final TextAlign? textAlign;

  final int? maxLines;

  final TextOverflow? overflow;

  /// 字体权重
  /// 如果传此参数，bold不在生效
  final FontWeight? fontWeight;

  const TextPlain({
    super.key,
    required this.text,
    required this.size,
    this.color,
    this.bold = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  });

  const TextPlain.textNormal({
    super.key,
    required this.text,
    required this.size,
    this.color,
    this.bold = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight = FontWeight.w400,
  });

  const TextPlain.textMedium({
    super.key,
    required this.text,
    required this.size,
    this.color,
    this.bold = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight = FontWeight.w500,
  });

  const TextPlain.textSemiBold({
    super.key,
    required this.text,
    required this.size,
    this.color,
    this.bold = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight = FontWeight.w600,
  });

  const TextPlain.textBold({
    super.key,
    required this.text,
    required this.size,
    this.color,
    this.bold = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: textFont,
      ),
    );
  }

  FontWeight get textFont {
    if (fontWeight != null) {
      return fontWeight!;
    }
    if (bold) {
      return FontWeight.bold;
    } else {
      return FontWeight.normal;
    }
  }
}
