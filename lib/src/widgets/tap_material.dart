import 'package:flutter/material.dart';

class TapMaterial extends StatelessWidget {
  final Widget child;

  final VoidCallback? onTap;

  final double radius;

  final Color color;

  final bool ripple;

  const TapMaterial({
    super.key,
    required this.child,
    this.onTap,
    this.color = Colors.transparent,
    this.radius = 4,
    this.ripple = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: ripple ? null : Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
