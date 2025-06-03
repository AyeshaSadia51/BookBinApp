import 'package:BookBin/screens/other_ui/buy_books.dart';
import 'package:BookBin/screens/other_ui/swap_books.dart';
import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/Appbar_and_BottomNav/booklist_appbar.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart';
import '../widgets/notification_end_drawer.dart';
import '../widgets/screen_background.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen(
      {super.key,
      required this.sell,
      required this.swap,
      required this.bookPicURL,
      required this.description,
      required this.edition,
      required this.isbn_10,
      required this.isbn_13,
      required this.language,
      required this.publisherName,
      required this.releaseDate,
      required this.stock,
      required this.writerName,
      required this.bookPrice,
      required this.bookRating,
      required this.bookName,
      required this.bookCategory,
      required this.wishlist});
  final String sell;
  final String swap;
  final String bookName;
  final String bookCategory;
  final String bookPicURL;
  final String description;
  final String edition;
  final String isbn_10;
  final String isbn_13;
  final String language;
  final String publisherName;
  final String releaseDate;
  final String stock;
  final String writerName;
  final String bookPrice;
  final double bookRating;
  final bool wishlist;
  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreen();
}

class _BookDetailsScreen extends State<BookDetailsScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: bookListAppBar(scaffoldKey, context, widget.wishlist),
      endDrawer: const NotificationEndDrawer(),
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 100.w,
                    child: Card(
                      color: AppMainColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.w),
                          bottomRight: Radius.circular(15.w),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "৳ ${widget.bookPrice}",
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Center(
                      child: ImageSliders(
                    bookPicURL: widget.bookPicURL,
                  )),
                  SizedBox(
                    height: 50.h,
                    width: 100.w,
                    child: Card(
                      color: AppMainColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.w),
                          bottomLeft: Radius.circular(15.w),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "★ ${widget.bookRating}",
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: Text(
                        widget.bookName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "${widget.writerName} | ${widget.bookCategory}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: const Color(0xff6B6B6B),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Book Details",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                          ),
                        ),
                        SizedBox(
                          width: 59.w,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                    color: AppMainColor.primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.w),
                                )),
                            onPressed: () {
                              Get.to(SwapBooks(
                                bookName: widget.bookName,
                                bookPicURL: widget.bookPicURL,
                              ));
                            },
                            child: Text(
                              "Swap",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 26.sp,
                                color: const Color(0xff9C51A8),
                              ),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xff089B31),
                                side: const BorderSide(color: Colors.black),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.w),
                                    bottomLeft: Radius.circular(15.w),
                                  ),
                                )),
                            onPressed: () {
                              Get.to(BuyBooks(
                                bookCost: widget.bookPrice,
                                name: widget.bookName,
                                bookPicURL: widget.bookPicURL,
                              ));
                            },
                            child: Text(
                              "Buy",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 26.sp,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Wrap(
                      children: [
                        Text(
                          "Publisher Name : ${widget.publisherName}.",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Edition                 : ${widget.edition}",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Release Date      : ${widget.releaseDate}",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Language            : ${widget.language}",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "ISBN-10               : ${widget.isbn_10}",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "ISBN-13               : ${widget.isbn_13}",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Stock                   : ${widget.stock}",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: 363.w,
                      //height: 170.h,
                      child: Text(
                        textAlign: TextAlign.justify,
                        widget.description,
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
      bottomNavigationBar: const BottomNav(
        activeIndex: 0,
      ),
    );
  }
}

class ImageSliders extends StatefulWidget {
  const ImageSliders({super.key, required this.bookPicURL});
  final String bookPicURL;
  @override
  State<ImageSliders> createState() => _ImageSlidersState();
}

class _ImageSlidersState extends State<ImageSliders> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.w),
          child: SizedBox(
            width: 176.w,
            height: 190.h,
            child: PageView(
              controller: _pageController,
              children: [
                Image.network(
                  widget.bookPicURL,
                  fit: BoxFit.fill,
                ),
                Image.network(
                  'https://nomore.org.au/sites/default/files/logo-fb.png',
                  fit: BoxFit.fill,
                ),
                // Add more Image.network widgets for additional images
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        SmoothPageIndicator(
          controller: _pageController, // PageController
          count: 2,
          effect: const WormEffect(
              dotColor: Colors.grey, activeDotColor: Color(0xff8847a1)),
        )
      ],
    );
  }
}
