import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/posts/post_detail_screen.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/custom_dropdown_widget.dart';
import 'package:pet_app/widgets/custom_text_field.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
    RxString selectedbreed = ''.obs;
     RxString selectedGender = ''.obs;
         RxString selectedHeight = ''.obs;
             RxString selectedWeight = ''.obs;
     final List<String> breedList = ['Husky', 'Germen', 'Other'];
      final List<String> genderList = ['Male', 'Female', 'Other'];
          final List<String> height = ['20 ft', '30ft', '40ft'];
              final List<String> weightList = ['10w', '20w', '30w'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.close)),
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
                    iconAssetPath: '',
                    hintText: 'Pet name',
                    containsIcon: false,
                  ),
                ),
                  SizedBox(height:20.h ,),
                  Obx((){
                    return  CustomDropdownWidget(
                       hintText: "Pet Type",
                      selectedValue: selectedbreed.value.isEmpty
                                  ? null
                                  : selectedbreed.value,
                              onChanged: (value) {
                                if (value != null) {
                                  selectedbreed.value = value;
                                }
                              },
                              valueList: breedList,
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),);
                  }),
                  SizedBox(height:20.h ,),
               Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: CustomTextField(
                    iconAssetPath: '',
                    hintText: 'Breed',
                    containsIcon: false,
                  ),
                ),
                   SizedBox(height:20.h ,),
                  Obx((){
                    return  CustomDropdownWidget(selectedValue: selectedGender.value.isEmpty
                                  ? null
                                  : selectedGender.value,
                              onChanged: (value) {
                                if (value != null) {
                                  selectedGender.value = value;
                                }
                              },
                              valueList: genderList,
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),);
                  }),
                    SizedBox(height:20.h ,),
                    Row(
                      children: [
                          Expanded(
                            child: Padding(
                                            padding: EdgeInsets.only(top: 6.h),
                                            child: CustomTextField(
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
                    return  CustomDropdownWidget(selectedValue: selectedHeight.value.isEmpty
                                  ? null
                                  : selectedHeight.value,
                              onChanged: (value) {
                                if (value != null) {
                                  selectedHeight.value = value;
                                }
                              },
                              valueList: height,
                               hintText: "Height",
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),);
                  }),
                    SizedBox(height:20.h ,),
                  Obx((){
                    return  CustomDropdownWidget(
                     hintText: "Weight",
                      selectedValue: selectedWeight.value.isEmpty
                                  ? null
                                  : selectedWeight.value,
                              onChanged: (value) {
                                if (value != null) {
                                  selectedWeight.value = value;
                                }
                              },
                              valueList: weightList,
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),);
                  }),
                   SizedBox(height:20.h ,),
                   CustomButtonWidget(text: "Next",
                   textColor: whiteColor,
                   onPressed: (){
                    Get.to(PostDetailScreen());
                   },)
                 
          ],),
        ),
      ),
    );
  }
}