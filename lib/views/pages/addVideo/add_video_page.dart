import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/views/pages/addVideo/confirm_video_page.dart';

class AddVideoPage extends StatelessWidget {
  const AddVideoPage({super.key});

  pickVideo(BuildContext context, ImageSource source) async {
    final video = await ImagePicker().pickVideo(
      source: source,
    );
    if (video != null) {
      Get.to(
        () => ConfirmVideoPage(
          videoFile: File(video.path),
          videoPath: video.path,
        ),
      );
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () => pickVideo(
                context,
                ImageSource.gallery,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.photo_outlined,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      9.sm,
                    ),
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => pickVideo(
                context,
                ImageSource.camera,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      9.sm,
                    ),
                    child: Text(
                      "Camera",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Get.back(),
              child: Row(
                children: [
                  const Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      9.sm,
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionsDialog(context),
          child: Container(
            height: 40.h,
            width: 150.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppConstant.buttonColor,
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            child: Text(
              'Add Video',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 17.sp,
                    color: AppConstant.appWhite,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
