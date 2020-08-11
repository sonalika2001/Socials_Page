import 'package:flutter/material.dart';
import './instagram_api.dart';
import './youtube_api.dart';
import './container_properties.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialsScreen extends StatefulWidget {
  @override
  _SocialsScreenState createState() => _SocialsScreenState();
}

enum Social { instagram, youtube, twitter }

class _SocialsScreenState extends State<SocialsScreen> {
  Social social = Social.instagram;
  @override
  void initState() {
    super.initState();
    //getInstaInfo.storeData(); - to test/print data values in the terminal
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
              top: (social == Social.instagram) ? 0 : height * 0.666667,
              left: 0,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      social = Social.instagram;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    height: (social == Social.instagram)
                        ? height * 0.666667
                        : height * (1 - 0.666667),
                    width: (social == Social.instagram) ? width : width / 2.0,
                    child: ContainerProperties(
                      colour: Colors.red,
                      icon: FontAwesomeIcons.instagram,
                    ),
                  ))),
          AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
              top: (social == Social.twitter) ? 0 : height * 0.666667,
              left: (social == Social.youtube) ? width / 2.0 : 0,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      social = Social.twitter;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    height: (social == Social.twitter)
                        ? height * 0.666667
                        : height * (1 - 0.666667),
                    width: (social == Social.twitter) ? width : width / 2.0,
                    child: ContainerProperties(
                      colour: Colors.blue,
                      icon: FontAwesomeIcons.twitter,
                    ),
                  ))),
          AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
              top: (social == Social.youtube) ? 0 : height * 0.666667,
              left: (social == Social.youtube) ? 0 : width / 2.0,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      social = Social.youtube;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    height: (social == Social.youtube)
                        ? height * 0.666667
                        : height * (1 - 0.666667),
                    width: (social == Social.youtube) ? width : width / 2.0,
                    child: ContainerProperties(
                      colour: Colors.yellow,
                      icon: FontAwesomeIcons.youtube,
                    ),
                  ))),
        ],
      ),
    );
  }
}
