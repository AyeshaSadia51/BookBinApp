import 'package:BookBin/utilitis/assets_paths.dart';
import 'package:flutter/material.dart';

class PaymentDoneGif extends StatelessWidget {
  const PaymentDoneGif({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        ImagesPath.paymentDoneGif,
        fit: BoxFit.cover,
      ),
    );
  }
}
