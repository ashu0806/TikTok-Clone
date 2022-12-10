import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/search_controller.dart';
import 'package:tiktok/views/pages/profile/profile_page.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: TextFormField(
              cursorColor: Colors.white,
              cursorHeight: 18.h,
              decoration: InputDecoration(
                filled: false,
                hintText: "Search",
                hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
              ),
              onFieldSubmitted: (value) => searchController.searchUser(
                value,
              ),
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? Center(
                  child: Text(
                    "Search for users",
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchController.searchedUsers.length,
                    itemBuilder: (context, index) {
                      final user = searchController.searchedUsers[index];
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              uid: user.uid,
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(
                              user.profilePic,
                            ),
                          ),
                          title: Text(
                            user.name,
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
