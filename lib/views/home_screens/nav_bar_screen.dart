import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/controllers/nav_bar_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/chat_screens/all_chats_screen.dart';
import 'package:pet_app/views/contest/contest_screen.dart';
import 'package:pet_app/views/discovery_view.dart';
import 'package:pet_app/views/home_screens/home_screen.dart';
import 'package:pet_app/views/posts/add_post_screen.dart';

class NavBarScreen extends StatelessWidget {
  NavBarScreen({super.key});

  final NavController controller = Get.isRegistered()
      ? Get.find<NavController>()
      : Get.put(NavController());

  // List of screens to show for each tab
  final List<Widget> screens = [
    HomeScreen(),      // Replace with your actual screen widgets
 AllChatsScreen(),
    DiscoveryScreen(),
   AddPostScreen(),
    ContestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Show the selected screen based on tab index
      body: Obx(() => screens[controller.selectedIndex.value]),
      
      bottomNavigationBar: BottomAppBar(
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        notchMargin: 10.0,
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side items
              Row(
                children: [
                  navBarItem(homeIcon, "Home", 0),
                  SizedBox(width: 30.w),
                  navBarItem(messageIcon, "Chats", 1),
                ],
              ),
              // Right side items
              Row(
                children: [
                  navBarItem(addPostIcon, "Add post", 3),
                  SizedBox(width: 30.w),
                  navBarItem(contestIcon, "Contests", 4),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(right: 35.w),
        child: SizedBox(
          height: 70.h,
          width: 70.w,
          child: FloatingActionButton(
            onPressed: () {
              controller.changeTab(2);
            },
            backgroundColor: Colors.green,
            shape: const CircleBorder(),
            child: Image.asset(
              petIcon,
              width: 40.w,
              color: whiteColor,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget navBarItem(String icon, String label, int index) {
    return Obx(() => GestureDetector(
          onTap: () {
            controller.changeTab(index);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                icon,
                width: 24.w,
                color: controller.selectedIndex.value == index
                    ? Colors.green
                    : Colors.grey,
              ),
              Text(
                label,
                style: TextStyle(
                  color: controller.selectedIndex.value == index
                      ? Colors.green
                      : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ));
  }
}