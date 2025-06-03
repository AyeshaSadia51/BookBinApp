import 'package:BookBin/screens/other_ui/book_listing.dart';
import 'package:BookBin/screens/other_ui/see_all_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../other_ui_controllers/homepage_controller.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/main_appbar.dart';
import '../widgets/Buttons/icon_elevatedbutton.dart';
import '../widgets/Categories/categories.dart';
import '../widgets/Categories/categories_booklisting_select.dart';
import '../widgets/notification_end_drawer.dart';
import '../widgets/recommended_book_card.dart';
import '../widgets/screen_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  CollectionReference business =
      FirebaseFirestore.instance.collection('Business');
  CollectionReference novels = FirebaseFirestore.instance.collection('Novels');
  CollectionReference health = FirebaseFirestore.instance.collection('Health');
  CollectionReference language =
      FirebaseFirestore.instance.collection('Language');

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: mainAppBar(scaffoldKey, context),
      key: scaffoldKey,
      endDrawer: const NotificationEndDrawer(),
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 32.w, right: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: GetBuilder<HomeController>(
                      builder: (controller) {
                        final greeting = controller.greeting.value;
                        return Text(
                          'Hey, $greeting!',
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 296.w,
                        height: 48.h,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search Textbooks",
                            suffixIcon: Icon(
                              Icons.search,
                              size: 25.w,
                              color: const Color(0xff8847a1),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 20.sp,
                              color: const Color(0xff6B6B6B),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                50.w,
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xff8847a1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15.w,
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xff8847a1),
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0XFFFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.w),
                        ),
                        color: const Color(0xff8847a1),
                        child: IconButton(
                            onPressed: () {
                              //scaffoldKey.currentState?.openEndDrawer();
                              _bottomsheetfilter(context);
                            },
                            icon: Icon(
                              Icons.filter_alt_rounded,
                              color: Colors.white,
                              size: 30.w,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  const Categories(),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Recommended",
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          //Get.to(RecommendedBookCardCreate(height: 265.h, collections: [business,novels,health,language],),);
                          Get.to(SeeAllPageRecommendedPage(
                            collections: [business, novels, health, language],
                            name: 'Recommended',
                          ));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff6B6B6B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  // BookCardCreate(
                  //   height: 265.h,
                  //   collection: "Business",
                  // ),
                  RecommendedBookCardCreate(
                    height: 265.h,
                    itemCount: 6,
                    collections: [business, novels, health, language],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const BookListing());
                    },
                    child: Center(
                      child: Stack(children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: SizedBox(
                            height: 55.h,
                            width: 211.w,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              color: const Color(0xff8847a1),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Center(
                                  child: Text(
                                    "List my books",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.add_circle_rounded,
                          color: Colors.white,
                          size: 55.w,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(
        activeIndex: 0,
      ),
    );
  }
}

void _bottomsheetfilter(BuildContext context) {
  RangeValues values = const RangeValues(50, 1000);
  String minPrice = "50", maxPrice = "1000";
  bool isLiked1 = false;
  bool isLiked2 = false;
  bool isLiked3 = false;
  bool isLiked4 = false;
  bool isLiked5 = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent.withOpacity(0.8),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 430.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.w)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: SizedBox(
                    width: 323.w,
                    height: 90.h,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 9.w),
                            child: Row(
                              children: [
                                Text(
                                  "Price Range",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "$minPrice - $maxPrice ৳",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                          RangeSlider(
                            min: 50,
                            max: 1000,
                            values: values,
                            onChanged: (newValues) {
                              setState(() {
                                values = newValues;
                                minPrice = newValues.start.toStringAsFixed(0);
                                maxPrice = newValues.end.toStringAsFixed(0);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                 Center(
                  child: CategoriesSelect(),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: SizedBox(
                    width: 323.w,
                    height: 70.h,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, top: 9.w),
                            child: Text(
                              "Rating",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildRatingCard(1, isLiked1, setState),
                              buildRatingCard(2, isLiked2, setState),
                              buildRatingCard(3, isLiked3, setState),
                              buildRatingCard(4, isLiked4, setState),
                              buildRatingCard(5, isLiked5, setState),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: IconElevatedButton(
                    text: "Apply",
                    onPressed: () {
                      //Get.to(const BuyBooks());
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget buildRatingCard(int rating, bool isLiked, Function setState) {
  return SizedBox(
    width: 50.w,
    height: 30.h,
    child: GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
      child: Card(
        color: isLiked ? const Color(0xff8847a1) : Colors.grey,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$rating",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.star,
              size: 14.w,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}




