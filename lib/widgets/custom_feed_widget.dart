import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/models/pet_model.dart';
import 'package:pet_app/models/user_model.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/home_screens/search_screen.dart';
import 'package:pet_app/views/peofile_screen/profile_screen.dart';
import 'package:pet_app/widgets/cutom_alert_box.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomFeedWidget extends StatefulWidget {
  final String isuser;
  final PetModel feedData;
  const CustomFeedWidget({super.key, required this.feedData,required this.isuser});

  @override
  State<CustomFeedWidget> createState() => _CustomFeedWidgetState();
}

class _CustomFeedWidgetState extends State<CustomFeedWidget> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    bool isuserId=widget.isuser==currentUserId;
    String timeAgoText = timeago.format(widget.feedData.createdAt);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User profile section
          GestureDetector(
            onTap: () {
              Get.to(ProfileScreen(iscome: false));
            },
            child: Row(
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
                      // foregroundImage: AssetImage(widget.feedData.image),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.feedData.petName,
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
                            timeAgoText,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: blackColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => CustomAlertBox(isuser: isuserId, data: widget.feedData,),
                              );
                            },
                            child: Image.asset(
                              optionIcon,
                              width: 25.w,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.feedData.description,
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
          ),
          SizedBox(height: 10.h),
          
          // Images section with multi-image support
          if (widget.feedData.images != null && widget.feedData.images!.isNotEmpty)
            Container(
              width: double.infinity,
              height: 350.h, // Adjust height as needed
              child: Stack(
                children: [
                  // Images PageView
                  PageView.builder(
                    controller: _pageController,
                    itemCount: widget.feedData.images!.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.network(
                          widget.feedData.images![index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(Icons.error, color: Colors.red),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  
                  // Image counter indicator (only for multiple images)
                  if (widget.feedData.images!.length > 1)
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          "${_currentImageIndex + 1}/${widget.feedData.images!.length}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                  // Background image overlay
                  Positioned(
                    right: 0,
                    top: 70.h,
                    child: Image.asset(
                      backgroundImage,
                      width: 60.w,
                    )
                  ),
                  
                  // Interaction buttons
                  Positioned(
                    right: 10.w,
                    top: 90.h,
                    child: Column(
                      children: [
                        Image.asset(pawsIcon, width: 45.w),
                        SizedBox(height: 5.h),
                        Image.asset(chatIcon, width: 45.w),
                        SizedBox(height: 5.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SearchScreen());
                          },
                          child: Image.asset(shareIcon, width: 45.w),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
          // Dots indicator for multiple images
          if (widget.feedData.images != null && widget.feedData.images!.length > 1)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.feedData.images!.length,
                  (index) => Container(
                    width: 8.w,
                    height: 9.w,
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex == index
                          ? primaryColor // Using your app's primary color
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            
          SizedBox(height: 15.h), // Add some space after the post
        ],
      ),
    );
  }
}