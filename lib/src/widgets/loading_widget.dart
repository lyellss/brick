import 'package:brick/src/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final double size;

  final Color color;

  const LoadingWidget({
    this.size = 64,
    this.color = colorFFFFFFFF,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        height: size,
        width: size,
        child: defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator(),
      ),
    );
  }
}

class SpinKitLoadingWidget extends StatelessWidget {
  final Color circleColor;

  final Color backgroundColor;

  final double circleSize;

  const SpinKitLoadingWidget({
    this.circleColor = colorFFF5C71C,
    this.backgroundColor = colorFFFFFFFF,
    this.circleSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(6)),
        child: SpinKitThreeBounce(
          size: circleSize,
          color: circleColor,
        ),
      ),
    );
  }
}
