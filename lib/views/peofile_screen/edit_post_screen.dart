import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/add_pet_post_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/utils/snackbar_utilis.dart';
import 'package:pet_app/views/peofile_screen/edit%20_post_Screen_image.dart';
import 'package:pet_app/views/posts/post_detail_screen.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/custom_dropdown_widget.dart';
import 'package:pet_app/widgets/custom_text_field.dart';

class EditProfilescreen extends StatefulWidget {
  const EditProfilescreen({super.key});

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {

  
       
  @override
  Widget build(BuildContext context) {
    final AddPetPostController controller=Get.isRegistered()?Get.find():Get.put(AddPetPostController(),permanent: true);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: (){
        //   Get.back();
        // }, icon: Icon(Icons.close)),
        title: Text("Pet Details",style: GoogleFonts.quicksand(fontSize: 17.sp,
         fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(children: [
            SizedBox(height:40.h ,),
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit quisque",
            style: GoogleFonts.quicksand(fontSize: 16.sp,
             fontWeight: FontWeight.w400),),
              SizedBox(height:20.h ,),
               Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: CustomTextField(
                    textEditingController: controller.petNameController,
                    iconAssetPath: '',
                    hintText: 'Pet name',
                    containsIcon: false,
                  ),
                ),
                  SizedBox(height:20.h ,),
                  Obx((){
                    return  CustomDropdownWidget(
                       hintText: "Pet Type",
                      selectedValue:controller. selectedbreed.value.isEmpty
                                  ? null
                                  : controller. selectedbreed.value,
                              onChanged: (value) {
                                if (value != null) {
                                controller..selectTpe(value) ;
                                }
                              },
                              valueList: controller.breedList,
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),);
                  }),
               
                   SizedBox(height:20.h ,),
                  Obx((){
                    return  CustomDropdownWidget(selectedValue:controller. selectedGender.value.isEmpty
                                  ? null
                                  :controller. selectedGender.value,
                              onChanged: (value) {
                                if (value != null) {
                                 controller.selectGender(value);
                                }
                              },
                              valueList:controller. genderList,
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),);
                  }),
                    SizedBox(height:20.h ,),
                    Row(
                      children: [
                          Expanded(
                            child: Padding(
                                            padding: EdgeInsets.only(top: 6.h),
                                            child: CustomTextField(
                                              textEditingController: controller.ageController,
                                              iconAssetPath: '',
                                              hintText: 'Age',
                                              containsIcon: false,
                                            ),
                                          ),
                          ),
                          SizedBox(width: 10.w,),
                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: CustomTextField(
                      textEditingController: controller.colorController,
                      iconAssetPath: '',
                      hintText: 'color',
                      containsIcon: false,
                    ),
                                  ),
                  ),
                      ],
                    ),
                      SizedBox(height:20.h ,),
                  Obx((){
                    return  CustomDropdownWidget(selectedValue:controller. selectedHeight.value.isEmpty
                                  ? null
                                  :controller. selectedHeight.value,
                              onChanged: (value) {
                                if (value != null) {
                                 controller.selectHeight(value);
                                }
                              },
                              valueList:controller. height,
                               hintText: "Height",
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),);
                  }),
                    SizedBox(height:20.h ,),
                  Obx((){
                    return  CustomDropdownWidget(
                     hintText: "Weight",
                      selectedValue:controller. selectedWeight.value.isEmpty
                                  ? null
                                  :controller. selectedWeight.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectWeight(value);
                                }
                              },
                              valueList:controller. weightList,
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),);
                  }),
                   SizedBox(height:20.h ,),
                  CustomButtonWidget(
  text: "Next",
  textColor: whiteColor,
  onPressed: () {
    final petName = controller.petNameController.text.trim();
    final petType = controller.selectedbreed;
    final gender = controller.selectedGender;
    final age = controller.ageController.text.trim();
    final color = controller.colorController.text.trim();
    final height = controller.selectedHeight;
    final weight = controller.selectedWeight; // Fixed this line

 

    // All validations passed
    Get.to(EditProfileScreenImage());
  },
)

                 
          ],),
        ),
      ),
    );
  }
}