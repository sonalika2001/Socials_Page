import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socials_page/api/igtv_api.dart';
import 'package:socials_page/socials_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/instagram_api.dart';

class Igtv extends StatefulWidget {
  final double scale;

  Igtv({this.scale});

  @override
  _IgtvState createState() => _IgtvState();
}

class _IgtvState extends State<Igtv> {
  bool fetched = false;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    await GetIgtvInfo().storeIgtvData().then((value) {
      setState(() {
        fetched = true;
      });
    });
  }

  Widget IgtvWidget(String title, String url, var thumbnail, var likes) {
    return GestureDetector(
      onTap: () async {
        var url_final = "https://www.instagram.com/tv/" + url;
        if (await canLaunch(url_final))
          await launch(url_final);
        else
          print('could not launch $title');
      },
      child: Container(
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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
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
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(10 * widget.scale),
              child: Text('♥️ $likes\n$title'),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              FontAwesomeIcons.play,
              size: 50 * widget.scale,
            ),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 8 * widget.scale),
          //     child: Text('♥ $likes'),
          //   ),
          // ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10 * widget.scale),
        child: fetched == true
            ? Container(
                height: 200 * widget.scale,
                width: 30 * widget.scale,
                child: GridView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10 * widget.scale),
                      child: IgtvWidget(igtvTitle[index], igtvShortCode[index],
                          igtvThumbnailUrl[index], igtvLikes[index]),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20),
                  itemCount: igtvTitle.length,
                ),
              )
            : Center(
                child: SpinKitPouringHourglass(
                  color: Colors.pinkAccent,
                ),
              ));
  }
}
