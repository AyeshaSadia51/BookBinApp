import 'package:BookBin/screens/other_ui/payment_success_screen.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Buttons/backbutton_with_logo.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import '../widgets/Buttons/icon_elevatedbutton.dart';
import '../widgets/Buttons/radio_button.dart';
import '../widgets/TextFields/textformfield_customized.dart';

class BuyBooks extends StatefulWidget {
  const BuyBooks(
      {super.key,
      required this.bookCost,
      required this.name,
      required this.bookPicURL});
  final String bookCost, name, bookPicURL;

  @override
  State<BuyBooks> createState() => _BuyBooksState();
}

class _BuyBooksState extends State<BuyBooks> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _receiverName = TextEditingController();
  final TextEditingController _receivedLocation = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  late double deliveryCharge = 100;
  late double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    late double bookPrice = double.parse(widget.bookCost);
    totalPrice = bookPrice + deliveryCharge;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButtonAndLogo(),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Notice",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "1. Buyers will send the book through Sundarbans \n     Courier Service.\n2. Carefully submit your received location, \n     receiver name and number.\n3. ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff565656),
                      ),
                      children: [
                        TextSpan(
                          text: "Delivery charge 100৳ in Cash on delivery.\n",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.red),
                        ),
                        TextSpan(
                          text:
                              "4. This time only cash on delivery available.\n5. Delivery time from today to next 7 days.",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff565656),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: TextFormFieldCustomized(
                    controller: _receiverName,
                    hintText: "Enter receiver name",
                    icon: const Icon(Icons.person),
                    keyboardType: TextInputType.text,
                    validator: (receiverName) {
                      if (receiverName == null || receiverName.isEmpty) {
                        return "Please enter name";
                      }
                      if (receiverName.length < 3) {
                        return "Name must be at least 3 characters long";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: TextFormFieldCustomized(
                    controller: _phone,
                    hintText: "Enter your phone number",
                    icon: const Icon(Icons.phone),
                    keyboardType: TextInputType.number,
                    validator: (phone) {
                      if (phone == null || phone.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (phone.length != 11) {
                        return 'Phone number must be 11 digits long';
                      }
                      final numValue = int.tryParse(phone);
                      if (numValue == null) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: TextFormFieldCustomized(
                    controller: _receivedLocation,
                    hintText: "Enter your received Location",
                    icon: const Icon(Icons.location_on),
                    keyboardType: TextInputType.text,
                    validator: (receivedLocation) {
                      if (receivedLocation == null ||
                          receivedLocation.isEmpty) {
                        return "Please enter the received location";
                      }
                      if (receivedLocation.length < 10) {
                        return "Location must be at least 10 characters long";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Text(
                    "Choose your payment option",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                        color: AppMainColor.primaryColor),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.w),
                  child: RadioButton(
                    nameOption1: 'Cash on delivery',
                    nameOption2: 'Bkash',
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 170.w),
                  child: Column(
                    children: [
                      Text(
                        "Book         :  ${widget.bookCost}  ৳",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff595959),
                        ),
                      ),
                      Text(
                        "Charge      :  $deliveryCharge  ৳",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff595959),
                        ),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: Divider(
                          thickness: 2.h,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Total        :  ${totalPrice.toString()}  ৳",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: IconElevatedButton(
                    text: "Proceed",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final formController = Get.find<FormController>();
                        FirebaseFirestore firebase = FirebaseFirestore.instance;
                        try {
                          await firebase.collection('BuyerInfo').add({
                            "receiverName": _receiverName.text,
                            "receivedLocation": _receivedLocation.text,
                            "phone": _phone.text,
                            "totalPrice": totalPrice.toString(),
                            "bookPicURL": widget.bookPicURL,
                            "bookName": widget.name,
                            'timestamp': FieldValue
                                .serverTimestamp(), // This adds the current timestamp
                          });

                          formController.setLoading(false);
                          Get.snackbar(
                            "Successful",
                            "Your order has been confirmed, within a week you will receive your delivery",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 4),
                          );

                          Get.off(const PaymentSuccessScreen());

                          _receiverName.clear();
                          _phone.clear();
                          _receivedLocation.clear();
                        } catch (e) {
                          formController.setLoading(false);
                          Get.snackbar(
                            "Error",
                            "Failed to confirm your order. Please try again.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 4),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(
        activeIndex: 0,
      ),
    );
  }
}
