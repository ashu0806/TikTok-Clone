import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _commentList = Rx<List<CommentModel>>([]);

  List<CommentModel> get comments => _commentList.value;

  String _postId = '';

  uploadPostId(String id) {
    _postId = id;
    getComments();
  }

  getComments() async {
    _commentList.bindStream(
      AppConstant.firebaseFirestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot querySnapshot) {
          List<CommentModel> temp = [];
          for (var element in querySnapshot.docs) {
            temp.add(
              CommentModel.fromSnap(element),
            );
          }
          return temp;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await AppConstant.firebaseFirestore
            .collection('users')
            .doc(AppConstant.authController.user.uid)
            .get();

        var allDocs = await AppConstant.firebaseFirestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();

        int length = allDocs.docs.length;

        CommentModel comment = CommentModel(
          userName: (userDoc.data()! as dynamic)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePic: (userDoc.data()! as dynamic)['profilePic'],
          uid: AppConstant.authController.user.uid,
          id: 'Comment $length',
        );
        await AppConstant.firebaseFirestore
            .collection('videos')
            .doc(_postId)
            .collection("comments")
            .doc('Comment $length')
            .set(
              comment.toJson(),
            );
        // DocumentSnapshot doc = await AppConstant.firebaseFirestore
        //     .collection('videos')
        //     .doc(_postId)
        //     .get();
        await AppConstant.firebaseFirestore
            .collection('videos')
            .doc(_postId)
            .update({
          "commentCount": length + 1,
        });
      } else {
        Get.snackbar(
          "Failed",
          "Comment can't be empty",
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Failed",
        e.toString(),
        duration: const Duration(seconds: 1),
      );
    }
  }

  likeComment(String id) async {
    var uid = AppConstant.authController.user.uid;
    DocumentSnapshot doc = await AppConstant.firebaseFirestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await AppConstant.firebaseFirestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update(
        {
          'likes': FieldValue.arrayRemove([uid]),
        },
      );
    } else {
      await AppConstant.firebaseFirestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
