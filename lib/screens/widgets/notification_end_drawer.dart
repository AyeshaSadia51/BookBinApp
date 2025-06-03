import 'package:BookBin/utilitis/app_main_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationEndDrawer extends StatelessWidget {
  const NotificationEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          bottomLeft: Radius.circular(20.w),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Buy Requests',
                style: TextStyle(
                  color: AppMainColor.primaryColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // StreamBuilder to fetch real-time data from Firestore collection 'BuyerInfo'
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('BuyerInfo') // Updated to 'BuyerInfo'
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  // Check if the stream has data
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.purple,
                    )); // Show loading spinner
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                            "No Buy Requests Found")); // Show if no data exists
                  }

                  // Get buyer documents
                  var buyers = snapshot.data!.docs;

                  // Display list of buyers
                  return ListView.builder(
                    itemCount: buyers.length,
                    itemBuilder: (context, index) {
                      var buyer = buyers[index].data()
                          as Map<String, dynamic>; // Access buyer data

                      return Card(
                        color: Colors.white54,
                        elevation: 3, // Set elevation for shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadowColor: Colors.purpleAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: ClipRRect(
                              child: Image.network(
                                buyer['bookPicURL'],
                                fit: BoxFit.fill,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      buyer['bookName'] ?? 'Unknown',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    "৳${buyer['totalPrice']}",
                                    style: const TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name    : ${buyer['receiverName']}",
                                        style: TextStyle(
                                          color: AppMainColor.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Phone   : ${buyer['phone']}",
                                        style: TextStyle(
                                            color: AppMainColor.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Address: ${buyer['receivedLocation']}",
                                        style: TextStyle(
                                            color: AppMainColor.primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      /*Text(
                                        "৳${buyer['totalPrice']}",
                                        style: const TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.bold),
                                      ),*/
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
