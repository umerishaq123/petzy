import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/auth_controller.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/peofile_screen/profile_screen.dart';
import 'package:pet_app/widgets/custom_feed_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.isRegistered()
      ? Get.find<HomeController>()
      : Get.put(HomeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    AuthController authController=Get.isRegistered()?Get.find<AuthController>():Get.put(AuthController());
    print(":::::::::the user id is here :${authController.userData.value?.uid}");
    return Scaffold(
      backgroundColor: halfWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 110.h,
            ),
        
            Center(
              child: GestureDetector(
                onTap: (){
                  Get.to(ProfileScreen(iscome: true,));
                },
                child: CircleAvatar(
                  radius: 40.r,
                  foregroundImage: AssetImage(controller.user.value.profile),
                ),
              ),
            ),
             SizedBox(
              height: 10.h,
            ),
            Center(child: Text("Hello, (${controller.user.value.name})",
            style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: blackColor,
            ),)),
             SizedBox(
              height: 20.h,
            ),
            Divider(color:textFieldBordercolor ,
            thickness: 1.0,),
             SizedBox(
              height: 20.h,
            ),
             
          Obx((){
            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.user.value.feedData.length,
              itemBuilder: (context,index){
                final data=controller.user.value.feedData[index];
                return Padding(
                  padding:  EdgeInsets.only(bottom: 25.h),
                  child: CustomFeedWidget(feedData: data,),
                );
              });
          })
          ],
        ),
      ),
    );
  }
}
