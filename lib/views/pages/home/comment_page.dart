import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/comment_controller.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentPage extends StatelessWidget {
  CommentPage({
    super.key,
    required this.id,
  });
  final String id;

  final commentTextController = TextEditingController();
  final commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.uploadPostId(
      id,
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Comments",
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
              color: Colors.white,
            ),
          ),
        ),
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return commentController.comments.isEmpty
                      ? const Center(
                          child: Text(
                            "No comments yet",
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: commentController.comments.length,
                          itemBuilder: (context, index) {
                            final data = commentController.comments[index];
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 25.r,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  data.profilePic,
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    data.userName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          fontSize: 18.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    data.comment,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    tago.format(
                                      data.datePublished.toDate(),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "${data.likes.length} likes",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                              trailing: InkWell(
                                onTap: () => commentController.likeComment(
                                  data.id,
                                ),
                                child: data.likes.contains(
                                        AppConstant.authController.user.uid)
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 22.sp,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size: 22.sp,
                                      ),
                              ),
                            );
                          },
                        );
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: commentTextController,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 15.sp,
                        color: Colors.white,
                      ),
                  decoration: InputDecoration(
                    labelText: "Comment",
                    labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 15.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController.postComment(
                      commentTextController.text,
                    );
                    commentTextController.clear();
                  },
                  child: Text(
                    "Send",
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
