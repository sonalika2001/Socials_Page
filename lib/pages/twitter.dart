import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socials_page/api/twitter_api.dart';
import 'package:socials_page/container_properties.dart';
import 'package:socials_page/socials_screen.dart';

class Twitter extends StatefulWidget {
  Social social;

  Twitter({this.social});

  @override
  _TwitterState createState() => _TwitterState();
}

class _TwitterState extends State<Twitter> {
  TwitterApi _twitterApi = TwitterApi();

  @override
  void initState() {
    _twitterApi.storeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerProperties(
      icon: FontAwesomeIcons.twitter,
      colour: Colors.blue,
      enabled: widget.social == Social.twitter,
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.blue,
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _twitterApi.texts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: new Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(
                                  _twitterApi.texts[index],
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  direction: Axis.horizontal,
                                  children: [
                                    for (String tag
                                        in _twitterApi.hashtags[index])
                                      Text(
                                        "#" + tag,
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
