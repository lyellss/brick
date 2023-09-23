import 'package:brick/brick.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 基本的dialog样式
Future showSimpleDialog(
  BuildContext context, {
  required Widget child,
  bool barrierDismissible = true,
}) {
  return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: child,
        );
      });
}

/// 加载中 Dialog
Future showLoadingDialog(
  BuildContext context, {
  required Widget dialog,
  bool barrierDismissible = true,
}) {
  return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              width: 48,
              height: 48,
              child: const LoadingWidget(),
            ),
          ),
        );
      });
}

/// 网络请求dialog附带弹窗
/// [OnLoading] 网络请求
void showLoadingWithBlock(
  BuildContext context, {
  required OnLoading onLoading,
  OnSuccess? onSuccess,
  OnFailure? onFailure,
  bool barrierDismissible = true,
}) async {
  bool showing = true;
  NavigatorState navigator = Navigator.of(context);
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: Builder(
              builder: (context) {
                return LoadingDialogWrapper(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 48,
                    height: 48,
                    child: const LoadingWidget(size: 48),
                  ),
                );
              },
            ),
          ),
        );
      }).then(
    (value) {
      showing = false;
    },
  );

  try {
    dynamic value = await onLoading.call();
    if (showing) {
      navigator.pop();
      showing = false;
    }
    onSuccess?.call(value);
  } catch (e, stackTrace) {
    debugPrint('$_tag error:');
    if (kDebugMode) {
      debugPrint('$_tag: start print error');
      print(e);
      print(stackTrace);
      debugPrint('$_tag: end print error');
    }
    if (showing) {
      navigator.maybePop();
    }
    onFailure?.call(e);
  }
}

/// 异步请求
typedef OnLoading<T> = Future<T> Function();

/// 获取成功
typedef OnSuccess<T> = Function(T value);

/// 获取失败
typedef OnFailure<E> = Function(E error);

const _tag = 'LoadingDialogWrapper';

class LoadingDialogWrapper<T> extends StatefulWidget {
  final Widget child;

  const LoadingDialogWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State createState() => _LoadingDialogWrapperState();
}

class _LoadingDialogWrapperState extends State<LoadingDialogWrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
