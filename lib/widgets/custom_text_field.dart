import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String iconAssetPath;
  final String hintText;
  final bool isMultiLine;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;

  final int? minLines;
  final bool containsIcon;
  final bool isObscure;

  final bool hidePassword;
  final VoidCallback? onTogglePasswordView;

  final bool isEnabled;

  const CustomTextField({
    super.key,
    required this.iconAssetPath,
    required this.hintText,
    this.onChanged,
    this.containsIcon = true,
    this.isMultiLine = false,
    this.textEditingController,
    this.isObscure = false,
    this.hidePassword = true,
    this.minLines = 8,
    this.onTogglePasswordView,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          color: isEnabled ? blackColor : blackColor.withOpacity(0.5)),
      obscureText: isObscure && hidePassword,
      //obscureText: hidePassword,
      keyboardType: isMultiLine ? TextInputType.multiline : TextInputType.text,
      minLines: isMultiLine ? minLines : 1,
      maxLines: isMultiLine ? minLines : 1,
      controller: textEditingController,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: containsIcon
            ? Padding(
                padding: EdgeInsets.all(15.0.r),
                child: Image.asset(
                  iconAssetPath,
                  width: 20.0.w,
                  height: 20.0.h,
                  fit: BoxFit.contain,
                ),
              )
            : null,
        hintText: hintText,
        hintStyle: TextStyle(color: blackColor.withOpacity(0.5)),
        filled: true,
        fillColor: isEnabled ? whiteColor : blackColor.withOpacity(0.7),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: textFieldBordercolor, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: textFieldBordercolor, width: 1.w),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isObscure
            ? GestureDetector(
                onTap: onTogglePasswordView,
                child: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}
