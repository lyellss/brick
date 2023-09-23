import 'package:brick/src/widgets/text_plain.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart' as ok_toast;

/// 展示吐司
void showMyToast(
  String msg, {
  Duration duration = const Duration(milliseconds: 2000),
}) {
  ok_toast.showToastWidget(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(4)),
      child: TextPlain(text: msg, size: 14, color: Colors.white),
    ),
    duration: duration,
    dismissOtherToast: true,
    animationDuration: const Duration(milliseconds: 100),
  );
}

class MyToast extends StatelessWidget {
  final Widget child;

  const MyToast({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ok_toast.OKToast(
      child: child,
    );
  }
}
