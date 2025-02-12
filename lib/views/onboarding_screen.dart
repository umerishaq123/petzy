import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/login_screen.dart';

import '../controllers/onboarding_controller.dart';
import '../widgets/custom_buttom_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController onBoardingController =
        Get.isRegistered<OnboardingController>()
            ? Get.find<OnboardingController>()
            : Get.put(OnboardingController());
    final PageController pageController = PageController();
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            // flex: 3,
            child: PageView.builder(
              controller: pageController,
              itemCount: onBoardingController.onboardingScreenData.length,
              onPageChanged: (index) {
                print('This is the index: $index');

                onBoardingController.currentPage.value = index;
                print(
                    'This is the lottie animation ${onBoardingController.onboardingScreenData[onBoardingController.currentPage.value]['imagePath']}');
              },
              itemBuilder: (context, index) {
                final data = onBoardingController.onboardingScreenData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(bottom: 0),
                  child: Obx(() {
                    double opacity =
                        (onBoardingController.currentPage.value == index)
                            ? 1.0
                            : 0.0;
                    double scale =
                        (onBoardingController.currentPage.value == index)
                            ? 1.0
                            : 0.8;
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: opacity,
                      child: AnimatedScale(
                        scale: scale,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              onBoardingController.onboardingScreenData[
                                      onBoardingController
                                          .currentPage.value]['imagePath'] ??
                                  firstOnboarding,
                              width: 250.w,
                              height: 250.h,
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Text(
                              data['title']!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: whiteColor,
                              ),
                            ),
                            SizedBox(height: 4.0.h),
                            Text(
                              data['subtitle']!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          Obx(
            () => Padding(
              padding: EdgeInsets.all(20.w).copyWith(top: 0, bottom: 30.w),
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onBoardingController.onboardingScreenData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                        height: 5.h,
                        width: onBoardingController.currentPage.value == index
                            ? 33.w
                            : 8.w,
                        decoration: BoxDecoration(
                          color: onBoardingController.currentPage.value == index
                              ? whiteColor
                              : whiteColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4.0.r),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomButtonWidget(
                    backgroundColor: whiteColor,
                    borderRadius: 50.r,
                    height: 50.h,
                    width: 50.w,
                    onPressed: () {
                      if (onBoardingController.currentPage.value ==
                          onBoardingController.onboardingScreenData.length -
                              1) {
                        Get.offAll(
                          () => const LoginScreen(),
                        );
                      } else {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Image.asset(
                      color: blackColor,
                      rightArrow,
                      height: 16.r,
                      width: 16.r,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
