import 'dart:ui';

import 'package:flutter/material.dart';

class ContainerProperties extends StatelessWidget {
  final Color colour;
  final IconData icon;
  final bool enabled;
  Widget child;

  ContainerProperties({
    @required this.colour,
    this.icon,
    this.enabled = false,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              child: child,
            ),
          ),
          (!enabled)
              ? Container(
                  child: Blur(
                    opacity: 0.8,
                    blur: 0.6,
                    shade: Colors.grey[100],
                  ),
                )
              : SizedBox.shrink(),
          (!enabled)
              ? Align(
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    size: 70,
                    color: colour,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF1B1C21),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

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
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: shade.withOpacity(opacity),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
