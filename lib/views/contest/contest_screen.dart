import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/images.dart';

class ContestScreen extends StatelessWidget {
  const ContestScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(contestScreenIcon))
        ],
      ),
    );
  }
}