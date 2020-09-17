import 'package:flutter/material.dart';
import '../api/instagram_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/instagram_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Instagram extends StatefulWidget {
  final double scale;

  Instagram({this.scale});

  @override
  _InstagramState createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  bool fetched = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    await GetInstaInfo().storeData().then((value) {
      if (mounted)
        setState(() {
          fetched = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10 * widget.scale),
      child: fetched == true
          ? StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: display.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10 * widget.scale),
                  child: InstagramWidget(
                      caption: caption[index],
                      url: shortcode[index],
                      display: display[index],
                      likes: likes[index]),
                );
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            )
          : Center(
              child: SpinKitPouringHourglass(
                color: Colors.pinkAccent,
              ),
            ),
    );
  }
}
