import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/edit_post_controller.dart';
import 'package:pet_app/models/pet_model.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/views/peofile_screen/edit%20_post_Screen_image.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/custom_dropdown_widget.dart';
import 'package:pet_app/widgets/custom_text_field.dart';

class EditProfilescreen extends StatefulWidget {
  final PetModel data;
  const EditProfilescreen({super.key,required this.data});

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {
  final EditPostController controller = Get.isRegistered()
      ? Get.find()
      : Get.put(EditPostController(), permanent: true);

 @override
void initState() {
  super.initState();

  // Replace "yourDocId" with the actual document ID
  String docId = widget.data.postId; 

  controller.fetchPostData(docId).then((_) {
    controller.loadData();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pet Details",
          style: GoogleFonts.quicksand(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit quisque",
                style: GoogleFonts.quicksand(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),

              /// Pet Name
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: CustomTextField(
                  textEditingController: controller.petNameController,
                  iconAssetPath: '',
                  hintText: 'Pet name',
                  containsIcon: false,
                ),
              ),
              SizedBox(height: 20.h),

              /// Pet Type Dropdown
              Obx(() {
                final breedList = controller.breedList;
                final selected = controller.selectedbreed.value;

                return CustomDropdownWidget(
                  hintText: "Pet Type",
                  selectedValue: breedList.contains(selected) ? selected : null,
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectTpe(value);
                    }
                  },
                  valueList: breedList,
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                );
              }),
              SizedBox(height: 20.h),

              /// Gender Dropdown
              Obx(() {
                final genderList = controller.genderList;
                final selected = controller.selectedGender.value;

                return CustomDropdownWidget(
                  hintText: "Gender",
                  selectedValue: genderList.contains(selected) ? selected : null,
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectGender(value);
                    }
                  },
                  valueList: genderList,
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                );
              }),
              SizedBox(height: 20.h),

              /// Age and Color Fields
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
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: CustomTextField(
                        textEditingController: controller.colorController,
                        iconAssetPath: '',
                        hintText: 'Color',
                        containsIcon: false,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              /// Height Dropdown
              Obx(() {
                final heightList = controller.height;
                final selected = controller.selectedHeight.value;

                return CustomDropdownWidget(
                  hintText: "Height",
                  selectedValue: heightList.contains(selected) ? selected : null,
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectHeight(value);
                    }
                  },
                  valueList: heightList,
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                );
              }),
              SizedBox(height: 20.h),

              /// Weight Dropdown
              Obx(() {
                final weightList = controller.weightList;
                final selected = controller.selectedWeight.value;

                return CustomDropdownWidget(
                  hintText: "Weight",
                  selectedValue: weightList.contains(selected) ? selected : null,
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectWeight(value);
                    }
                  },
                  valueList: weightList,
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                );
              }),
              SizedBox(height: 20.h),

              /// Next Button
              CustomButtonWidget(
                text: "Next",
                textColor: whiteColor,
                onPressed: () {
              
                  // You can perform validation here if needed

                  Get.to(() => EditProfileScreenImage(postId: widget.data.postId,));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
