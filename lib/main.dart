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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF1B1C21),
        scaffoldBackgroundColor: Color(0xFF000000),
      ),
      home: SocialsScreen(),
    );
  }
}
