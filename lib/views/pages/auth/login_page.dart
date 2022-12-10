import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/views/pages/auth/signup_page.dart';
import 'package:tiktok/views/widgets/text_input_field.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: 1.sh,
          width: 1.sw,
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
          ),
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
                "LogIn",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppConstant.appWhite,
                    ),
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
                onTap: () => AppConstant.authController.logInUser(
                  _emailController.text,
                  _passwordController.text,
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
                    "Log In",
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
                  text: 'Don\'t have a account !  ',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppConstant.appWhite,
                      ),
                  children: [
                    TextSpan(
                      text: "Register",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppConstant.buttonColor,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(
                            () => const SignUpPage(),
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
    );
  }
}
