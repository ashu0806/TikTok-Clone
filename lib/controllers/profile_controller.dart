// ignore_for_file: unused_local_variable, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/core/utils/app_constant.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myVideos = await AppConstant.firebaseFirestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    for (int i = 1; i < myVideos.docs.length; i++) {
      thumbnails.add(
        (myVideos.docs[i].data() as dynamic)['thumbnail'],
      );
    }

    DocumentSnapshot userDoc = await AppConstant.firebaseFirestore
        .collection('users')
        .doc(_uid.value)
        .get();

    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePic = userData['profilePic'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    var followerDoc = await AppConstant.firebaseFirestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await AppConstant.firebaseFirestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    AppConstant.firebaseFirestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(AppConstant.authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      "followers": followers.toString(),
      "following": following.toString(),
      "isFollowing": isFollowing,
      "likes": likes.toString(),
      "name": name,
      "profilePic": profilePic,
      "thumbnails": thumbnails,
    };
    update();
  }

  followUser() async {
    var doc = await AppConstant.firebaseFirestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(AppConstant.authController.user.uid)
        .get();

    if (!doc.exists) {
      await AppConstant.firebaseFirestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(AppConstant.authController.user.uid)
          .set({});
      await AppConstant.firebaseFirestore
          .collection('users')
          .doc(AppConstant.authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        "followers",
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await AppConstant.firebaseFirestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(AppConstant.authController.user.uid)
          .delete();
      await AppConstant.firebaseFirestore
          .collection('users')
          .doc(AppConstant.authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        "followers",
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update(
      "isFollowing",
      (value) => !value,
    );
    update();
  }
}
