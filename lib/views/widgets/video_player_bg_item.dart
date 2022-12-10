import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBgItem extends StatefulWidget {
  const VideoPlayerBgItem({
    super.key,
    required this.videoUrl,
  });
  final String videoUrl;
  @override
  State<VideoPlayerBgItem> createState() => _VideoPlayerBgItemState();
}

class _VideoPlayerBgItemState extends State<VideoPlayerBgItem> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
      });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(
        videoPlayerController,
      ),
    );
  }
}
