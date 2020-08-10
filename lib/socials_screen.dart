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
          AnimatedPositioned(
              duration: Duration( milliseconds: 500),
              curve: Curves.decelerate,
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
                  child: AnimatedContainer(
                    duration: Duration( milliseconds: 500),
                    curve: Curves.decelerate,
                    height: (social == Social.instagram)
                        ? MediaQuery.of(context).size.height * 0.666667
                        : MediaQuery.of(context).size.height * (1 - 0.666667),
                    width: (social == Social.instagram)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width / 2.0,
                    color: Colors.pinkAccent,
                  ))),
          AnimatedPositioned(
              duration: Duration( milliseconds: 500),
              curve: Curves.decelerate,
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
                  child: AnimatedContainer(
                    duration: Duration( milliseconds: 500),
                    curve: Curves.decelerate,
                    height: (social == Social.twitter)
                        ? MediaQuery.of(context).size.height * 0.666667
                        : MediaQuery.of(context).size.height * (1 - 0.666667),
                    width: (social == Social.twitter)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width / 2.0,
                    color: Colors.blue,
                  ))),
          AnimatedPositioned(
              duration: Duration( milliseconds: 500),
              curve: Curves.decelerate,
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
                  child: AnimatedContainer(
                    duration: Duration( milliseconds: 500),
                    curve: Curves.decelerate,
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
