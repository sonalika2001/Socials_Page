import 'dart:ui';
import 'blur.dart';
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
              child: (!enabled)
                  ? Blur(
                      opacity: 0.95,
                      blur: 0.6,
                      shade: Colors.grey[500],
                      child: child,
                    )
                  : child,
            ),
          ),
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
