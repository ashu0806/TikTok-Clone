// ignore_for_file: unused_field

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/models/user_model.dart';
import 'package:tiktok/views/pages/auth/login_page.dart';
import 'package:tiktok/views/pages/dashboard_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final _pickedImagePath = ''.obs;
  late Rx<User?> _user;

  String? get profilePic => _pickedImagePath.value;
  User get user => _user.value!;

  @override
  void onReady() {
    _user = Rx<User?>(AppConstant.firebaseAuth.currentUser);
    _user.bindStream(
      AppConstant.firebaseAuth.authStateChanges(),
    );
    ever(_user, setInitialPage);
    super.onReady();
  }

  setInitialPage(User? user) {
    if (user == null) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.offAll(
            () => LogInPage(),
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.offAll(
            () => const DashboardPage(),
          );
        },
      );
    }
  }

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      Fluttertoast.showToast(
        msg: "You successfully selected the profile pic",
      );
      _pickedImagePath.value = pickedImage.path;
    } else {
      Get.snackbar(
        'Error',
        "No image is selected",
      );
    }
  }

  //upload file to storage
  Future<String> _uploadFileToStorage(
    File image,
  ) async {
    Reference reference = AppConstant.firebaseStorage
        .ref()
        .child('profilePics')
        .child(AppConstant.firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential =
            await AppConstant.firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String profileUrl = await _uploadFileToStorage(image);

        UserModel user = UserModel(
          name: name,
          email: email,
          profilePic: profileUrl,
          uid: credential.user!.uid,
        );
        await AppConstant.firebaseFirestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(
              user.toJson(),
            );
        Get.snackbar(
          "Successful!",
          "Account Created and Userdata Stored",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Error during account creation!",
          "Fill all details correctly.",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error during account creation!",
        e.toString(),
      );
    }
  }

  void logInUser(
    String email,
    String password,
  ) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await AppConstant.firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.snackbar(
          "Successful!",
          "Signing In",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          "Login failed",
          "Fill details correctly.!",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Login failed",
        e.toString(),
      );
    }
  }

  void signOut() async {
    try {
      Get.snackbar(
        "Successful!",
        "Signing Out",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      await AppConstant.firebaseAuth.signOut();
    } catch (e) {
      Get.snackbar(
        "Sign Out failed",
        e.toString(),
      );
    }
  }
}
