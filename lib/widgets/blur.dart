import 'package:flutter/material.dart';
import 'dart:ui';

class Blur extends StatelessWidget {
  final double opacity;
  final double blur;
  final Color shade;

  Blur({
    this.opacity,
    this.blur,
    this.shade,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        decoration: BoxDecoration(
          color: shade.withOpacity(opacity),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
