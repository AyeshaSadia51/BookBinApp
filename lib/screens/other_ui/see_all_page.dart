import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Appbar_and_BottomNav/main_appbar.dart';
import '../widgets/notification_end_drawer.dart';
import '../widgets/recommended_book_card.dart';
import '../widgets/screen_background.dart';

class SeeAllPageRecommendedPage extends StatefulWidget {
  const SeeAllPageRecommendedPage(
      {super.key, required this.collections, required this.name});
  final List<CollectionReference>? collections;
  final String? name;

  @override
  State<SeeAllPageRecommendedPage> createState() =>
      _SeeAllPageAndCategoriesPageState();
}

class _SeeAllPageAndCategoriesPageState
    extends State<SeeAllPageRecommendedPage> {
  RangeValues values = const RangeValues(50, 1000);
  String minPrice = "50", maxPrice = "1000";
  bool isLiked1 = false;
  bool isLiked2 = false;
  bool isLiked3 = false;
  bool isLiked4 = false;
  bool isLiked5 = false;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
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
                    height: 8.h,
                  ),
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
                                    minPrice =
                                        newValues.start.toStringAsFixed(0);
                                    maxPrice = newValues.end.toStringAsFixed(0);
                                  });
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
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
                                SizedBox(
                                  width: 50.w,
                                  height: 30.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLiked1 = !isLiked1;
                                      });
                                    },
                                    child: Card(
                                      color: isLiked1
                                          ? const Color(0xff8847a1)
                                          : Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20.w),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "1",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
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
                                ),
                                SizedBox(
                                  width: 50.w,
                                  height: 30.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLiked2 = !isLiked2;
                                      });
                                    },
                                    child: Card(
                                      color: isLiked2
                                          ? const Color(0xff8847a1)
                                          : Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20.w),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "2",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
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
                                ),
                                SizedBox(
                                  width: 50.w,
                                  height: 30.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLiked3 = !isLiked3;
                                      });
                                    },
                                    child: Card(
                                      color: isLiked3
                                          ? const Color(0xff8847a1)
                                          : Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20.w),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "3",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
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
                                ),
                                SizedBox(
                                  width: 50.w,
                                  height: 30.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLiked4 = !isLiked4;
                                      });
                                    },
                                    child: Card(
                                      color: isLiked4
                                          ? const Color(0xff8847a1)
                                          : Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20.w),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "4",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
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
                                ),
                                SizedBox(
                                  width: 50.w,
                                  height: 30.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLiked5 = !isLiked5;
                                      });
                                    },
                                    child: Card(
                                      color: isLiked5
                                          ? const Color(0xff8847a1)
                                          : Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20.w),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "5",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      "Recommended",
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  RecommendedBookCardCreate(
                      height: 535.h, collections: widget.collections!),
                  SizedBox(
                    height: 16.h,
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
