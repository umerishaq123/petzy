import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/peofile_screen/follower_screen.dart';
import 'package:pet_app/views/peofile_screen/following_screen.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatelessWidget {
  final bool iscome;
  ProfileScreen({super.key,required this.iscome});

  final HomeController controller = Get.isRegistered()
      ? Get.find<HomeController>()
      : Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final userData = controller.user.value;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userData.name}",
                              style: GoogleFonts.quicksand(
                                  fontSize: 16.sp, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              "${userData.location}",
                              style: GoogleFonts.quicksand(
                                  fontSize: 16.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 40, // Adjust the size as needed
                        backgroundImage: AssetImage(
                            userData.profile), // Provide the asset image path
                        backgroundColor: Colors
                            .transparent, // Optional, to avoid any background color
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${userData.postcount}",
                              style: GoogleFonts.quicksand(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: blackColor),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "Posts",
                              style: GoogleFonts.quicksand(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => FollowersScreen());
                          },
                          child: Column(
                            children: [
                              Text(
                                "${userData.followerCount}",
                                style: GoogleFonts.quicksand(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: blackColor),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "Followers",
                                style: GoogleFonts.quicksand(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
 Get.to(() => FollowingScreen());

                          },
                          child: Column(
                            children: [
                              Text(
                                "${userData.followingCount}",
                                style: GoogleFonts.quicksand(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: blackColor),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "Following",
                                style: GoogleFonts.quicksand(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Fluffy, fun, and full of love! Living my best life one treat at a time. 🐾❤️",
                    style: GoogleFonts.quicksand(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: blackColor),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButtonWidget(
                          height: 50.h,
                          width: 150.w,
                          borderRadius: 10.r,
                          textColor: whiteColor,
                          backgroundColor: primaryColor,
                          text:iscome?"View pet details":
                          
                           "Follow",
                        ),
                      ),
                  GestureDetector(
  onTap: () async {
    try {
      await Share.share(
        'Check out this pet profile!', // Your share message
        subject: 'Pet Profile', // Optional subject for email shares
      );
    } catch (e) {
      print('Error sharing: $e');
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not share: $e')),
      );
    }
  },
  child: Image.asset(
    petShareIcon,
    width: 50.w,
  ),
),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    "All posts",
                    style: GoogleFonts.quicksand(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: blackColor),
                  )),
                  Expanded(
                    // Ensures the Divider takes available space
                    child: Divider(
                      color: primaryColor,
                      thickness: 0.5.w,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(controller.posts[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
