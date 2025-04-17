import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/extensions/local_storage.dart';
import 'package:pet_app/views/home_screens/nav_bar_screen.dart';
import 'package:pet_app/views/onboarding_screens.dart/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocalStorage localStorage=LocalStorage();
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
   Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // optional splash delay
    String? userId = await localStorage.getValue("userId");

    if (userId != null && userId.isNotEmpty) {
      // user is logged in
      Get.offAll(() =>  NavBarScreen()); // replace with your home screen
    } else {
      // user not logged in
      Get.offAll(() => const OnBoardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Text(
          'Logo',
          style: TextStyle(
            fontSize: 64.sp,
            fontWeight: FontWeight.w700,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
