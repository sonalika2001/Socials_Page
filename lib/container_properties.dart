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
            color: colour,
          )
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
