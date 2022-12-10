import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok/core/utils/app_constant.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.isObscureText = false,
  });
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.headline4!.copyWith(
              fontSize: 14.sp,
              color: AppConstant.appWhite,
            ),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          borderSide: const BorderSide(
            color: AppConstant.borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          borderSide: const BorderSide(
            color: AppConstant.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          borderSide: const BorderSide(
            color: AppConstant.borderColor,
          ),
        ),
      ),
      obscureText: isObscureText,
    );
  }
}
