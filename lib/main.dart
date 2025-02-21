import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/views/nav_bar_screen.dart';
import 'package:pet_app/views/peofile_screen/follower_screen.dart';
import 'package:pet_app/views/peofile_screen/notification_screen.dart';
import 'package:pet_app/views/peofile_screen/profile_screen.dart';
import 'package:pet_app/views/posts/add_post_screen.dart';
import 'package:pet_app/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            title: 'PETAPP',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.quicksandTextTheme(
                Theme.of(context).textTheme.copyWith(),
              ),
              // iconTheme: const IconThemeData(color: primaryColor),
              // scaffoldBackgroundColor: appBackGroundColor,
              // progressIndicatorTheme: ProgressIndicatorThemeData(
              //   color: whiteColor,
              //   circularTrackColor: Colors.transparent,
              // ),
              // textSelectionTheme: const TextSelectionThemeData(
              //   cursorColor: Colors.grey,
              // ),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: primaryColor,
              ),
            ),
            // home: const SplashScreen(),
             home:  NotificationScreen(),
          );
        });
  }
}
