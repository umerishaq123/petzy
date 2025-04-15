import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/auth_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/onboarding_screens.dart/forgot_password_screen.dart';
import 'package:pet_app/views/home_screens/home_screen.dart';
import 'package:pet_app/views/home_screens/nav_bar_screen.dart';
import 'package:pet_app/views/onboarding_screens.dart/signup_screen.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/custom_sign_divider.dart';
import 'package:pet_app/widgets/custom_text_field.dart';
import 'package:pet_app/widgets/social_signin_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
       final AuthController controller=Get.isRegistered()?Get.find<AuthController>():Get.put(AuthController(),permanent: true);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Text(
                'Log In',
                style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    color: primaryColor),
              ),
              SizedBox(
                height: 9.h,
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit quisque',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: blackColor.withOpacity(0.7)),
              ),
              SizedBox(
                height: 40.h,
              ),
              Text('Email',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: CustomTextField(
                  textEditingController: controller.loginemailController,
                  iconAssetPath: '',
                  hintText: 'Email',
                  containsIcon: false,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('Password',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: CustomTextField(
                  textEditingController: controller.loginpasswordController,
                  isObscure: true,
                  iconAssetPath: '',
                  hintText: 'Password',
                  containsIcon: false,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(ForgotPasswordScreen());
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: primaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: CustomButtonWidget(
                  onPressed: ()async{
                    await controller.login();

                  
                  },
                  backgroundColor: primaryColor,
                  text: 'Log In',
                  textColor: whiteColor,
                ),
              ),
               SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                   "Don't have an account?",
                    style: GoogleFonts.playfairDisplay(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: blackColor,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text:" SignUp",
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Sign up pressed");
                          Get.to(() => const SignUpScreen());
                        },
                    ),
                  ),
                ],
              ),
              
              
              SizedBox(
                height: 44.h,
              ),
              CustomDivider(text: 'Or Login with',),
               SizedBox(
                height: 20.h,
              ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SocialSignInButton(
                      text: "Google",
                      icon: FontAwesomeIcons.google,
                      onPressed: () {},
                      textColor: Colors.black,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(width: 20.w), // Add spacing between buttons
                  Expanded(
                    child: SocialSignInButton(
                      text: "Apple",
                      icon: FontAwesomeIcons.apple,
                      onPressed: () {},
                      textColor: Colors.black,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
               SizedBox(
                height: 30.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                child: Center(
                  child: Text("By creating an account or signing you agree to our Terms and Conditions",
                  textAlign: TextAlign.center,),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
