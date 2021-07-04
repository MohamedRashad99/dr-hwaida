import 'package:DrHwaida/constants/constans.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChewieVideoState();
  }
}

class _ChewieVideoState extends State<ChewieVideo> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');
    await _videoPlayerController1.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      allowFullScreen: true,
      fullScreenByDefault: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _chewieController != null &&
              _chewieController.videoPlayerController.value.initialized
          ? Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: customColor,
              ),
              child: Chewie(
                controller: _chewieController,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'loading',
                ),
              ],
            ),
    );
  }
}
