import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'elevatedbutton_customised.dart';
class IconElevatedButton extends StatelessWidget {
  const IconElevatedButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButtonCustomised(
            onPressed: onPressed,
            text: text),
        Positioned(
            right: 0,
            child: Icon(
              Icons.arrow_circle_right_rounded,
              size: 60.w,
              color: Colors.white,
            ))
      ],
    );
  }
}
