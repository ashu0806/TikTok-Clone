import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/models/video_model.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(
    String id,
    String videoPath,
  ) async {
    Reference reference =
        AppConstant.firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = reference.putFile(
      await _compressVideo(videoPath),
    );
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(
    String id,
    String videoPath,
  ) async {
    Reference reference =
        AppConstant.firebaseStorage.ref().child('thumbnails').child(id);

    UploadTask uploadTask = reference.putFile(
      await _getThumbnail(videoPath),
    );
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  uploadVideo(
    String songName,
    String caption,
    String videoPath,
  ) async {
    try {
      String uid = AppConstant.firebaseAuth.currentUser!.uid;

      DocumentSnapshot userDocs = await AppConstant.firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();

      var allDocs =
          await AppConstant.firebaseFirestore.collection('videos').get();

      int length = allDocs.docs.length;

      String videoUrl = await _uploadVideoToStorage(
        'Video $length',
        videoPath,
      );
      String thumbnail = await _uploadImageToStorage(
        'Video $length',
        videoPath,
      );

      VideoModel video = VideoModel(
        userName: (userDocs.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: 'Video $length',
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePic: (userDocs.data()! as Map<String, dynamic>)['profilePic'],
      );

      await AppConstant.firebaseFirestore
          .collection('videos')
          .doc('Video $length')
          .set(
            video.toJson(),
          );

      Get.back();
    } catch (e) {
      Get.snackbar(
        "Uploading Failed",
        e.toString(),
      );
    }
  }
}
