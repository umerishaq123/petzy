import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/utils/colors.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: halfWhiteColor2,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: darkGreyColor),
          SizedBox(width: 5.w),
          Expanded( // Ensures TextFormField takes up remaining space
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none, // Remove underline
              ),
            ),
          ),
        ],
      ),
    );
  }
}
