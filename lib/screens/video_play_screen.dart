import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
  String file;
  VideoPlayScreen(this.file);
  @override
  _VideoPlayScreenState createState()=> _VideoPlayScreenState(file);
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late VideoPlayerController _controller;
  String url;
  _VideoPlayScreenState(this.url);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    _controller = VideoPlayerController.network(url)..initialize().then((value) {
      setState(() {
        _controller.play();
        _controller.setLooping(true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Playing'),
      ),
      body: Center(
        child: _controller.value.isInitialized ?
          AspectRatio(aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
        ) : Container(),
      ),
    );
  }
}