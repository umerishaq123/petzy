
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/extensions/local_storage.dart';
import 'package:pet_app/views/onboarding_screens.dart/login_screen.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Centered "Menu"
                Center(
                  child: Text(
                    "Menu",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: blackColor,
                    ),
                  ),
                ),

                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      size: 20.r,
                      Icons.arrow_back,
                      color:blackColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                // Get.to(() => ProfileScreen());
              },
              child: Column(
                children: [
              
                ],
              ),
            ),
            // ListTile(
            //   leading: Image.asset(
            //     AppImages.notificationIcon,
            //     width: 20.w,
            //   ),
            //   title: Text(
            //     "Notification settings",
            //     style: GoogleFonts.poppins(
            //       fontSize: 14.sp,
            //       fontWeight: FontWeight.w500,
            //       color: AppColors.blackColor,
            //     ),
            //   ),
            //   trailing: Obx(
            //     () {
            //       return Transform.scale(
            //         scale: 0.8,
            //         child: Switch(
            //           value: controller.isenable.value,
            //           onChanged: (value) async {
            //             controller.switchToggle(value);
            //           },
            //           activeColor: AppColors.primaryColor,
            //           activeTrackColor: AppColors.secondaryColor,
            //           inactiveTrackColor: AppColors.greyColor,
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // Divider(
            //   thickness: 1.w,
            // ),
       
            
            CustomButtonWidget(
              height: 47.h,
             onPressed: () async {
  try {
   await FirebaseAuth.instance.signOut().then((value){
    LocalStorage().deleteValue("userId");
    
 Get.offAll(LoginScreen()); 
   }); 
   // Navigate to login screen
  } catch (e) {
    print("Error while signing out: $e");
    // Optionally show a dialog/snackbar
  }
},

              // text: "Logout",
              backgroundColor: primaryColor,
              // text: "Logout",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Log Out',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Icon(
                    Icons.logout,
                    color: redColor,
                    size: 20.r,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
