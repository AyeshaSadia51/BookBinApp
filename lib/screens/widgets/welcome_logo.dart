import 'package:BookBin/utilitis/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 250.h,
      child: Image.asset(
        ImagesPath.welcomeLogo,
        fit: BoxFit.cover,
      ),
    );
  }
}
