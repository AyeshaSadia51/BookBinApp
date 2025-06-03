import 'package:BookBin/utilitis/assets_paths.dart';
import 'package:flutter/material.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         SizedBox(
           width: double.infinity,
           height: double.infinity,
           child:  Image.asset(ImagesPath.appBackground,
           fit: BoxFit.cover,
           ),
         ),
          child
        ],
      ),
    );
  }
}
