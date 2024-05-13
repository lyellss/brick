import 'package:brick/brick.dart';
import 'package:flutter/material.dart';

/// 基本按钮样式
class BasicButton extends StatelessWidget {
  /// 默认最大
  final double? width;

  /// 默认最大
  final double? height;

  /// 点击回调
  final VoidCallback? onTap;

  /// 按钮标题
  final String? text;

  /// 按钮颜色
  final Color color;

  /// 按钮字体大小
  final double textSize;

  /// 按钮字体颜色
  final Color textColor;

  final FontWeight? fontWeight;

  /// 按钮圆角
  final double radius;

  /// 是否有边框
  final bool showBorder;

  /// 边框颜色
  final Color? borderColor;

  /// 边框大小
  final double borderSize;

  final EdgeInsets? padding;

  const BasicButton({
    super.key,
    this.width = double.maxFinite,
    this.height = double.maxFinite,
    this.onTap,
    this.text,
    this.textSize = 14,
    this.textColor = Colors.white,
    this.fontWeight,
    this.color = Colors.white,
    this.radius = 200,
    this.showBorder = false,
    this.borderColor,
    this.borderSize = 1,
    this.padding,
  });

  /// 默认最小尺寸
  const BasicButton.min({
    super.key,
    this.onTap,
    this.color = Colors.white,
    this.radius = 200,
    this.text,
    this.textSize = 14,
    this.textColor = Colors.white,
    this.fontWeight,
    this.showBorder = false,
    this.borderColor,
    this.borderSize = 1,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TapMaterial(
      color: color,
      onTap: onTap,
      radius: radius,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: showBorder
              ? Border.all(color: borderColor!, width: borderSize)
              : null,
        ),
        child: TextPlain(
            text: text ?? '',
            size: textSize,
            color: textColor,
            fontWeight: fontWeight),
      ),
    );
  }
}
