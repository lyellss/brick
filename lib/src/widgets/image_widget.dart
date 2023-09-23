import 'package:brick/brick.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String image;

  final Size? size;

  final double? squareSize;

  final VoidCallback? onTap;

  final EdgeInsets? paddingInsets;

  final String? package;

  final double radius;

  const ImageWidget({
    required this.image,
    this.squareSize,
    this.size,
    this.onTap,
    this.paddingInsets,
    this.package,
    this.radius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: paddingInsets ?? EdgeInsets.all(4),
            child: Image.asset(
              image.png,
              width: squareSize ?? size!.width,
              height: squareSize ?? size!.height,
              package: package,
            ),
          ),
        ),
      ),
    );
  }
}
