
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/utils/colors.dart';

class SnackbarUtils {
  static void showCustomSnackbar({
    required String title,
    required String message,
    Color backgroundColor = primaryColor,
    Color textColor = Colors.white,
    IconData icon = Icons.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: Icon(icon, color: textColor),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: duration,
      animationDuration: const Duration(milliseconds: 300),
      isDismissible: true,
 
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
