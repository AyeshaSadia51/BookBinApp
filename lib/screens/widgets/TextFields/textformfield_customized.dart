import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utilitis/app_main_color.dart';

class TextFormFieldCustomized extends StatelessWidget {
  const TextFormFieldCustomized({super.key, required this.hintText, required this.icon, required this.keyboardType, required this.controller,  this.validator});
  final String hintText;
  final Widget icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350.w,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon,
            hintStyle:  TextStyle(
              fontSize: 20.sp,
              color: const Color(0xff6B6B6B),
            ),
            contentPadding:  EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15.w,
              ),
              borderSide: BorderSide(
                color: AppMainColor.primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15.w,
              ),
              borderSide: BorderSide(
                color: AppMainColor.primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15.w,
              ),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                15.w,
              ),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            errorStyle: TextStyle(fontSize: 14.sp),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
