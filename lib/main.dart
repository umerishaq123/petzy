import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';
import 'package:pet_app/utils/extensions/local_storage.dart';
import 'package:pet_app/views/home_screens/nav_bar_screen.dart';
import 'package:pet_app/views/peofile_screen/follower_screen.dart';
import 'package:pet_app/views/peofile_screen/notification_screen.dart';
import 'package:pet_app/views/peofile_screen/profile_screen.dart';
import 'package:pet_app/views/posts/add_post_screen.dart';
import 'package:pet_app/views/onboarding_screens.dart/splash_screen.dart';

Future<void> main() async {
  
   WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding
  await Firebase.initializeApp(); 
    configLoading();
     await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  await Stripe.instance.applySettings();
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
             builder: EasyLoading.init(), 
             
            home: const SplashScreen(),
            //  home:  NotificationScreen(),
          );
        });
  }
}
void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.dark
    ..maskType = EasyLoadingMaskType.black
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..dismissOnTap = false;
}
void checkStoredUserId() async {
  final LocalStorage localStorage = LocalStorage();
  String? id = await localStorage.getValue("userId");
  print("Stored User ID is: $id");
}

