import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/models/user_model.dart';
import 'package:pet_app/utils/colors.dart';

class ShareListItemWidget extends StatelessWidget {
  final int index;
  final Follower follower;
  const ShareListItemWidget(
      {super.key, required this.follower, required this.index});

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
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: blackColor,
          radius: 25.r,
          child: Image.network(
            follower.profilePic,
            width: 60.w,
            height: 60.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(follower.profilePic,
                   width: 60.w,
            height: 60.h,fit: BoxFit.cover);
            },
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    follower.title,
                    style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                   SizedBox(
          height: 5.w,
        ),
                  Text(follower.subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: blackColor,
                          fontWeight: FontWeight.w400))
                ],
              ),
              Obx(() {
                if (index >= controller.isShareList.length) {
                  return Checkbox(value: false, onChanged: null);
                }
                return CheckboxTheme(
                  data: CheckboxThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5), // Adjust the radius
                    ),
                  ),
                  child: Checkbox(
                      value: controller.isShareList[index],
                      onChanged: (value) {
                        controller.shareChecked(index, value ?? false);
                      }),
                );
              })
            ],
          ),
        )
      ],
    );
  }
}
