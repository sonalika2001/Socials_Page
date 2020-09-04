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
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    await GetInstaInfo().storeData().then((value) {
      setState(() {
        fetched = true;
      });
    });
  }

  _showDialog(String caption, String url, var display, var likes) {
    print(display);
    showDialog(
      context: scaffoldKey.currentContext,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: instagramwidget(caption, url, display, likes, 200, 200,
              insideDialog: true),
        );
      },
    );
  }

  Widget instagramwidget(String caption, String url, var display, var likes,
      double height, double width,
      {bool insideDialog = false}) {
    return GestureDetector(
      onTap: () async {
        if (insideDialog) {
          return;
        }
        if (display[0] == 'image' || display[0] == 'multiple') {
          String tempUrl = 'https://www.instagram.com/p/$url';
          print(tempUrl);
          if (await canLaunch(tempUrl))
            await launch(tempUrl);
          else
            print('could not launch');
        } else {
          _showDialog(caption, url, display, likes);
        }
      },
      child: Container(
        height: height * widget.scale,
        width: width * widget.scale,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Column(children: [
          Container(
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: (height - 100) * widget.scale,
                  width: width * widget.scale,
                  child: insideDialog
                      ? Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.white,
                          child: InstagramVideo(
                            url: display[2],
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl:
                              (display[0] == 'image' || display[0] == 'video')
                                  ? display[1]
                                  : display[1][1],
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              ((display[0] == 'image' || display[0] == 'multiple') &&
                      !insideDialog)
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
          (!insideDialog)
              ? Container(
                  height: 100 * widget.scale,
                  width: width * widget.scale,
                  color: Colors.white,
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text('♥ $likes'),
                    ),
                    Wrap(
                      children: [Text(caption)],
                    )
                  ]),
                )
              : SizedBox.shrink(),
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
                    child: instagramwidget(caption[index], shortcode[index],
                        display[index], likes[index], 200, 200),
                  );
                },
                /*         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),*/
                itemCount: caption.length,
              )
            : Center(
                child: SpinKitPouringHourglass(
                  color: Colors.pinkAccent,
                ),
              ));
  }
}
