import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/home_screens/home_screen.dart';
import 'package:pet_app/views/onboarding_screens.dart/login_screen.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/custom_sign_divider.dart';
import 'package:pet_app/widgets/custom_text_field.dart';
import 'package:pet_app/widgets/social_signin_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
   bool isChecked = false; 
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
                'Reset Password',
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
           
              Text('Password',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: CustomTextField(
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
                  isObscure: true,
                  iconAssetPath: '',
                  hintText: 'Confirm password',
                  containsIcon: false,
                ),
              ),
               SizedBox(
                height: 30.h,
              ),
        
            
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: CustomButtonWidget(
                  onPressed: (){
                    Get.to(()=>LoginScreen());
                  },
                  backgroundColor: primaryColor,
                  text: 'Reset Password',
                  textColor: whiteColor,
                ),
              ),
             
         
            

            ],
          ),
        ),
      ),
    );
  }
}
