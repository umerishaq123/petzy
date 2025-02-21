import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/notification_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.isRegistered()
      ? Get.find<NotificationController>()
      : Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, size: 24.sp),
        ),
        title: Text(
          "Notifications",
          style: GoogleFonts.quicksand(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Text(
                  "Today",
                  style: GoogleFonts.quicksand(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                Obx(() {
                  return SizedBox(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.notificationData.length,
                      separatorBuilder: (context, index) => SizedBox(height: 5.h),
                      itemBuilder: (context, index) {
                        final data = controller.notificationData[index];
                        return IntrinsicHeight(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 24.r,
                                  backgroundImage: AssetImage(data.profilePic),
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.h),
                                    child: Text(
                                      data.title,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                if (data.isfollow ?? false)
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomButtonWidget(
                                      textSize: 12.sp,
                                      height: 40.h,
                                      width: 100.w,
                                      text: "Follow back",
                                      textColor: whiteColor,
                                      onPressed: () {},
                                    ),
                                  )
                                else
                                  Container(
                                        height: 60.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: DecorationImage(
                                        image: AssetImage(data.postImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
             Divider(color: primaryColor, thickness: 0.3),
                Text(
                  "Yesterday",
                  style: GoogleFonts.quicksand(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                  SizedBox(height: 12.h),
                Obx(() {
                  return SizedBox(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.notificationData.length,
                      separatorBuilder: (context, index) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final data = controller.notificationData[index];
                        return IntrinsicHeight(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 24.r,
                                  backgroundImage: AssetImage(data.profilePic),
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.h),
                                    child: Text(
                                      data.title,
                                     style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                if (data.isfollow ?? false)
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomButtonWidget(
                                      textSize: 12.sp,
                                      height: 40.h,
                                      width: 100.w,
                                      text: "Follow back",
                                      textColor: whiteColor,
                                      onPressed: () {},
                                    ),
                                  )
                                else
                                  Container(
                                       height: 60.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: DecorationImage(
                                        image: AssetImage(data.postImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              
              
              
                Divider(color: primaryColor, thickness: 0.3),
                Text(
                  "7 Days ago",
                  style: GoogleFonts.quicksand(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                  SizedBox(height: 12.h),
                   Obx(() {
                  return SizedBox(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.notificationData.length,
                      separatorBuilder: (context, index) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final data = controller.notificationData[index];
                        return IntrinsicHeight(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 24.r,
                                  backgroundImage: AssetImage(data.profilePic),
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.h),
                                    child: Text(
                                      data.title,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                if (data.isfollow ?? false)
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomButtonWidget(
                                      textSize: 12.sp,
                                      height: 40.h,
                                      width: 100.w,
                                      text: "Follow back",
                                      textColor: whiteColor,
                                      onPressed: () {},
                                    ),
                                  )
                                else
                                  Container(
                                    height: 60.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: DecorationImage(
                                        image: AssetImage(data.postImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              
              
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}