import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pet_app/utils/colors.dart';

enum FieldType { email, txt, password }

class InputField extends StatelessWidget {
  final String hintText;
  final FieldType fieldType;
  final Function()? showPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? obscureText;
  final bool readOnly;
  final Color? textColor;
  final int? maxLine;
  final String? Function(String?)? validator;
  final FontWeight? fontWeight;

  const InputField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.fieldType,
    this.showPassword,
    this.obscureText,
    this.textColor,
    this.fontWeight,
    required this.readOnly,
    this.maxLine = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    var emailCompleted = (controller.text).toString().obs;
    if (fieldType == FieldType.email) {
      controller.addListener(() {
        emailCompleted.value = controller.text.toString();
      });
    }
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: fontWeight ?? FontWeight.w600,
            color: textColor ?? Colors.black,
          ),
      keyboardType: keyboardType,
      readOnly: readOnly,
      maxLines: maxLine,
      validator: validator,
      textInputAction:
          (fieldType == FieldType.txt || fieldType == FieldType.email)
              ? TextInputAction.next
              : TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: whiteColor,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: blackColor,
            ),
       
          
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
