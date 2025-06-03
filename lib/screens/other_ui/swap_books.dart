import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utilitis/app_main_color.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import '../widgets/Buttons/icon_elevatedbutton.dart';
import '../widgets/TextFields/book_details_textform.dart';
import 'package:BookBin/application//globals.dart' as globals;

class SwapBooks extends StatefulWidget {
  const SwapBooks(
      {super.key, required this.bookName, required this.bookPicURL});
  final String bookName, bookPicURL;

  @override
  State<SwapBooks> createState() => _SwapBooksState();
}

class _SwapBooksState extends State<SwapBooks> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _swapperName = TextEditingController();
  final TextEditingController _swapperPhone = TextEditingController();
  final TextEditingController _swapBookName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_circle_left_rounded,
              size: 45.w,
              color: AppMainColor.primaryColor,
            ),
          )),
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Swap Book Request",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.w),
                                child: Image.network(
                                  widget.bookPicURL,
                                  width: 160.w,
                                  height: 210.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 270,
                            height: 130,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0,
                            ), // Space around the message
                            padding: const EdgeInsets.all(12.0),

                            decoration: BoxDecoration(
                              color: AppMainColor.primaryColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                globals.userName != null
                                    ? "Hi ${globals.userName}.. \nPlease provide the following information. We will contact you ASAP."
                                    : "Hi there.. \nPlease provide the following information. We will contact you ASAP.", // Fallback if userName is null
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  BookListingTextFormField(
                    controller: _swapperName,
                    keyboardType: TextInputType.text,
                    heading: "Your Name            :",
                    validator: (swapperName) {
                      if (swapperName == null || swapperName.isEmpty) {
                        return "Please enter name";
                      }
                      if (swapperName.length < 3) {
                        return "Name must be at least 3 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  BookListingTextFormField(
                    controller: _swapperPhone,
                    keyboardType: TextInputType.number,
                    heading: "Phone Number     :",
                    validator: (swapperPhone) {
                      if (swapperPhone == null || swapperPhone.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (swapperPhone.length != 11) {
                        return 'Phone number must be 11 digits long';
                      }
                      final numValue = int.tryParse(swapperPhone);
                      if (numValue == null) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  BookListingTextFormField(
                    controller: _swapBookName,
                    keyboardType: TextInputType.text,
                    heading: "Swappable Book :",
                    validator: (swapBookName) => swapBookName!.length < 5
                        ? "Please write full book name"
                        : null,
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: IconElevatedButton(
                        text: "Swap Request",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final formController = Get.find<FormController>();
                            FirebaseFirestore firebase =
                                FirebaseFirestore.instance;
                            try {
                              await firebase.collection('SwapperInfo').add({
                                "swapperName": _swapperName.text,
                                "swapperPhone": _swapperPhone.text,
                                "swapBookName": _swapBookName.text,
                                "bookName": widget.bookName,
                                "bookPicURL": widget.bookPicURL,
                                'timestamp': FieldValue.serverTimestamp(),
                              });

                              formController.setLoading(false);
                              Get.snackbar(
                                "Success",
                                "Your swap request has been submitted",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 4),
                              );

                              Get.off(const HomePage());

                              _swapperName.clear();
                              _swapperPhone.clear();
                              _swapBookName.clear();
                            } catch (e) {
                              formController.setLoading(false);
                              Get.snackbar(
                                "Error",
                                "Failed to submit the swap request. Please try again.",
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
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
