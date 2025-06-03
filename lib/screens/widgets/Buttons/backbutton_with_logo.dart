import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utilitis/assets_paths.dart';

class BackButtonAndLogo extends StatelessWidget {
  const BackButtonAndLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon:  Icon(
              Icons.arrow_circle_left,
              color: const Color(0XFF8847A1),
              size: 36.sp,
            ),),
          Image.asset(ImagesPath.mainLogo)
        ],
      ),
    );
  }
}
