import 'package:BookBin/screens/widgets/wishlist.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar bookListAppBar(scaffoldKey, BuildContext context, bool wishList) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lister name",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: AppMainColor.primaryColor,
              size: 14.sp,
            ),
            SingleChildScrollView(
              child: Text(
                "Sylhet Sadar, Sylhet, Bangladesh",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppMainColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    leading: IconButton(
      icon: Icon(
        Icons.person_pin,
        size: 40.sp,
        color: const Color(0xff8847A1),
      ),
      onPressed: () {
        scaffoldKey.currentState!.openDrawer();
      },
    ),
    actions: [
      wishList == true
          ? IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 32.sp,
              ),
              onPressed: () {
                bottomSheetWishlist(context);
              },
            )
          : const SizedBox(),
      IconButton(
        icon: Icon(
          Icons.notifications,
          color: const Color(0xff8847A1),
          size: 32.sp,
        ),
        onPressed: () {
          scaffoldKey.currentState!.openEndDrawer();
        },
      ),
    ],
  );
}
