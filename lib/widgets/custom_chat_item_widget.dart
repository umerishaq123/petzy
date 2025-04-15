import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/models/all_chat_model.dart';
import 'package:pet_app/models/user_model.dart';
import 'package:pet_app/models/user_model_firebase.dart';
import 'package:pet_app/utils/colors.dart';

class CustomChatItemWidget extends StatelessWidget {
  final int index;
  final UserModel chatData;
  const CustomChatItemWidget(
      {super.key, required this.chatData, required this.index});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.isRegistered()
        ? Get.find<HomeController>()
        : Get.put(HomeController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.isShareList.isEmpty &&
          controller.user.value.followerList.isNotEmpty) {
        controller.initializeShareList();
      }
    });
    return Slidable(
      key: Key("abc"),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(  // Changed from SizedBox to CustomSlidableAction
            flex: 1,  // Moved flex property here
            child: Container(  // Added Container for styling
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            onPressed: (context) {},
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
            CircleAvatar(
  backgroundColor: blackColor,
  radius: 30.r,
  child: ClipOval(
    child: Image.network(
      chatData.image,
      width: 65.w,
      height: 65.h,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/images/pet1.png", // Provide a valid asset path
          width: 65.w,
          height: 65.h,
          fit: BoxFit.cover,
        );
      },
    ),
  ),
),

              
              if (chatData.isOnline)
                Positioned(
                  right: 0.w,
                  child: Container(
                    height: 13.h,
                    width: 13.w,
                    decoration: BoxDecoration(
                        color: greenColor, shape: BoxShape.circle),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(  // This Expanded is correctly placed inside a Row (Flex widget)
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatData.name,
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 3.w,
                    ),
                    Text(chatData.lastMessage,
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: darkGreyColor,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Column(
                  children: [
                    Text(chatData.time),
                    SizedBox(height: 5.h),
                    if (chatData.unreadMessageCount >= 1)
                      Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                            color: greenColor, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            chatData.unreadMessageCount.toString(),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: whiteColor),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
