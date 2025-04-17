import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/controllers/pet_event_controller.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/contest/register_participate_screen.dart';
import 'package:pet_app/widgets/pet_event_card.dart';

class ContestScreen extends StatelessWidget {
  const ContestScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final HomeController userController=Get.isRegistered()?Get.find<HomeController>():Get.put(HomeController(),permanent: true);

    final PetEventController petEventController=Get.isRegistered()?Get.find<PetEventController>():Get.put(PetEventController(),permanent: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
        title: Text("Contest",
         style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500
          ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          if(userController.user.value.issubscribed==true)
              Center(child: Image.asset(contestScreenIcon)),
           ...petEventController.peteventList.asMap().entries.map((entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // you can adjust as needed
      child: PetEventCard(
        imageUrl: entry.value.image,
        eventTitle: entry.value.eventTitle,
        eventDate: entry.value.date,
        eventTime: '5:50',
        onParticipate: () {
          Get.to(RegisterParticipateScreen());
        },
        onJoinAsVisitor: () {},
        onTermsAndPolicy: () {},
      ),
    );
  }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}