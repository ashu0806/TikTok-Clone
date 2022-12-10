import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/models/video_model.dart';

class HomeController extends GetxController {
  final Rx<List<VideoModel>> _videos = Rx<List<VideoModel>>([]);

  List<VideoModel> get videos => _videos.value;

  @override
  void onInit() {
    super.onInit();

    _videos.bindStream(
      AppConstant.firebaseFirestore.collection('videos').snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<VideoModel> temp = [];
          for (var element in querySnapshot.docs) {
            temp.add(
              VideoModel.fromSnap(element),
            );
          }
          return temp;
        },
      ),
    );
  }

  likeVideo(
    String videoId,
  ) async {
    DocumentSnapshot doc = await AppConstant.firebaseFirestore
        .collection('videos')
        .doc(videoId)
        .get();
    String uid = AppConstant.authController.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await AppConstant.firebaseFirestore
          .collection('videos')
          .doc(videoId)
          .update(
        {
          'likes': FieldValue.arrayRemove([uid]),
        },
      );
    } else {
      await AppConstant.firebaseFirestore
          .collection('videos')
          .doc(videoId)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
