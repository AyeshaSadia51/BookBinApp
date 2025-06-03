import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookListingTextFormField extends StatelessWidget {
  const BookListingTextFormField(
      {super.key,
      required this.keyboardType,
      required this.heading,
      required this.controller,
      this.validator});
  final TextInputType keyboardType;
  final String heading;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, bottom: 11.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 16.w,
          ),
          SizedBox(
            width: 182.w,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
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
                  borderRadius: BorderRadius.circular(15.w),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.w),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    )),
                errorStyle: TextStyle(fontSize: 14.sp),
                errorMaxLines: 2,
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
