import 'package:flutter/material.dart';
import 'package:socials_page/widgets/read_more.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import 'read_more.dart';

class InstagramWidget extends StatelessWidget {
  String caption;
  String url;
  var display;
  var likes;

  InstagramWidget({this.caption, this.url, this.display, this.likes});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url))
          await launch(url);
        else
          print('could not launch $caption');
      },
      // child: Container(
      //   color: Colors.black,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       CachedNetworkImage(
      //         imageUrl: (display[0] == 'image' || display[0] == 'video')
      //             ? display[1]
      //             : display[1][1],
      //         fit: BoxFit.fill,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Align(
      //           alignment: Alignment.centerLeft,
      //           child: Text(
      //             '♥ $likes',
      //           ),
      //         ),
      //       ),
      //       ReadMoreText(caption),
      //     ],
      //   ),
      // ),
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
                child: CachedNetworkImage(
                  imageUrl: (display[0] == 'image' || display[0] == 'video')
                      ? display[1]
                      : display[1][1],
                  fit: BoxFit.fill,
                ),
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
                padding: const EdgeInsets.all(8.0),
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
