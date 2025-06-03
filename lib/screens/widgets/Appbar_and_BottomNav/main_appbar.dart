import 'package:BookBin/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:BookBin/application//globals.dart' as globals;

AppBar mainAppBar(GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: ListTile(
      title: Text(
        globals.userName,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        globals.userEmail,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xff8847A1),
        ),
      ),
    ),
    leading: IconButton(
      icon: Icon(
        Icons.person_pin,
        size: 40.w,
        color: const Color(0xff8847A1),
      ),
      onPressed: () {
        scaffoldKey.currentState!.openDrawer();
      },
    ),
    actions: [
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
      IconButton(
        icon: Icon(
          Icons.logout,
          color: Colors.red,
          size: 32.sp,
        ),
        onPressed: () {
          Get.to(const WelcomePage());
        },
      ),
    ],
  );
}
