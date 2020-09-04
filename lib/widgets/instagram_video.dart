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
  bool loaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoController = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          loaded = true;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: loaded
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    videoController.value.isPlaying
                        ? videoController.pause()
                        : videoController.play();
                  });
                },
                child: Stack(fit: StackFit.expand, children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width - 200,
                    width: MediaQuery.of(context).size.width - 200,
                    child: VideoPlayer(videoController),
                  ),
                  (videoController.value.isPlaying)
                      ? SizedBox.shrink()
                      : Align(
                          alignment: Alignment.center,
                          child: Icon(
                            FontAwesomeIcons.play,
                            size: 50,
                          ),
                        ),
                ]),
              )
            : Center(
                child: Container(
                    padding: EdgeInsets.all(20.0), child: Text('Loading'))));
  }
}

/*class _InstagramVideoState extends State<InstagramVideo> {
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
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Text("Loading")
            ),
          );
        }
      },
    ));
  }
}
*/
