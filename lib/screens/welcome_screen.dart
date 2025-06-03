import 'package:BookBin/screens/auth_ui/login_page.dart';
import 'package:BookBin/screens/auth_ui/signup.dart';
import 'package:BookBin/utilitis/assets_paths.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 143.h,
                ),
                Image.asset(ImagesPath.welcomeLogo),
                SizedBox(
                  height: 39.h,
                ),
                Text(
                  "Welcome to\nBookBin",
                  style: TextStyle(
                    fontSize: 46.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 39.h,
                ),
                Text(
                  "We will help you to buy textbooks at\ncheaper rate and earn money by selling\nused text books at reasonable price.",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF595959),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 36.h,
                ),
                SizedBox(
                  height: 60.h,
                  width: 378.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        const Signup(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.w),
                    )),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: const Color(0xFF626262),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const LoginPage());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: const Color(0xFFA158AD),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
