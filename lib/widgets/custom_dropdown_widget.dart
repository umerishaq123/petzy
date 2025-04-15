
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app/utils/colors.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final List<String> valueList;
  final String hintText;
  final Widget? leadingIcon;
  final EdgeInsets contentPadding;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final TextStyle? hintStyle;

  const CustomDropdownWidget({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.valueList,
    this.hintText = 'Gender',
    this.leadingIcon,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(24),
    ),
    this.backgroundColor = Colors.white,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.r),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: borderRadius,
              border: Border.all(color: textFieldBordercolor, width: 1), 
        
      
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
            child: DropdownButton<String>(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              icon: Icon(Icons.keyboard_arrow_down_rounded, size: 30.sp, color: Colors.grey,),
              value: selectedValue,
              onChanged: onChanged,
              hint: Text(
                hintText,
                style: hintStyle ?? GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp,
                  color:blackColor,
                ),
              ),
              isExpanded: true,
              underline: Container(),
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: blackColor,
              ),
              items: valueList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
