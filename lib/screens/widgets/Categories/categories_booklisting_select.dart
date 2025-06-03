import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoriesSelect extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  final List<CategoriesList> _categoriesList = [
    CategoriesList(
      icon: Icons.science_outlined,
      isLiked: true,
      name: "Science",
    ),
    CategoriesList(
      icon: Icons.history_edu_rounded,
      isLiked: false,
      name: "History",
    ),
    CategoriesList(
      icon: Icons.business_center_rounded,
      isLiked: false,
      name: "Business",
    ),
    CategoriesList(
      icon: Icons.health_and_safety,
      isLiked: false,
      name: "Health",
    ),
    CategoriesList(
      icon: Icons.menu_book_sharp,
      isLiked: false,
      name: "Novels",
    ),
    CategoriesList(
      icon: Icons.text_fields_outlined,
      isLiked: false,
      name: "Language",
    ),
    CategoriesList(
      icon: Icons.computer,
      isLiked: false,
      name: "CSE",
    ),
    CategoriesList(
      icon: Icons.school,
      isLiked: false,
      name: "Education",
    ),
  ];

   CategoriesSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 345.w,
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _categoriesList.length,
        itemBuilder: (context, index) {
          final item = _categoriesList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Obx(() {
              return Column(
                children: [
                  Card(
                    color: categoryController.selectedIndex.value == index
                        ? AppMainColor.primaryColor
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                    child: IconButton(
                      onPressed: () {
                        categoryController.updateCategory(item.name, index);
                        if (kDebugMode) {
                          print(item.name);
                        }
                      },
                      icon: Icon(
                        item.icon,
                        size: 33.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}

class CategoriesList {
  late bool isLiked;
  final String name;
  final IconData icon;

  CategoriesList({
    required this.isLiked,
    required this.name,
    required this.icon,
  });
}

class CategoryController extends GetxController {
  var selectedCategory = ''.obs;
  var selectedIndex = 0.obs;

  void updateCategory(String category, int index) {
    selectedCategory.value = category;
    selectedIndex.value = index;
  }
}