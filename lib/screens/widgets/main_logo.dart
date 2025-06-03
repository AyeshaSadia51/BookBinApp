import 'package:BookBin/utilitis/assets_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Image.asset(
        ImagesPath.mainLogo,
        fit: BoxFit.cover,
      ),
    );
  }
}
