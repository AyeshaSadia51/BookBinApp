import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:BookBin/screens/welcome_screen.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/screens/widgets/welcome_logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:BookBin/application//globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  void goToNextScreen() async {
    User? user = auth.currentUser;
    await Future.delayed(const Duration(seconds: 2));

    if (user != null) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final QuerySnapshot result = await firebaseFirestore
          .collection("UserInfo")
          .where("Email", isEqualTo: user.email)
          .get();
      if (result.docs.isNotEmpty) {
        final DocumentSnapshot documentSnapshot = result.docs.first;
        final String fullName = documentSnapshot.get("Full_Name");
        globals.userName = fullName;
        globals.userEmail = user.email!;

        Get.offAll(() => const HomePage());
      }
    } else {
      Get.offAll(() => const WelcomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: Column(
        children: [
          SizedBox(
            height: 300.h,
          ),
          const Center(child: WelcomeLogo()),
          const Spacer(),
          const CircularProgressIndicator(
            color: Color(0xFF8847A1),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Version 1.0",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
        ],
      ),
    ));
  }
}
