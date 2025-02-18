import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/controllers/nav_bar_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';


class NavBarScreen extends StatelessWidget {
 NavBarScreen({super.key});

  final NavController controller=Get.isRegistered()?Get.find<NavController>():Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // Creates notch for FAB
        notchMargin: 8.0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navBarItem(homeIcon, "Home", 0),
              navBarItem(chatIcon, "Chats", 1),
              SizedBox(width: 40), // Space for FAB
              navBarItem(addPostIcon, "Add post", 2),
              navBarItem(contestIcon, "Contests", 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    controller.changeTab(2); // Set 'Add post' as active tab
  },
  backgroundColor: Colors.green,
  child: Image.asset(petIcon, width: 30.w, color: whiteColor),
  // child: Icon(Icons.add, color: Colors.white, size: 30),
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
              Image.asset(icon,width: 24.w, color: controller.selectedIndex.value == index
                    ? Colors.green
                    : Colors.grey,
              ),
              // Icon(
              //   icon,
              //   color: controller.selectedIndex.value == index
              //       ? Colors.green
              //       : Colors.grey,
              //   size: 24,
              // ),
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
