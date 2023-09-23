import 'package:flutter/material.dart';

class PopRouteLayout<T> extends SingleChildLayoutDelegate {
  Offset? offset;

  PopRouteLayout({
    this.offset,
  });

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    return true;
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return offset!;
  }
}
