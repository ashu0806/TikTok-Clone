import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/controllers/auth_controller.dart';

mixin AppConstant {
  // COLORS
  static const Color backgroundColor = Colors.black;
  static const Color buttonColor = Colors.red;
  static const Color borderColor = Colors.grey;
  static const Color appWhite = Colors.white;
  static const Color appBlack = Colors.black;

  //Firebase related
  static var firebaseAuth = FirebaseAuth.instance;
  static var firebaseFirestore = FirebaseFirestore.instance;
  static var firebaseStorage = FirebaseStorage.instance;

  //Controllers
  static var authController = AuthController.instance;
}
