import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/youtube_api.dart';

class YouTube extends StatefulWidget {
  final double scale;

  YouTube({this.scale});

  @override
  _YouTubeState createState() => _YouTubeState();
}

class _YouTubeState extends State<YouTube> {
  bool fetched = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetYoutubeInfo.youtubePosts().then((value) {
      fetched = true;
    });
  }

  Widget youTubewidget(String title, String url, String thumbnail) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url))
          await launch(url);
        else
          print('could not launch $title');
      },
      child: Container(
        height: 200 * widget.scale,
        width: 200 * widget.scale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Stack(fit: StackFit.expand, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              child: CachedNetworkImage(
                imageUrl: thumbnail,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [
                    0.0,
                    0.4,
                    0.6,
                    0.8,
                    1.0
                  ],
                  colors: [
                    Color(0xFF000000),
                    Color(0x3F000000),
                    Color(0x1A000000),
                    Color(0x02000000),
                    Color(0x00000000),
                  ]),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(10 * widget.scale),
              child: Text(title),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              FontAwesomeIcons.play,
              size: 50 * widget.scale,
            ),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10 * widget.scale),
        child: fetched == true
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10 * widget.scale),
                    child: youTubewidget(
                      GetYoutubeInfo.videoTitle[index],
                      GetYoutubeInfo.videoURL[index],
                      GetYoutubeInfo.thumbnailURL[index],
                    ),
                  );
                },
                itemCount: GetYoutubeInfo.videoTitle.length,
              )
            : Center(
                child: Text('Please wait'),
              ));
  }
}
