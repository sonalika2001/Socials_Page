import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socials_page/api/twitter_api.dart';
import 'package:socials_page/widgets/container_properties.dart';
import 'package:socials_page/socials_screen.dart';

class Twitter extends StatefulWidget {
  Social social;

  Twitter({this.social});

  @override
  _TwitterState createState() => _TwitterState();
}

class _TwitterState extends State<Twitter> {
  TwitterApi _twitterApi = TwitterApi();
bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }
  getData() async{
    await  _twitterApi.storeData();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.social == Social.twitter);
    return Container(
      child: !loading ? Container(
padding: EdgeInsets.all(12.0),
        color: Colors.black12,
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _twitterApi.texts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top:13.0,bottom: 13.0,left: 4.0,right: 4.0),
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: new BoxDecoration(
                            boxShadow: [
                              //new BoxShadow(
                              //  color: Colors.white,
                              //  blurRadius: 2.0,
                              //  spreadRadius: 6,
                              //  offset: Offset(1,1),
                              //),
                              new BoxShadow(
                                  color: Colors.blueAccent ,//WhateverColor you wanna provide for embedding
                                  blurRadius: 4.0,
                                  spreadRadius: 4,
                                  offset: Offset(0,1)
                              ),
                              new BoxShadow(
                                color: Colors.black87,//backgroundColor
                                blurRadius: 3.0,
                                spreadRadius: 4,
                                offset: Offset(-1,-1),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(24.0)),
                          ),
                          child: new Card(color: Colors.black,
                            elevation: 10.0,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Wrap(
                                children: [
                                  Wrap(
                                    children: [
                                      Wrap(
                                        children: [
                                          ClipRRect(
                                              child: CachedNetworkImage(imageUrl: _twitterApi.image_url[index]),
                                          borderRadius: BorderRadius.circular(80),),
                                          Wrap(
                                            children: [
                                              Wrap(
                                               direction: Axis.vertical,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(_twitterApi.user_name[index],style: TextStyle(color: Colors.white,fontSize: 15.0),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text("@"+_twitterApi.screen_name[index],style: TextStyle(color: Colors.white60,fontSize: 13.0,fontWeight: FontWeight.bold),),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      _twitterApi.texts[index],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0),
                                    child: Wrap(
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
                                    ),
                                  )
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ):Center(
        child: SpinKitPouringHourglass(
          color: Colors.blue,
        ),
      ));
  }
}
