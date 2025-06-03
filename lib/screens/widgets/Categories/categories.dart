import 'package:BookBin/screens/widgets/Categories/category_page1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'category_page2.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100.h,
          child: PageView(
            controller: _pageController,
            children: const [
              CategoryPage1(),
              CategoryPage2(),
            ],
          ),
        ),
        SmoothPageIndicator(
            controller: _pageController,  // PageController
            count:  2,
            effect:  const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Color(0xff8847a1)
            ),
        )
      ],
    );
  }
}
