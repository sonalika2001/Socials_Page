import 'package:flutter/material.dart';
import 'dart:ui';

class Blur extends StatelessWidget {
  final double opacity;
  final double blur;
  final Color shade;
  final Widget child;

  Blur({
    this.opacity,
    this.blur,
    this.shade,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: shade.withOpacity(opacity),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ]);
  }
}
