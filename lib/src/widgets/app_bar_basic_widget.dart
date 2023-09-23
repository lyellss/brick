import 'package:brick/brick.dart';
import 'package:flutter/material.dart';

class AppBarBasicWidget extends StatelessWidget implements PreferredSizeWidget {
  /// 标题栏文字
  final String? title;

  /// 标题栏颜色
  final Color? backgroundColor;

  /// 标题栏文字颜色
  final Color textColor;

  /// 标题栏文字大小
  final double? textSize;

  /// 显示 back icon
  final bool showBack;

  /// 返回 icon color
  final Color? backIconColor;

  /// 返回icon图片
  final String? backIcon;

  /// 返回 icon 大小
  final double? iconSize;

  /// app bar 高度，该高度不包含刘海的高度
  /// 整个app bar 的高度是刘海高度+[height]
  final double? height;

  /// 右边widget
  final Widget? right;

  /// 标题栏剧中显示的widget
  /// 如果该widget赋值[title]相关的所有属性将不再生效
  final Widget? leading;

  /// 返回点击，不赋值将默认结束页面
  final VoidCallback? backTap;

  /// 标题字重
  final FontWeight titleFontWeight;

  final bool showDivider;

  final Color dividerColor;

  const AppBarBasicWidget({
    Key? key,
    this.title,
    this.backgroundColor,
    this.textColor = const Color(0xFF333333),
    this.textSize,
    this.height,
    this.right,
    this.backTap,
    this.backIconColor = Colors.white,
    this.backIcon,
    this.iconSize,
    this.showBack = true,
    this.leading,
    this.titleFontWeight = FontWeight.w500,
    this.showDivider = false,
    this.dividerColor = const Color(0xFFEEEEEE),
  })  : assert(title != null || leading != null),
        super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? widgetConfig.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor ?? Colors.white,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: preferredSize.height,
          width: preferredSize.width,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: leading ??
                          TextPlain(
                            text: title,
                            size: (textSize ?? widgetConfig.appbarTitleSize).sp,
                            color: textColor,
                            fontWeight: titleFontWeight,
                          ),
                    ),
                    if (showBack)
                      Container(
                        padding: EdgeInsets.only(left: 12.w),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            if (backTap != null) {
                              backTap?.call();
                            } else {
                              Navigator.of(context).maybePop();
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            child: Image.asset(
                              backIcon ?? 'ic_back.png'.img,
                              width: 20.w,
                              height: 20.w,
                              package: backIcon == null ? kPackageName : null,
                            ),
                          ),
                        ),
                      ),
                    if (right != null)
                      Container(
                        alignment: Alignment.centerRight,
                        child: right,
                      ),
                  ],
                ),
              ),
              if (showDivider)
                Container(
                  height: 1,
                  color: dividerColor,
                )
            ],
          ),
        ),
      ),
    );
  }
}
