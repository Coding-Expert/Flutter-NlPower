import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String mediaUrl;
  const VideoWidget({this.mediaUrl, Key key}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController;
  ChewieController _chewieController;
  bool isPlaying = false;

  void _initVideo() async {
    videoPlayerController = VideoPlayerController.network(widget.mediaUrl);
    setState(() {
      isPlaying = true;
    });
    await videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: this.videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      );
      isPlaying = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isPlaying
        ? Container(
            child: Chewie(
              controller: _chewieController,
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
