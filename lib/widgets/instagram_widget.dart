import 'package:flutter/material.dart';
import 'package:socials_page/widgets/instagram_video.dart';
import 'package:socials_page/widgets/read_more.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'read_more.dart';
import '../socials_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstagramWidget extends StatelessWidget {
  String caption;
  String url;
  var display;
  var likes;

  InstagramWidget({this.caption, this.url, this.display, this.likes});

  _showDialog() {
    //  print(display);
    showDialog(
      context: scaffoldKey.currentContext,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: SizedBox(
              height: MediaQuery.of(context).size.width / 1.2,
              width: MediaQuery.of(context).size.width / 1.2,
              child: InstagramVideo(
                url: display[2],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print(display);
        if (display[0] == 'image' || display[0] == 'multiple') {
          var url_final = "https://www.instagram.com/p/" + url;
          if (await canLaunch(url_final))
            await launch(url_final);
          else
            print('could not launch $caption');
        } else {
          _showDialog();
        }
      },
      child: Wrap(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Wrap(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Stack(children: [
                  CachedNetworkImage(
                    imageUrl: (display[0] == 'image' || display[0] == 'video')
                        ? display[1]
                        : display[1][1],
                    fit: BoxFit.fill,
                  ),
                  (display[0] == 'image' || display[0] == 'multiple')
                      ? SizedBox.shrink()
                      : Container(
                          alignment: Alignment.center,
                          height: 250,
                          child: Icon(
                            FontAwesomeIcons.play,
                            size: 50,
                          ),
                        )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '♥ $likes',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                  child: Container(
                    height: 100,
                    child: ListView(children: [ReadMore(caption)]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
