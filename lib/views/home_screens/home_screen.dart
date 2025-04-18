import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/controllers/auth_controller.dart';
import 'package:pet_app/controllers/home_controller.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/extensions/local_storage.dart';
import 'package:pet_app/utils/images.dart';
import 'package:pet_app/views/peofile_screen/profile_screen.dart';
import 'package:pet_app/widgets/custom_drawer_widget.dart';
import 'package:pet_app/widgets/custom_feed_widget.dart';
import 'package:pet_app/widgets/shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController(), permanent: true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String userName = '';

  @override
  void initState() {
    super.initState();
    loadUserName();
    homeController.fetchAllPost();
  }

  void loadUserName() async {
    final user = await LocalStorage().getUserData();
    setState(() {
      userName = user?.name ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: halfWhiteColor,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: EdgeInsets.only(top: 110.h, bottom: 20.h),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: GestureDetector(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: Image.asset(menu, width: 35.w),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(ProfileScreen(iscome: true)),
                        child: CircleAvatar(
                          radius: 40.r,
                          foregroundImage: AssetImage(homeController.user.value.profile),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Hello, (${userName})",
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
            
            // Divider
            Divider(color: textFieldBordercolor, thickness: 1.0),
        
            
            // Posts Section
            Obx(() {
              if (homeController.isloading.value) {
                return Column(
                  children: List.generate(
                    6,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        children: [
                          ShimmerWidget.rectangular(
                            width: double.infinity,
                            height: 80.h,
                          ),
                          SizedBox(height: 10.h),
                          ShimmerWidget.rectangular(
                            width: double.infinity,
                            height: 200.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (homeController.postList.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 100.h),
                  child: Text(
                    "No post found",
                    style: GoogleFonts.quicksand(
                      fontSize: 16.sp,
                      color: blackColor,
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(height: 30.h),
                    ...homeController.postList.map(
                      (data) => Padding(
                        padding: EdgeInsets.only(bottom: 25.h),
                        child: CustomFeedWidget(feedData: data, isuser: data.uid,),
                      ),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}