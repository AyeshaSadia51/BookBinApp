import 'package:BookBin/screens/auth_ui/login_page.dart';
import 'package:BookBin/screens/auth_ui/verify_code.dart';
import 'package:BookBin/screens/widgets/Buttons/backbutton_with_logo.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/Buttons/elevatedbutton_customised.dart';
import '../widgets/TextFields/textformfield_customized.dart';

class Verification extends StatefulWidget {
  const Verification({super.key, this.check});
  final bool? check;

  @override
  State<Verification> createState() => _SignupState();
}

class _SignupState extends State<Verification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButtonAndLogo(),
              SizedBox(
                height: 42.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 31.w),
                child: Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 31.w),
                child: Text(
                  "Enter your created account email address",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF595959),
                  ),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              TextFormFieldCustomized(
                  controller: _email,
                  hintText: "Enter your email address",
                  icon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress),
              SizedBox(
                height: 80.h,
              ),
              Center(
                child: ElevatedButtonCustomised(
                  onPressed: () {
                    emailCheck();
                  },
                  text: "Send",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  emailCheck()  async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    final QuerySnapshot result = await firebase
        .collection('UserInfo')
        .where('Email', isEqualTo: _email.text)
        .get();
    if (result.docs.isNotEmpty) {
      if(widget.check == true){
        auth.sendPasswordResetEmail(email: _email.text).then((value) async {
          Get.snackbar("Account Found", "A reset link was send into your email",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          await Future.delayed(const Duration(seconds: 2));
          Get.to(const LoginPage());
        });
      }
      else{
        Get.snackbar("Found", "This email has account",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await Future.delayed(const Duration(seconds: 2));
        Get.to(VerificationCode(email: _email.text));
      }
    } else {
      Get.snackbar("Not Found", "This email has no account",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
