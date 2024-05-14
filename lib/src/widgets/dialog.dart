import 'package:brick/brick.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

export 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

const _tag = 'LoadingDialogWrapper';

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
/// [OnLoading] 异步操作
/// [forceCallback] 主动退出 dialog 是否继续执行 [onSuccess] 回调
Future showLoadingWithBlock({
  Widget? dialog,
  required OnLoading onLoading,
  OnSuccess? onSuccess,
  OnFailure? onFailure,
  bool barrierDismissible = true,
  bool forceCallback = false,
}) async {
  // 用户主动退出dialog
  bool userDismiss = false;
  SmartDialog.show(
    tag: _tag,
    builder: (BuildContext context) {
      if (dialog != null) {
        return dialog;
      }
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: Builder(
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              width: 48,
              height: 48,
              child: const LoadingWidget(size: 48),
            );
          },
        ),
      );
    },
  ).then((value) {
    userDismiss = true;
  });
  try {
    dynamic value = await onLoading.call();
    SmartDialog.dismiss(tag: _tag);
    if (userDismiss.not) {
      onSuccess?.call(value);
    }
    if (userDismiss && forceCallback) {
      onSuccess?.call(value);
    }
    debugPrint('$_tag: userDoDismiss $userDismiss');
  } catch (e, stackTrace) {
    debugPrint('$_tag error:');
    if (kDebugMode) {
      debugPrint('$_tag: start print error');
      print(e);
      print(stackTrace);
      debugPrint('$_tag: end print error');
    }
    SmartDialog.dismiss(tag: _tag);
    onFailure?.call(e);
  }
}

/// 异步请求
typedef OnLoading<T> = Future<T> Function();

/// 获取成功
typedef OnSuccess<T> = Function(T value);

/// 获取失败
typedef OnFailure<E> = Function(E error);
