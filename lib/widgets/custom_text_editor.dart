
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';

class CustomTextEditor extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Gradient? gradient;
  final Color backgroundColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final EdgeInsets contentPadding;
  final BorderRadius borderRadius;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final int? maxLines;
  final int? maxLength;
  final InputDecoration? inputDecoration;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool obscureText;

  const CustomTextEditor({
    super.key,
    this.controller,
    this.onChanged,
    this.gradient,
    this.backgroundColor = Colors.white,
    this.hintText,
    this.hintStyle,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(24),
    ),
    this.keyboardType = TextInputType.text,
    this.textStyle,
    this.maxLines = 1,
    this.maxLength,
    this.inputDecoration,
    this.leadingIcon,
    this.trailingIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.r),
      decoration: BoxDecoration(
    color: primaryColor,
        borderRadius: borderRadius,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: leadingIcon!,
              ),
            ],
            Expanded(
              child: TextField(
                obscureText: obscureText,
                controller: controller,
                onChanged: onChanged,
                keyboardType: keyboardType,
                maxLines: maxLines,
                maxLength: maxLength,
                style: textStyle,
                decoration: inputDecoration ??
                    InputDecoration(
                      hintText: hintText,
                      hintStyle: hintStyle ??
                          GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 12.sp,
                            color: blackColor,
                          ),
                      border: InputBorder.none,
                      contentPadding: contentPadding,
                    ),
              ),
            ),
            if (trailingIcon != null) ...[
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: trailingIcon!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
