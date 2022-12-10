import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/upload_video_controller.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmVideoPage extends StatefulWidget {
  const ConfirmVideoPage({
    super.key,
    required this.videoFile,
    required this.videoPath,
  });
  final File videoFile;
  final String videoPath;

  @override
  State<ConfirmVideoPage> createState() => _ConfirmVideoPageState();
}

class _ConfirmVideoPageState extends State<ConfirmVideoPage> {
  late VideoPlayerController videoPlayerController;

  var songController = TextEditingController();
  var captionController = TextEditingController();

  var uploadVideoController = Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });

    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(1);
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    songController.dispose();
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 1.sh / 1.5,
                width: 1.sw,
                child: VideoPlayer(
                  videoPlayerController,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 1.sw - 20,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: TextInputField(
                        controller: songController,
                        labelText: "Song Name",
                        icon: Icons.music_note_outlined,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 1.sw - 20,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: TextInputField(
                        controller: captionController,
                        labelText: "Caption",
                        icon: Icons.closed_caption,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        uploadVideoController.uploadVideo(
                          songController.text,
                          captionController.text,
                          widget.videoPath,
                        );
                        Fluttertoast.showToast(
                          msg: "Uploading",
                        );
                      },
                      child: Text(
                        "Share",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 17.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
