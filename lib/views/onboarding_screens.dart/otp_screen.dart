import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/views/onboarding_screens.dart/reset_password_screen.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Otp',
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

              // OTP Form
              const OtpForm(),

              SizedBox(height: 20.h),

              // Resend OTP Button
            
           
            ],
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFFD8DADC)),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _otpControllers = List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getOtp() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return SizedBox(
                height: 73.h,
                width: 60.w,
                child: TextFormField(
                  controller: _otpControllers[index],
                  onChanged: (pin) {
                    if (pin.isNotEmpty && index < 4) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24.sp,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Color(0xFF757575)),
                    border: authOutlineInputBorder,
                    enabledBorder: authOutlineInputBorder,
                    focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 20.h),
          Text(
           " Send code again 2 min",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: blackColor,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: CustomButtonWidget(
              onPressed: () {
                // You might want to navigate to another screen after verifying OTP
                Get.to(() => const ResetPasswordScreen());
              },
              backgroundColor: primaryColor,
              text: 'Verify OTP',
              textColor: whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
