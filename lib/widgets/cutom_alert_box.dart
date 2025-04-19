import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/edit_post_controller.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/models/pet_model.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/peofile_screen/edit_post_screen.dart';
import 'package:pet_app/widgets/custom_buttom_widget.dart';
import 'package:pet_app/widgets/delete_alert_box.dart';
import 'package:share_plus/share_plus.dart';

class CustomAlertBox extends StatefulWidget {
  final PetModel data;
  final bool isuser;
  const CustomAlertBox({super.key,required this.isuser,required this.data});

  @override
  State<CustomAlertBox> createState() => _CustomAlertBoxState();
}

class _CustomAlertBoxState extends State<CustomAlertBox> {


  @override
  Widget build(BuildContext context) {
    EditPostController controller=Get.isRegistered()?Get.find<EditPostController>():Get.put(EditPostController(),permanent: true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Prevent unnecessary height
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
           if(widget.isuser)   
              GestureDetector(
        onTap: () {
    Navigator.pop(context); // Close the first alert box

    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (context) => DeleteAlertBox(data: widget.data,),
      );
    });
  },// Close dialog on tap
                child: Text("Delete", 
                  style: GoogleFonts.poppins(
                    color: redColor, 
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
             
              
               SizedBox(height: 5.h,),
              Divider(color: primaryColor,thickness: 0.2,),
               SizedBox(height: 5.h,),
               widget.isuser?
              GestureDetector(
                onTap: () async{
            
                  // Handle edit action
              Get.to(EditProfilescreen(data: widget.data,));
                },
                child: Text("Edit",
                  style: GoogleFonts.poppins(
                    color: blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
              :   GestureDetector(
                onTap: () {
                  // Handle edit action
                  Navigator.pop(context);
                },
                child: Text("Report",
                  style: GoogleFonts.poppins(
                    color: blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
             
              
        
              SizedBox(height: 5.h,),
         
                Divider(color: primaryColor,thickness: 0.2,),
                 
                 SizedBox(height: 5.h,),
            
              GestureDetector(
                onTap: () async{
                  print("::: the link of post is here :${widget.data.postLink}");
                  try{
                   await Share.share(
        '${widget.data.postLink}', // Your share message
        subject: 'Pet Profile', // Optional subject for email shares
      );
    } catch (e) {
      print('Error sharing: $e');
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not share: $e')),
      );
    }
                },
                child: Text("Share",
                  style: GoogleFonts.poppins(
                    color: blackColor,
                    fontSize: 18.sp,
                     fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            
            
            ],
          ),
        ),
        SizedBox(height: 10.h,),
       Padding(
         padding:  EdgeInsets.symmetric(horizontal: 45.w),
         child: CustomButtonWidget(
          onPressed: (){
            Get.back();
          },
          height: 50.h,
          backgroundColor: whiteColor,
          text: "Cancel",
          
         ),
       )
      ],
    );
  }
}
