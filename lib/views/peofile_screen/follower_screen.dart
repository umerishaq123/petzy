import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/controllers/profile_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';

class FollowersScreen extends StatelessWidget {
  FollowersScreen({super.key});

  final HomeController controller = Get.isRegistered()
      ? Get.find<HomeController>()
      : Get.put(HomeController());
  final ProfileController profileController = Get.isRegistered()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Followers",
          style: GoogleFonts.quicksand(
              fontSize: 17.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back(); // Navigate back when the back button is pressed
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.user.value.followerList.length,
          itemBuilder: (context, index) {
            final data = controller.user.value.followerList[index];
            final followerId = index; // Assuming each follower has a unique ID

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r, // Adjust the size as needed
                        backgroundImage: AssetImage(data.profilePic), // Provide the asset image path
                        backgroundColor: Colors.transparent, // Optional, to avoid any background color
                      ),
                      SizedBox(width: 10.w), // Add spacing between the avatar and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: GoogleFonts.quicksand(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            data.subtitle,
                            style: GoogleFonts.quicksand(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Obx(() {
                        final isFollowing = profileController.isFollowing(followerId.toString());
                        return SizedBox(
                          width: 130.w, // Provide a fixed width for the button
                          child: CustomButtonWidget(
                            backgroundColor: isFollowing ? Colors.transparent : null,
                            borerColor: isFollowing ? primaryColor : null,
                            height: 40.h,
                            text: isFollowing ? "Follow back" : "Following",
                            textColor: isFollowing ? primaryColor : whiteColor,
                            onPressed: () {
                              profileController.toggleFollowState(followerId.toString());
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Divider(color: primaryColor,thickness: 0.1,),
                  )
              ],
            );
          
          },
        );
      }),
    );
  }
}