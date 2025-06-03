import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/payment_done_gif.dart';
class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreen();
}

class _PaymentSuccessScreen extends State<PaymentSuccessScreen> {

  @override
  void initState() {
    goToNextScreen();
    super.initState();
  }

  void goToNextScreen() {
    Future.delayed(const Duration(seconds: 4)).then(
          (value) => Get.offAll(
            () => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
        body:  PaymentDoneGif()
    );
  }
}
