import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/custom_search_widget.dart';
import 'package:pet_app/widgets/message_input_widget.dart';
import 'package:pet_app/widgets/share_list_item_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.isRegistered() ? Get.find<HomeController>() : Get.put(HomeController(), permanent: true);
    
    // Add a RxBool to track if a user is selected
    final RxBool isUserSelected = false.obs;
    TextEditingController messageController=TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          }, 
          icon: Icon(Icons.arrow_back)
        ),
        title: Text(
          "Share post",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search and List Section (takes remaining space)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomSearchWidget(),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.user.value.followerList.length,
                      itemBuilder: (context, index) {
                        final data = controller.user.value.followerList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                          child: ShareListItemWidget(
                            follower: data, 
                            index: index,
                           
                          ),
                        );
                      },
                    ),
                  ),
                  // Add bottom padding to account for fixed bottom section
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
          
          // Fixed Bottom Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                // BoxShadow(
                //   color: Colors.black.withOpacity(0.1),
                //   blurRadius: 10,
                //   offset: Offset(0, -5),
                // ),
              ],
            ),
            child: Column(
              children: [
                MessageInputWidget(controller: messageController,),
                SizedBox(height: 15.h),
                Obx(() => CustomButtonWidget(
                  text: "Send",
                  textColor: whiteColor,
                  backgroundColor:controller. isUserSelected.value ? primaryColor : Colors.grey,
                  onPressed:controller. isUserSelected.value ? () {
                    // Handle send action
                  } : null,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}