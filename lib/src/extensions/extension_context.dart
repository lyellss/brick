import 'package:flutter/material.dart';

extension ExtensionContext on BuildContext {
  Future<T?> newPage<T extends Object?>(
    Widget page, {
    bool pageReplace = false,
  }) {
    if (pageReplace) {
      return newPageReplacement(page);
    }
    return Navigator.push<T>(this, MaterialPageRoute(builder: (builderContext) {
      return page;
    }));
  }

  Future<T?> newPageWithBuilder<T extends Object?>(
      PageRouteBuilder<T> builder) {
    return Navigator.push<T>(this, builder);
  }

  Future<T?> newPageReplacement<T extends Object?, TO extends Object?>(
      Widget page) {
    return Navigator.pushReplacement<T, TO>(this,
        MaterialPageRoute(builder: (builderContext) {
      return page;
    }));
  }

  Future<T?> newNamedPage<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future startNewFadePage(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
  }) {
    return Navigator.of(context).push(FadeRoute(page));
  }

  void pop<T extends Object?>({T? result}) {
    Navigator.pop<T>(this, result);
  }

  void maybePop<T extends Object?>({T? result}) {
    Navigator.maybePop<T>(this, result);
  }

  bool get isCurrent => ModalRoute.of(this)?.isCurrent ?? false;
}

extension ExtensionScreenContext on BuildContext {
  Size get mediaSize => MediaQuery.of(this).size;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get paddingTop => MediaQuery.of(this).padding.top;

  double get paddingBottom => MediaQuery.of(this).padding.bottom;
}

class FadeRoute extends PageRouteBuilder {
  final Widget widget;

  FadeRoute(this.widget)
      : super(
            // 设置过度时间
            transitionDuration: const Duration(milliseconds: 250),
            // 构造器
            pageBuilder: (
              // 上下文和动画
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return widget;
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              // 需要什么效果把注释打开就行了
              // 渐变效果
              return FadeTransition(
                // 从0开始到1
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  // 传入设置的动画
                  parent: animation,
                  // 设置效果，快进漫出   这里有很多内置的效果
                  curve: Curves.linear,
                )),
                child: child,
              );

              // 缩放动画效果
              // return ScaleTransition(
              //   scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
              //     parent: animaton1,
              //     curve: Curves.fastOutSlowIn
              //   )),
              //   child: child,
              // );

              // 旋转加缩放动画效果
              // return RotationTransition(
              //   turns: Tween(begin: 0.0,end: 1.0)
              //   .animate(CurvedAnimation(
              //     parent: animaton1,
              //     curve: Curves.fastOutSlowIn,
              //   )),
              //   child: ScaleTransition(
              //     scale: Tween(begin: 0.0,end: 1.0)
              //     .animate(CurvedAnimation(
              //       parent: animaton1,
              //       curve: Curves.fastOutSlowIn
              //     )),
              //     child: child,
              //   ),
              // );

              // 左右滑动动画效果
              // return SlideTransition(
              //   position: Tween<Offset>(
              //     // 设置滑动的 X , Y 轴
              //     begin: Offset(-1.0, 0.0),
              //     end: Offset(0.0,0.0)
              //   ).animate(CurvedAnimation(
              //     parent: animaton1,
              //     curve: Curves.fastOutSlowIn
              //   )),
              //   child: child,
              // );
            });
}
