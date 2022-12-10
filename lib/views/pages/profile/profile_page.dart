import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/profile_controller.dart';
import 'package:tiktok/core/utils/app_constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.uid,
  });
  final String uid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(
      widget.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                controller.user['name'],
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              centerTitle: true,
              leading: const Icon(
                Icons.person_add_alt_1_outlined,
              ),
              actions: [
                const Icon(
                  Icons.more_horiz,
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.user['profilePic'],
                              width: 120.w,
                              height: 100.h,
                              placeholder: (context, url) {
                                return CircleAvatar(
                                  radius: 50.r,
                                  backgroundColor: Colors.white,
                                );
                              },
                              errorWidget: (context, url, error) {
                                return const Icon(
                                  Icons.error,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                controller.user['following'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Following",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30.h,
                            width: 2.w,
                            color: Colors.grey,
                            margin: EdgeInsets.symmetric(
                              horizontal: 15.w,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user['followers'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Follower",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30.h,
                            width: 2.w,
                            color: Colors.grey,
                            margin: EdgeInsets.symmetric(
                              horizontal: 15.w,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user['likes'].toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Likes",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Container(
                        height: 35.h,
                        width: 120.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(
                            12.r,
                          ),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            if (widget.uid ==
                                AppConstant.authController.user.uid) {
                              AppConstant.authController.signOut();
                            } else {
                              controller.followUser();
                            }
                          },
                          child: Text(
                            widget.uid == AppConstant.authController.user.uid
                                ? "Sign Out"
                                : controller.user['isFollowing']
                                    ? "Unfollow"
                                    : "Follow",
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Posts",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5.w,
                          mainAxisSpacing: 8.h,
                        ),
                        itemCount: controller.user['thumbnails'].length,
                        itemBuilder: (context, index) {
                          String thumbnail =
                              controller.user['thumbnails'][index];
                          return CachedNetworkImage(
                            imageUrl: thumbnail,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
