import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:BookBin/screens/widgets/TextFields/book_details_textform.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/Buttons/elevatedbutton_customised.dart';
import '../widgets/Buttons/icon_elevatedbutton.dart';
import '../widgets/Buttons/radio_button.dart';
import '../widgets/Categories/categories_booklisting_select.dart';
import '../widgets/TextFields/textformfield_customized.dart';

class BookListing extends StatefulWidget {
  const BookListing({super.key});

  @override
  State<BookListing> createState() => _BookListingState();
}

class _BookListingState extends State<BookListing> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bookName = TextEditingController();
  final TextEditingController _bookUrl = TextEditingController();
  final TextEditingController _swapLocation = TextEditingController();
  final TextEditingController _writerName = TextEditingController();
  final TextEditingController _publisherName = TextEditingController();
  final TextEditingController _edition = TextEditingController();
  final TextEditingController _releaseDate = TextEditingController();
  final TextEditingController _language = TextEditingController();
  final TextEditingController _isbn10 = TextEditingController();
  final TextEditingController _isbn13 = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final CategoryController categoryController = Get.put(CategoryController());
  final RadioButtonController radioButtonController =
      Get.put(RadioButtonController());
  final FormController formController = Get.put(FormController());

  @override
  void dispose() {
    _bookName.dispose();
    _bookUrl.dispose();
    _swapLocation.dispose();
    _writerName.dispose();
    _publisherName.dispose();
    _edition.dispose();
    _releaseDate.dispose();
    _language.dispose();
    _isbn10.dispose();
    _isbn13.dispose();
    _stock.dispose();
    _price.dispose();
    super.dispose();
  }

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Sell and Swap Your \nBooks",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  TextFormFieldCustomized(
                    controller: _bookName,
                    keyboardType: TextInputType.text,
                    hintText: "Enter your Book name",
                    icon: const Icon(Icons.menu_book_rounded),
                    validator: (bookName) =>
                        bookName!.length < 3 ? "Please write book name" : null,
                  ),
                  SizedBox(height: 30.h),
                  BookListingTextFormField(
                    controller: _writerName,
                    keyboardType: TextInputType.text,
                    heading: "Writer Name       :",
                    validator: (writerName) =>
                        writerName!.length < 3 ? "Please fill this" : null,
                  ),
                  BookListingTextFormField(
                    controller: _publisherName,
                    keyboardType: TextInputType.text,
                    heading: "Publisher Name :",
                    validator: (publisherName) =>
                        publisherName!.length < 3 ? "Please fill this" : null,
                  ),
                  BookListingTextFormField(
                    controller: _edition,
                    keyboardType: TextInputType.text,
                    heading: "Edition                 :",
                    validator: (edition) =>
                        edition!.length < 3 ? "Please fill this" : null,
                  ),
                  BookListingTextFormField(
                    controller: _releaseDate,
                    keyboardType: TextInputType.number,
                    heading: "Release Date      :",
                    validator: (releaseDate) =>
                        releaseDate!.length < 3 ? "Please fill this" : null,
                  ),
                  BookListingTextFormField(
                    controller: _language,
                    keyboardType: TextInputType.text,
                    heading: "Language            :",
                    validator: (language) =>
                        language!.length < 3 ? "Please fill this" : null,
                  ),
                  BookListingTextFormField(
                    controller: _isbn10,
                    keyboardType: TextInputType.number,
                    heading: "ISBN-10               :",
                    validator: (isbn10) {
                      if (isbn10 == null || isbn10.isEmpty) {
                        return "Please fill this";
                      }
                      if (isbn10.length != 10) {
                        return "Please enter a 10-digit ISBN Number";
                      }
                      final numValue = int.tryParse(isbn10);
                      if (numValue == null) {
                        return "Please enter a valid number";
                      }
                      return null;
                    },
                  ),
                  BookListingTextFormField(
                    controller: _isbn13,
                    keyboardType: TextInputType.number,
                    heading: "ISBN-13               :",
                    validator: (isbn13) {
                      if (isbn13 == null || isbn13.isEmpty) {
                        return "Please fill this";
                      }
                      if (isbn13.length != 13) {
                        return "Please enter a 13-digit ISBN Number";
                      }
                      final numValue = int.tryParse(isbn13);
                      if (numValue == null) {
                        return "Please enter a valid number";
                      }
                      return null;
                    },
                  ),
                  BookListingTextFormField(
                    controller: _stock,
                    keyboardType: TextInputType.text,
                    heading: "Stock                   :",
                    validator: (stock) => stock != "Yes" && stock != "No"
                        ? "Type only Yes / No"
                        : null,
                  ),
                  BookListingTextFormField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    heading: "Price                    :",
                    validator: (price) {
                      if (price == null || price.isEmpty) {
                        return "Please fill this";
                      }
                      final numValue = num.tryParse(price);
                      if (numValue == null) {
                        return "Please enter a valid number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Select Category",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CategoriesSelect(),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                      width: 345.w,
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: _description,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            hintText: "Enter minimum 100 words description.",
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(
                              fontSize: 18.sp,
                              color: const Color(0xff6B6B6B),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.w),
                              borderSide: BorderSide(
                                color: AppMainColor.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.w),
                              borderSide: BorderSide(
                                color: AppMainColor.primaryColor,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.w),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.w),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            errorStyle: TextStyle(fontSize: 14.sp)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your book description';
                          }
                          int wordCount = value
                              .split(' ')
                              .where((word) => word.isNotEmpty)
                              .length;
                          if (wordCount < 100) {
                            return 'Minimum 100 words required.';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                    height: 36.h,
                  ),
                  Text(
                    "Upload Images",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 20.h),
                  TextFormFieldCustomized(
                    controller: _bookUrl,
                    keyboardType: TextInputType.text,
                    hintText: "Enter your Book Image Url",
                    icon: const Icon(Icons.add_link),
                    validator: (url) {
                      if (url == null || url.isEmpty) {
                        return "Please fill this";
                      }
                      const urlPattern = r'^(https?:\/\/)?' // Optional scheme
                          r'((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|' // Domain
                          r'((\d{1,3}\.){3}\d{1,3}))' // OR ip (v4) address
                          r'(\:\d+)?(\/[-a-z\d%_.~+]*)*' // Port and path
                          r'(\?[;&a-z\d%_.~+=-]*)?' // Query string
                          r'(\#[-a-z\d_]*)?$'; // Fragment locator
                      final urlRegExp =
                          RegExp(urlPattern, caseSensitive: false);
                      if (!urlRegExp.hasMatch(url)) {
                        return "Please enter a valid image URL";
                      }
                      return null;
                    },
                  ),
                  // SizedBox(
                  //   height: 16.h,
                  // ),
                  // SizedBox(
                  //   width: 80,
                  //   height: 80,
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.add_photo_alternate_rounded,
                  //       size: 80.w,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 36.h,
                  ),
                  Text(
                    "Do you want to swap your books?",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RadioButton(
                    nameOption1: 'Yes',
                    nameOption2: 'No',
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  TextFormFieldCustomized(
                    controller: _swapLocation,
                    hintText: "Enter Location for swap books",
                    icon: const Icon(Icons.location_on),
                    keyboardType: TextInputType.text,
                    validator: (swapLocation) =>
                        swapLocation!.length < 10 ? "Please fill this" : null,
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  IconElevatedButton(
                    text: "Submit",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final formController = Get.find<FormController>();
                        FirebaseFirestore firebase = FirebaseFirestore.instance;
                        String selectedOption =
                            radioButtonController.selectedOption.value == 'Yes'
                                ? 'Yes'
                                : 'No';
                        try {
                          await firebase
                              .collection(
                                  categoryController.selectedCategory.value)
                              .add({
                            "Sell": "Yes",
                            "Swap": selectedOption,
                            "bookName": _bookName.text,
                            "bookPicURL": _bookUrl.text,
                            "bookPrice": _price.text,
                            "bookRating": 5.0,
                            "description": _description.text,
                            "edition": _edition.text,
                            "isLikedList": false,
                            "isbn_10": _isbn10.text,
                            "isbn_13": _isbn13.text,
                            "language": _language.text,
                            "listerName": "listerName",
                            "publisherName": _publisherName.text,
                            "releaseDate": _releaseDate.text,
                            "stock": _stock.text,
                            "swapLocation": _swapLocation.text,
                            "writerName": _writerName.text
                          });
                          formController.setLoading(false);
                          Get.to(const HomePage());
                          _bookName.clear();
                          _bookUrl.clear();
                          _swapLocation.clear();
                          _writerName.clear();
                          _publisherName.clear();
                          _edition.clear();
                          _releaseDate.clear();
                          _language.clear();
                          _isbn10.clear();
                          _isbn13.clear();
                          _stock.clear();
                          _price.clear();
                          Get.showSnackbar(const GetSnackBar(
                              title: "Successfully Added data",
                              message: "Now your book is online",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 4)));
                        } catch (error) {
                          formController.setLoading(false);
                          Get.showSnackbar(const GetSnackBar(
                              title: "Failed to add data",
                              message: "Please try again",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 4)));
                        }
                      }
                    },
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
      bottomNavigationBar: const BottomNav(
        activeIndex: 0,
      ),
    );
  }
}
