import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/pet_event_controller.dart';
import 'package:pet_app/controllers/post_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/custom_text_field.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  PetEventController petEventController = Get.put(PetEventController());

  final PostImageController postImageController =
      Get.put(PostImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
        title: Text(
          "New Post",
          style: GoogleFonts.quicksand(
              fontSize: 17.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "Post",
              style: GoogleFonts.quicksand(
                  fontSize: 16.sp,
                  color: primaryColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
              child: Column(
                children: [
                  // This shows the list of images horizontally with GetX
                  Container(
                    height: 200.h,
                    child: Obx(() {
                      if (petEventController.selectedImages.isEmpty) {
                        return GestureDetector(
                          onTap: petEventController.pickImagesFromGallery,
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                'Select pet images',
                                style: GoogleFonts.quicksand(
                                  fontSize: 16.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return PageView.builder(
                          itemCount: petEventController.selectedImages.length,
                          controller: PageController(viewportFraction: 0.9),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: FileImage(
                                      petEventController.selectedImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ),

                  // Responsive indicators with GetX
                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            postImageController.postImages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                              height: 5.h,
                              width:
                                  postImageController.currentImageIndex.value ==
                                          index
                                      ? 33.w
                                      : 8.w,
                              decoration: BoxDecoration(
                                color: postImageController
                                            .currentImageIndex.value ==
                                        index
                                    ? Colors.blue // Active color
                                    : Colors.grey
                                        .withOpacity(0.5), // Inactive color
                                borderRadius: BorderRadius.circular(4.0.r),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Description",
                style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: whiteColor,
                  border: Border.all(
                      color: textFieldBordercolor,
                      width: 1), // Background color
                ),
                child: TextFormField(
                  maxLines: null, // Allows text field to expand
                  minLines: 1, // Starts with one line
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: InputBorder.none, // Removes default border
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
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
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Add Location",
                style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "City/Country",
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: blackColor,
                      fontWeight: FontWeight.w400),
                )),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomTextField(
                iconAssetPath: '',
                hintText: 'Enter your location here',
                containsIcon: false,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButtonWidget(
                text: "Upload Post",
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
