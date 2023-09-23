import 'package:brick/src/widgets/route/pop_layout.dart';
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

class PopWindowRoute<T> extends PopupRoute<T> {
  final Widget? child;

  final Offset? offset;

  /// 遮罩颜色
  final Color? maskColor;

  /// 过度动画时间
  final Duration duration;

  PopWindowRoute({
    this.child,
    this.offset,
    this.maskColor,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  String? get barrierLabel => null;

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return CustomSingleChildLayout(
      delegate: PopRouteLayout(offset: offset),
      child: Container(
        color: maskColor ?? Colors.grey.withAlpha(100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            child ?? nil,
            Expanded(
              child: LayoutBuilder(builder: (c, b) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: b.constrainHeight(),
                    width: b.constrainWidth(),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
