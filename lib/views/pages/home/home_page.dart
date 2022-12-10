import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/home_controller.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/views/pages/home/comment_page.dart';
import 'package:tiktok/views/widgets/circle_animation.dart';
import 'package:tiktok/views/widgets/video_player_bg_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  buildProfile(
    String profileUrl,
  ) {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: 50.w,
              height: 43.h,
              padding: EdgeInsets.all(
                2.sm,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  25.r,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  25.r,
                ),
                child: Image(
                  image: NetworkImage(
                    profileUrl,
                  ),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePic) {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: 50.w,
              height: 43.h,
              padding: EdgeInsets.all(
                11.sm,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.grey,
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(
                  25.r,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  25.r,
                ),
                child: Image(
                  image: NetworkImage(
                    profilePic,
                  ),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return homeController.videos.isEmpty
              ? const Center(
                  child: Text(
                    "No videos to show",
                  ),
                )
              : PageView.builder(
                  itemCount: homeController.videos.length,
                  controller: PageController(
                    initialPage: 0,
                    viewportFraction: 1,
                  ),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final data = homeController.videos[index];
                    return Stack(
                      children: [
                        VideoPlayerBgItem(
                          videoUrl: data.videoUrl,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 100.h,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: 15.w,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.userName,
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
                                            data.caption,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                  fontSize: 14.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.music_note,
                                                size: 15.sp,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                data.songName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                      fontSize: 14.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 80.w,
                                    margin: EdgeInsets.only(
                                      top: 1.sh / 4,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25.h,
                                        ),
                                        buildProfile(
                                          data.profilePic,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  homeController.likeVideo(
                                                data.id,
                                              ),
                                              child: data.likes.contains(
                                                      AppConstant.authController
                                                          .user.uid)
                                                  ? Icon(
                                                      Icons.favorite_outlined,
                                                      size: 25.sp,
                                                      color: Colors.red,
                                                    )
                                                  : Icon(
                                                      Icons.favorite_border,
                                                      size: 25.sp,
                                                      color: Colors.white,
                                                    ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              data.likes.length.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .copyWith(
                                                    fontSize: 12.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommentPage(
                                                      id: data.id,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                Icons.comment,
                                                size: 25.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              data.commentCount.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .copyWith(
                                                    fontSize: 12.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: Icon(
                                                Icons.reply,
                                                size: 25.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              data.shareCount.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .copyWith(
                                                    fontSize: 12.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        CircleAnimation(
                                          child: buildMusicAlbum(
                                            data.profilePic,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
