import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/views/pages/auth/login_page.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          child: Container(
            alignment: Alignment.center,
            height: 1.sh,
            width: 1.sw,
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tik-Tok Clone",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: AppConstant.buttonColor,
                        ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "SignUp",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppConstant.appWhite,
                        ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Stack(
                    children: [
                      Obx(
                        () => AppConstant.authController.profilePic == ''
                            ? CircleAvatar(
                                radius: 55.r,
                                backgroundImage: const NetworkImage(
                                  'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png',
                                ),
                                backgroundColor: Colors.black,
                              )
                            : CircleAvatar(
                                radius: 55.r,
                                backgroundImage: FileImage(
                                  File(
                                    AppConstant.authController.profilePic!,
                                  ),
                                ),
                                backgroundColor: Colors.black,
                              ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 1,
                        child: InkWell(
                          onTap: () => AppConstant.authController.pickImage(),
                          child: Icon(
                            Icons.add_a_photo,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextInputField(
                    controller: _nameController,
                    labelText: "Username",
                    icon: Icons.person,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextInputField(
                    controller: _emailController,
                    labelText: "Email",
                    icon: Icons.email,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextInputField(
                    controller: _passwordController,
                    labelText: "Password",
                    icon: Icons.visibility,
                    isObscureText: true,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  InkWell(
                    onTap: () => AppConstant.authController.registerUser(
                      _nameController.text,
                      _emailController.text,
                      _passwordController.text,
                      File(
                        AppConstant.authController.profilePic!,
                      ),
                    ),
                    child: Container(
                      height: 45.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                        color: AppConstant.buttonColor,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(1, 2),
                            blurRadius: 4.0,
                            spreadRadius: 0.2,
                          )
                        ],
                      ),
                      child: Text(
                        "Register",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppConstant.appWhite,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Have a account !  ',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: AppConstant.appWhite,
                          ),
                      children: [
                        TextSpan(
                          text: "LogIn",
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppConstant.buttonColor,
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(
                                () => LogInPage(),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
