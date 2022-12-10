import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok/core/utils/app_constant.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      width: 40.w,
      child: Stack(
        children: [
          Container(
            width: 35.w,
            margin: EdgeInsets.only(
              left: 10.w,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                250,
                45,
                108,
              ),
              borderRadius: BorderRadius.circular(
                5.r,
              ),
            ),
          ),
          Container(
            width: 35.w,
            margin: EdgeInsets.only(
              right: 10.w,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                32,
                211,
                234,
              ),
              borderRadius: BorderRadius.circular(
                5.r,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 35.w,
              height: 1.sh,
              decoration: BoxDecoration(
                color: AppConstant.appWhite,
                borderRadius: BorderRadius.circular(
                  5.r,
                ),
              ),
              child: Icon(
                Icons.add,
                size: 22.sp,
                color: AppConstant.appBlack,
              ),
            ),
          )
        ],
      ),
    );
  }
}
