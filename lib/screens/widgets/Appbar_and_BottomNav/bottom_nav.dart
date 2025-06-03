import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:BookBin/screens/other_ui/inbox_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../welcome_screen.dart';
import '../wishlist.dart';

class BottomNav extends StatefulWidget {
  final int activeIndex;
  const BottomNav({super.key, required this.activeIndex});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // Function to handle item tapping and updating the state
  void _onItemTapped(int index) {
    if (index == 2) {
      // Wishlist is a bottom sheet, not a page navigation
      bottomSheetWishlist(context);
    } else {
      setState(() {
        Get.offAll(() => _getPageForIndex(index));
      });
    }
  }

  // Get page based on index
  Widget _getPageForIndex(int index) {
    if (index == 0) return const HomePage();
    if (index == 1) return const InboxList();
    return const HomePage(); // Default to HomePage
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72.h,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 10.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home Icon
                GestureDetector(
                  onTap: () => _onItemTapped(0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.home,
                        size: 30.w,
                        color: widget.activeIndex == 0
                            ? const Color(0xff8847A1) // Purple when active
                            : Colors.grey, // Grey when inactive
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: widget.activeIndex == 0
                              ? const Color(0xff8847A1)
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Inbox Icon
                GestureDetector(
                  onTap: () => _onItemTapped(1),
                  child: Column(
                    children: [
                      Icon(
                        Icons.email,
                        size: 30.w,
                        color: widget.activeIndex == 1
                            ? const Color(0xff8847A1) // Purple when active
                            : Colors.grey, // Grey when inactive
                      ),
                      Text(
                        "Inbox",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: widget.activeIndex == 1
                              ? const Color(0xff8847A1)
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Wishlist Icon (opens bottom sheet)
                GestureDetector(
                  onTap: () => _onItemTapped(2),
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 30.w,
                        color: widget.activeIndex == 2
                            ? const Color(0xff8847A1) // Purple when active
                            : Colors.grey, // Grey when inactive
                      ),
                      Text(
                        "Wishlist",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: widget.activeIndex == 2
                              ? const Color(0xff8847A1)
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
