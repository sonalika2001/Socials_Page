import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socials_page/api/instagram_api.dart';
import 'package:socials_page/socials_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/instagram_api.dart';
import 'package:socials_page/widgets/instagram_video.dart';

class Instagram extends StatefulWidget {
  final double scale;

  Instagram({this.scale});

  @override
  _InstagramState createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  bool fetched = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _showDialog(String caption, String url, var display, String likes) {
    showDialog(
      context: scaffoldKey.currentContext,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: instagramwidget(caption, url, display[1], likes,
              insideDialog: true),
        );
      },
    );
  }

  Widget instagramwidget(String caption, String url, var display, String likes,
      {bool insideDialog = false}) {
    return GestureDetector(
      onTap: () async {
        if (insideDialog) {
          return;
        }
        if (display.runtimeType == String) {
          String tempUrl = 'https://www.instagram.com/p/$url';
          if (await canLaunch(tempUrl))
            await launch(tempUrl);
          else
            print('could not launch');
        } else {
          _showDialog(caption, url, display, likes);
        }
      },
      child: Container(
        height: 100 * widget.scale,
        width: 100 * widget.scale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Column(children: [
          Container(
            child: Stack(fit: StackFit.expand, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  child: insideDialog
                      ? InstagramVideo(
                          url: display,
                        )
                      : CachedNetworkImage(
                          imageUrl: (display.runtimeType == String)
                              ? display
                              : display[0],
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              (display.runtimeType == String && !insideDialog)
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.center,
                      child: Icon(
                        FontAwesomeIcons.play,
                        size: 50 * widget.scale,
                      ),
                    )
            ]),
          ),
          Container(
            height: 100 * widget.scale,
            width: 100 * widget.scale,
            color: Colors.white,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(likes),
              ),
              Wrap(
                children: [Text(caption)],
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10 * widget.scale),
        child: fetched == true
            ? GridView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10 * widget.scale),
                    child: instagramwidget(
                      caption[index],
                      url[index],
                      display[index],
                      likes[index],
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: caption.length,
              )
            : Center(
                child: SpinKitPouringHourglass(
                  color: Color(0xFFD0312D),
                ),
              ));
  }
}
