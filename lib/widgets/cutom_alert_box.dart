import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/delete_alert_box.dart';

class CustomAlertBox extends StatelessWidget {
  const CustomAlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Prevent unnecessary height
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
        onTap: () {
    Navigator.pop(context); // Close the first alert box

    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (context) => DeleteAlertBox(),
      );
    });
  },// Close dialog on tap
                child: Text("Delete", 
                  style: GoogleFonts.poppins(
                    color: redColor, 
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
               SizedBox(height: 5.h,),
              Divider(color: primaryColor,thickness: 0.2,),
               SizedBox(height: 5.h,),
              GestureDetector(
                onTap: () {
                  // Handle edit action
                  Navigator.pop(context);
                },
                child: Text("Edit",
                  style: GoogleFonts.poppins(
                    color: blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 5.h,),
                Divider(color: primaryColor,thickness: 0.2,),
                 SizedBox(height: 5.h,),
              GestureDetector(
                onTap: () {
                  // Handle report action
                  Navigator.pop(context);
                },
                child: Text("Report",
                  style: GoogleFonts.poppins(
                    color: blackColor,
                    fontSize: 18.sp,
                     fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
       Padding(
         padding:  EdgeInsets.symmetric(horizontal: 45.w),
         child: CustomButtonWidget(
          onPressed: (){
            Get.back();
          },
          height: 50.h,
          backgroundColor: whiteColor,
          text: "Cancel",
          
         ),
       )
      ],
    );
  }
}
