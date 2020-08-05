import 'package:flutter/material.dart';
import 'socials_screen.dart';

void main() {
  runApp(SocialsApp());
}

class SocialsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SocialsScreen(),
    );
  }
}
