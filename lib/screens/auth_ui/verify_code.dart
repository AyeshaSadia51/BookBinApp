import 'package:BookBin/screens/auth_ui/login_page.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/Buttons/backbutton_with_logo.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import '../widgets/TextFields/textformfield_customized.dart';
import 'package:email_otp/email_otp.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key, required this.email});
  final String email;

  @override
  State<VerificationCode> createState() => _SignupVerificationCodeState();
}

class _SignupVerificationCodeState extends State<VerificationCode> {
  final TextEditingController _otp = TextEditingController();

  @override
  void initState() {
    super.initState();
    sendOTP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: ListView(
          shrinkWrap: true,
          children: [
            const BackButtonAndLogo(),
            SizedBox(height: 42.h),
            Center(
              child: Text(
                "Enter Verification Code",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: 36.h),
            Text(
              "A code that we have sent to your",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF595959),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppMainColor.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            TextFormFieldCustomized(
              controller: _otp,
              hintText: "Enter OTP",
              icon: const Icon(Icons.password),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 23.sp),
            Text(
              "Didn't you receive any code?",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF595959),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: sendOTP,
              child: Text(
                "Resend a new code",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppMainColor.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32.h),
            Center(
              child: ElevatedButtonCustomised(
                onPressed: () {
                  verifyOTP();
                },
                text: "Verify",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifyOTP() async {
    try {
      bool isVerified = EmailOTP.verifyOTP(otp: _otp.text);
      if (isVerified) {
        Get.snackbar(
            "Successful",
            "Your account is created. Now Login in your account",
            colorText: Colors.white,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM
        );
        Get.off(const LoginPage());
      } else {
        Get.snackbar(
            "Failed",
            "Your OTP was not verified. Please try again",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM
        );
      }
    } catch (e) {
      Get.snackbar(
          "Error",
          "An error occurred while verifying OTP: $e",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  void sendOTP() async {
    try {
      bool result = await EmailOTP.sendOTP(email: widget.email);
      if (result) {
        Get.snackbar(
            "Successfully",
            "OTP has been sent",
            colorText: Colors.white,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.BOTTOM
        );
      } else {
        Get.snackbar(
            "Failed, OTP has not been sent.",
            "Please check your email address and try again.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM
        );
      }
    } catch (e) {
      Get.snackbar(
          "Error",
          "An error occurred while sending OTP",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }

}