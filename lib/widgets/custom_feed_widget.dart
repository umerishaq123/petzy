import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/models/user_model.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';

class CustomFeedWidget extends StatelessWidget {
  final FeedModel feedData;
  const CustomFeedWidget({super.key, required this.feedData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 33.r,
                    backgroundColor: whiteColor,
                  ),
                  CircleAvatar(
                    radius: 30.r,
                    foregroundImage: AssetImage(feedData.image),
                  ),
                ],
              ),
              SizedBox(width: 10.w), // Add some spacing between the avatar and the text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedData.petName,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: blackColor,
                      ),
                    ),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          feedData.createdAt,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: blackColor,
                          ),
                        ),
                        Image.asset(
                          optionIcon,
                          width: 25.w,
                        ),
                      ],
                    ),
                   // Add some spacing between the date and the description
                    Text(
                      feedData.description,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: blackColor,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
       Stack(
      children: [
    Container(
      height: 350.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40.r)),
        image: DecorationImage(
          image: AssetImage(feedData.postImage), 
          fit: BoxFit.cover, 
        ),
      ),
    ),
    Positioned(
      right: 0,
      top: 80.h,
      child: Image.asset(backgroundImage,width: 60.w,)),
       Positioned(
         right: 10,
      top: 100.h,
         child: Column(
                 children: [
          Image.asset(pawsIcon,width: 45.w,),
              
          SizedBox(height: 5.h,),
           Image.asset(chatIcon,width: 45.w,),
                SizedBox(height: 5.h,),
                 Image.asset(shareIcon,width: 45.w,),
                 ],
               ),
       )
      ],
    ),
         
        ],
      ),
    );
  }
}