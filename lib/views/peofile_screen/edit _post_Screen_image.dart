// edit_profile_screen_image.dart
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/edit_post_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/snackbar_utilis.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/input_field.dart';

class EditProfileScreenImage extends StatefulWidget {
  final String postId;
  
  const EditProfileScreenImage({super.key, required this.postId});

  @override
  State<EditProfileScreenImage> createState() => _EditProfileScreenImageState();
}

class _EditProfileScreenImageState extends State<EditProfileScreenImage> {
  final EditPostController controller = Get.put(EditPostController());

  // @override
  // void initState() {
  //   super.initState();
  //   controller.fetchPostData(widget.postId);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.close)
        ),
        title: Text(
          "Edit Post",
          style: GoogleFonts.quicksand(fontSize: 17.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "Save",
              style: GoogleFonts.quicksand(
                fontSize: 16.sp,
                color: primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.postData.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              /// Image Picker Area
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: GestureDetector(
                  onTap: controller.pickImagesFromGallery,
                  child: Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: controller.selectedImages.isEmpty && controller.selectedImageUrls.isEmpty
                          ? Colors.grey[200]
                          : Colors.transparent,
                      border: controller.selectedImages.isEmpty && controller.selectedImageUrls.isEmpty
                          ? Border.all(color: Colors.grey)
                          : null,
                    ),
                    child: _buildImageContent(),
                  ),
                ),
              ),

              /// Indicators
              Padding(
                padding: EdgeInsets.all(10.w),
                child: _buildImageIndicators(),
              ),

              /// Pet Name Field
            
              /// Description Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "Description",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: whiteColor,
                    border: Border.all(color: textFieldBordercolor, width: 1),
                  ),
                  child: TextFormField(
                    controller: controller.description,
                    maxLines: null,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "150 Characters left",
                      style: GoogleFonts.quicksand(
                        fontSize: 10.sp,
                        color: blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
 
              /// Location Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "Add Location",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "City/Country",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      controller.country.text = country.name;
                    },
                  );
                },
                child: AbsorbPointer(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: InputField(
                      controller: controller.country,
                      keyboardType: TextInputType.text,
                      hintText: 'Select your country',
                      fieldType: FieldType.txt,
                      readOnly: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              /// Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButtonWidget(
                  text: "Update Post",
                  textColor: Colors.white,
                  onPressed: () async {
                    if (controller.petNameController.text.isEmpty) {
                      SnackbarUtils.showCustomSnackbar(
                        title: "Error",
                        message: "Please enter pet name",
                      );
                      return;
                    }

                    if (controller.description.text.isEmpty) {
                      SnackbarUtils.showCustomSnackbar(
                        title: "Error",
                        message: "Please enter a description",
                      );
                      return;
                    }

                    if (controller.country.text.isEmpty) {
                      SnackbarUtils.showCustomSnackbar(
                        title: "Error",
                        message: "Please select a country",
                      );
                      return;
                    }

                    try {
                      await controller.updatePost(widget.postId,context);
                  
                    } catch (e) {
                      SnackbarUtils.showCustomSnackbar(
                        title: "Error",
                        message: "Failed to update post",
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildImageContent() {
    if (controller.selectedImages.isNotEmpty) {
      return PageView.builder(
        itemCount: controller.selectedImages.length,
        controller: PageController(viewportFraction: 0.9),
        onPageChanged: (index) {
          controller.currentImageIndex.value = index;
        },
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: FileImage(controller.selectedImages[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    } else if (controller.selectedImageUrls.isNotEmpty) {
      return PageView.builder(
        itemCount: controller.selectedImageUrls.length,
        controller: PageController(viewportFraction: 0.9),
        onPageChanged: (index) {
          controller.currentImageIndex.value = index;
        },
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: NetworkImage(controller.selectedImageUrls[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text(
          'Select pet images',
          style: GoogleFonts.quicksand(
            fontSize: 16.sp,
            color: Colors.grey[600],
          ),
        ),
      );
    }
  }

  Widget _buildImageIndicators() {
    final itemCount = controller.selectedImages.isNotEmpty 
        ? controller.selectedImages.length 
        : controller.selectedImageUrls.length;

    if (itemCount == 0) return SizedBox();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.0.w),
          height: 5.h,
          width: controller.currentImageIndex.value == index ? 33.w : 8.w,
          decoration: BoxDecoration(
            color: controller.currentImageIndex.value == index
                ? Colors.blue
                : Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4.0.r),
          ),
        ),
      ),
    );
  }
}