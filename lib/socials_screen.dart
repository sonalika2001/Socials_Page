import 'package:flutter/material.dart';

class SocialsScreen extends StatefulWidget {
  @override
  _SocialsScreenState createState() => _SocialsScreenState();
}

enum Social { instagram, youtube, twitter }

class _SocialsScreenState extends State<SocialsScreen> {
  Social social = Social.twitter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: (social == Social.instagram)
                  ? 0
                  : MediaQuery.of(context).size.height * 0.666667,
              left: 0,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      social = Social.instagram;
                    });
                  },
                  child: Container(
                    height: (social == Social.instagram)
                        ? MediaQuery.of(context).size.height * 0.666667
                        : MediaQuery.of(context).size.height * (1 - 0.666667),
                    width: (social == Social.instagram)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width / 2.0,
                    color: Colors.pinkAccent,
                  ))),
          Positioned(
              top: (social == Social.twitter)
                  ? 0
                  : MediaQuery.of(context).size.height * 0.666667,
              left: (social == Social.youtube)
                  ? MediaQuery.of(context).size.width / 2.0
                  : 0,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      social = Social.twitter;
                    });
                  },
                  child: Container(
                    height: (social == Social.twitter)
                        ? MediaQuery.of(context).size.height * 0.666667
                        : MediaQuery.of(context).size.height * (1 - 0.666667),
                    width: (social == Social.twitter)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width / 2.0,
                    color: Colors.blue,
                  ))),
          Positioned(
              top: (social == Social.youtube)
                  ? 0
                  : MediaQuery.of(context).size.height * 0.666667,
              left: (social == Social.youtube)
                  ? 0
                  : MediaQuery.of(context).size.width / 2.0,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      social = Social.youtube;
                    });
                  },
                  child: Container(
                    height: (social == Social.youtube)
                        ? MediaQuery.of(context).size.height * 0.666667
                        : MediaQuery.of(context).size.height * (1 - 0.666667),
                    width: (social == Social.youtube)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width / 2.0,
                    color: Colors.red,
                  ))),
        ],
      ),
    );
  }
}
