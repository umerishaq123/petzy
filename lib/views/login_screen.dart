import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
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
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: CustomButtonWidget(
                backgroundColor: primaryColor,
                text: 'Log In',
                textColor: whiteColor,
              ),
            ),
            SizedBox(
              height: 44.h,
            ),
          ],
        ),
      ),
    );
  }
}
