import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ElevatedButtonCustomised extends StatelessWidget {
  ElevatedButtonCustomised(
      {super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;
  final formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: 350.w,
        height: 60.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.w),
            ),
          ),
          onPressed: formController.isLoading.value
              ? null
              : () {
                  formController.setLoading(true);
                  onPressed();
                  Timer(const Duration(seconds: 1), () {
                    formController.setLoading(false);
                  });
                },
          child: formController.isLoading.value
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800),
                ),
        ),
      );
    });
  }
}

class FormController extends GetxController {
  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }
}
