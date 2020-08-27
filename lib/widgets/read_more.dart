import 'package:flutter/material.dart';
import 'instagram_widget.dart';

class ReadMore extends StatefulWidget {
  String captionText;

  ReadMore(this.captionText);

  @override
  _ReadMoreState createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.captionText,
              maxLines: flag ? 8 : 4, textAlign: TextAlign.start),
          InkWell(
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                flag
                    ? Text(
                        "show less",
                        style: TextStyle(color: Colors.grey),
                      )
                    : Text("...more", style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
