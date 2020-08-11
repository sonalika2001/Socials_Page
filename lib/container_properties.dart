import 'package:flutter/material.dart';

class ContainerProperties extends StatelessWidget {
  final Color colour;
  final IconData icon;

  ContainerProperties({@required this.colour, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 70,
          )
        ],
      ),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
