import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstagramVideo extends StatefulWidget {
  String url;

  InstagramVideo({this.url});

  @override
  _InstagramVideoState createState() => _InstagramVideoState();
}

class _InstagramVideoState extends State<InstagramVideo> {
  VideoPlayerController videoController;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = videoController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("done");
          videoController.play();
          return Container(
            child: AspectRatio(
              aspectRatio: videoController.value.aspectRatio,
              child: VideoPlayer(videoController),
            ),
          );
        } else {
          print(snapshot.connectionState);
          return Center(
            child: Text("Loading"),
          );
        }
      },
    ));
  }
}
