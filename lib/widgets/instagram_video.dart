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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Initializing video ${widget.url}');
    videoController = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        print(videoController.value.initialized);
        print(videoController.value.isPlaying);
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
        child: videoController.value.initialized
            ? GestureDetector(
                onTap: () {
                  videoController.value.isPlaying
                      ? videoController.pause()
                      : videoController.play();
                },
                child: Stack(fit: StackFit.expand, children: [
                  AspectRatio(
                    aspectRatio: videoController.value.aspectRatio,
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
            : Center(child: Text('Loading')));
  }
}
