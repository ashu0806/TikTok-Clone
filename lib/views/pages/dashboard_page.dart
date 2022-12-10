import 'package:flutter/material.dart';
import 'package:tiktok/core/utils/app_constant.dart';
import 'package:tiktok/views/pages/addVideo/add_video_page.dart';
import 'package:tiktok/views/pages/home/home_page.dart';
import 'package:tiktok/views/pages/profile/profile_page.dart';
import 'package:tiktok/views/pages/search/search_page.dart';
import 'package:tiktok/views/widgets/custom_icon.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  int pageIndex = 0;

  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    const AddVideoPage(),
    const Center(
      child: Text(
        "Message Page",
      ),
    ),
    ProfilePage(
      uid: AppConstant.authController.user.uid,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppConstant.backgroundColor,
          unselectedItemColor: AppConstant.borderColor,
          selectedItemColor: AppConstant.buttonColor,
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: CustomIcon(),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
              ),
              label: "Message",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
