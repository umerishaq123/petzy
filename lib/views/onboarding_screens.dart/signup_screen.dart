import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/auth_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/home_screens/home_screen.dart';
import 'package:pet_app/views/onboarding_screens.dart/login_screen.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/custom_sign_divider.dart';
import 'package:pet_app/widgets/custom_text_field.dart';
import 'package:pet_app/widgets/social_signin_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   bool isChecked = false; 
   final AuthController controller=Get.isRegistered()?Get.find<AuthController>():Get.put(AuthController(),permanent: true);
  @override
  Widget build(BuildContext context) {
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
                'Create Account',
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
              Text('Name',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: CustomTextField(
                  textEditingController: controller.nameController,
                  iconAssetPath: '',
                  hintText: 'Name',
                  containsIcon: false,
                ),
              ),
              SizedBox(
                height: 20.h,
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
                  textEditingController: controller.emailController,
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
                  textEditingController: controller.passwordController,
                  isObscure: true,
                  iconAssetPath: '',
                  hintText: 'Password',
                  containsIcon: false,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
               Text('Confirm password',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: CustomTextField(
                  textEditingController: controller.confirmpasswordController,
                  isObscure: true,
                  iconAssetPath: '',
                  hintText: 'Confirm password',
                  containsIcon: false,
                ),
              ),
               SizedBox(
                height: 20.h,
              ),
           Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Transform.scale(
      scale: 1.2, // Adjust size
      child: Checkbox(
        shape: CircleBorder(), // Makes checkbox circular
        value: isChecked, // Boolean value to track state
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
        activeColor: primaryColor, // Checkbox fill color
        checkColor: Colors.white, // Tick mark color
      ),
    ),
    SizedBox(width: 3.w), // Spacing between checkbox and text
    Expanded(
      child: Text(
        'I accept the terms and privacy policy',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    ),
  ],
),

              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: CustomButtonWidget(
                  onPressed: ()async{
                 await  controller.signUp();
                    // Get.to(()=>HomeScreen());
                  },
                  backgroundColor: primaryColor,
                  text: 'Create account',
                  textColor: whiteColor,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                   "Already have an account?",
                    style: GoogleFonts.playfairDisplay(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: blackColor,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text:" SignIn",
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Sign up pressed");
                          Get.to(() => const LoginScreen());
                        },
                    ),
                  ),
                ],
              ),
                SizedBox(height: 10.h),
              
              
             
         
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                child: Center(
                  child: Text("By creating an account or signing you agree to our Terms and Conditions",
                  textAlign: TextAlign.center,),
                ),
              ),
                  SizedBox(height: 10.h),

            ],
          ),
        ),
      ),
    );
  }
}
