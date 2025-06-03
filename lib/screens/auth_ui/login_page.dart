import 'package:BookBin/screens/auth_ui_controllers/signup_controller.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../other_ui/homepage.dart';
import '../widgets/Buttons/backbutton_with_logo.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import '../widgets/TextFields/password_textfield.dart';
import '../widgets/TextFields/textformfield_customized.dart';
import 'forgotpass_verification_code.dart';
import 'package:BookBin/application//globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            const BackButtonAndLogo(),
            SizedBox(
              height: 96.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 31.w),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 65.h,
            ),
            TextFormFieldCustomized(
              controller: _email,
              hintText: "Enter your email address",
              icon: const Icon(Icons.email),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 40.h,
            ),
            PasswordTextField(
              passwordController: _password,
              hintText: 'Enter your password',
            ),
            SizedBox(
              height: 65.h,
            ),
            Center(
              child: ElevatedButtonCustomised(
                onPressed: login,
                text: "Login",
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.to(const Verification(
                    check: true,
                  ));
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = await _auth.loginUserWithEmailAndPassword(
          _email.text, _password.text);
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final QuerySnapshot result = await firebaseFirestore
          .collection("UserInfo")
          .where("Email", isEqualTo: _email.text)
          .get();
      try {
        if (user != null && result.docs.isNotEmpty) {
          Get.snackbar("Login", "User Logged In Successfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
            final DocumentSnapshot documentSnapshot = result.docs.first;
            final String fullName = documentSnapshot.get("Full_Name");
            globals.userEmail = _email.text;
            globals.userName = fullName;
          await Future.delayed(const Duration(seconds: 2));
            Get.offAll(const HomePage());
          _email.clear();
          _password.clear();
        }
        else {
          Get.snackbar("User not found", "Email or Password are not matched",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar("Error", "Error fetching user info.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
    }
  }
}
