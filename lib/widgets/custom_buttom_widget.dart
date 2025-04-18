import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Widget? child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? textSize;
  final Color? textColor;
  final EdgeInsetsGeometry? buttonMargin;
  final Color? borerColor;
  final bool isLoading; // ✅ Add this

  const CustomButtonWidget({
    super.key,
    this.text,
    this.onPressed,
    this.backgroundColor,
    this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.textColor,
    this.buttonMargin,
    this.textSize,
    this.borerColor,
    this.isLoading = false, // ✅ Default false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed, // ✅ Disable if loading
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? primaryColor,
          border: Border.all(color: borerColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(
            borderRadius ?? 40.0.r,
          ),
        ),
        margin: buttonMargin ??
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.0.h),
        width: width ?? double.infinity,
        height: height ?? 55.h,
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textColor ?? Colors.white,
                    ),
                    strokeWidth: 2,
                  ),
                )
              : (child ??
                  Text(
                    textAlign: TextAlign.center,
                    text ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: textSize ?? 14.sp,
                      color: textColor ?? blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
        ),
      ),
    );
  }
}
