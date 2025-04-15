import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';

class DeleteAlertBox extends StatelessWidget {
  const DeleteAlertBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Delete post?",style: GoogleFonts.poppins(fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color:  blackColor),)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min, // Prevent unnecessary height
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Are you want sure to delete this post ",
          style: GoogleFonts.poppins(fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color:  blackColor),
          textAlign: TextAlign.center,),
           SizedBox(height: 15.h,),
          GestureDetector(
            onTap: () => Navigator.pop(context), // Close dialog on tap
            child: Text("Delete", 
              style: GoogleFonts.poppins(
                color: redColor, 
                fontSize: 18.sp,
             fontWeight: FontWeight.w500,
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
            child: Text("Cancel",
              style: GoogleFonts.poppins(
                color: blackColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        
       
        ],
      ),
    );
  }
}
