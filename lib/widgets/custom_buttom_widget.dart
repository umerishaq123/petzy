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
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
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
        height: height ?? 48.h,
        child: Center(
          child: child ??
              Text(
                textAlign: TextAlign.center,
                text ?? '',
                style: GoogleFonts.poppins(
                  fontSize: textSize ?? 14.sp,
                  color: textColor ?? blackColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
      ),
    );
  }
}
