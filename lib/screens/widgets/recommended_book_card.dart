import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:BookBin/screens/other_ui/book_details.dart';
import 'package:rxdart/rxdart.dart';

class RecommendedBookCardCreate extends StatelessWidget {
  const RecommendedBookCardCreate(
      {super.key,
      required this.height,
      this.itemCount,
      required this.collections});

  final double height;
  final int? itemCount;
  final List<CollectionReference> collections;
  @override
  Widget build(BuildContext context) {
    // Create a list of streams for each collection
    List<Stream<QuerySnapshot>> streams = collections
        .map((collection) =>
            collection.where('bookRating', isGreaterThan: 4.4).snapshots())
        .toList();

    // Combine all streams into a single stream using combineLatest
    Stream<List<QuerySnapshot>> combinedStream =
        CombineLatestStream.list(streams);

    return StreamBuilder<List<QuerySnapshot>>(
      stream: combinedStream,
      builder: (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something is wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Convert the list of QuerySnapshots into a single list of DocumentSnapshots
        List<DocumentSnapshot> documents = snapshot.data!
            .expand((querySnapshot) => querySnapshot.docs)
            .toList();

        //manage favorite statuses/wishlist
        RxList<RxBool> isLikedList = documents
            .map((document) {
              bool initialValue = document['isLikedList'] ?? false;
              return RxBool(initialValue);
            })
            .toList()
            .obs;

        return SizedBox(
          height: height,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 260,
            ),
            itemCount: itemCount ?? documents.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = documents[index];
              final data = document.data() as Map<String, dynamic>;

              String imageUrl = data.containsKey("bookPicURL")
                  ? data["bookPicURL"]
                  : "https://i.pinimg.com/736x/49/e5/8d/49e58d5922019b8ec4642a2e2b9291c2.jpg";

              String bookName =
                  data.containsKey("bookName") ? data["bookName"] : "No Data";
              String bookPrice =
                  data.containsKey("bookPrice") ? data["bookPrice"] : "0";

              double bookRating = data.containsKey("bookRating")
                  ? data["bookRating"].toDouble()
                  : 0.0;
              String bookCategory = collections
                  .firstWhere(
                    (collection) => document.reference.path
                        .contains(collection.path.split('/').last),
                  )
                  .id;
              String sell = documents[index]['Sell'];
              String swap = documents[index]['Swap'];
              String bookPicURL = documents[index]['bookPicURL'];
              String description = documents[index]['description'];
              String edition = documents[index]['edition'];
              String isbn_10 = documents[index]['isbn_10'];
              String isbn_13 = documents[index]['isbn_13'];
              String language = documents[index]['language'];
              String publisherName = documents[index]['publisherName'];
              String releaseDate = documents[index]['releaseDate'];
              String stock = documents[index]['stock'];
              String writerName = documents[index]['writerName'];
              //bool wishList = document[index]['isLikedList'];
              return GestureDetector(
                onTap: () {
                  Get.to(BookDetailsScreen(
                    sell: sell,
                    swap: swap,
                    bookPicURL: bookPicURL,
                    description: description,
                    edition: edition,
                    isbn_10: isbn_10,
                    isbn_13: isbn_13,
                    language: language,
                    publisherName: publisherName,
                    releaseDate: releaseDate,
                    stock: stock,
                    writerName: writerName,
                    bookPrice: bookPrice,
                    bookRating: bookRating,
                    bookName: bookName,
                    bookCategory: bookCategory,
                    wishlist: isLikedList[index].value,
                  ));
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.w),
                            child: Image.network(
                              imageUrl,
                              width: 166.w,
                              height: 217.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12.w,
                          top: 8.h,
                          child: GestureDetector(
                            onTap: () {
                              isLikedList[index].toggle();
                              // Update with new favorite status
                              document.reference.update({
                                'isLikedList': isLikedList[index].value,
                              });
                            },
                            child: Obx(() => Icon(
                                  Icons.favorite,
                                  color: isLikedList[index].value
                                      ? Colors.red
                                      : Colors.grey,
                                )),
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          left: 10.w,
                          child: SizedBox(
                            width: 65.w,
                            height: 28.h,
                            child: Card(
                              color: const Color(0xff8847a1),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: Center(
                                child: Text(
                                  "৳ $bookPrice",
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.h,
                          right: 11.w,
                          child: SizedBox(
                            width: 50.w,
                            height: 30.h,
                            child: Card(
                              color: const Color(0xff8847a1),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bookRating.toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 14.w,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 40.h,
                      child: SingleChildScrollView(
                        child: Text(
                          bookName,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
