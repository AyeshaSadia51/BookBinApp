import 'package:BookBin/screens/other_ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utilitis/app_main_color.dart';
import '../widgets/Appbar_and_BottomNav/bottom_nav.dart'; // Custom BottomNav widget

class InboxList extends StatefulWidget {
  const InboxList({super.key});

  @override
  State<InboxList> createState() => _InboxListState();
}

class _InboxListState extends State<InboxList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Initialize TabController
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Inbox',
            style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                'Swap Request',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                'Buy Request',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSwapRequestTab(), // List of swappers
          _buildBuyRequestTab(), // List of buyers
        ],
      ),
      bottomNavigationBar: const BottomNav(
        activeIndex: 1, // Assuming Inbox is the second item in your BottomNav
      ),
    );
  }

  // Widget to display the list of buyers with details (Buy Book tab)
  Widget _buildBuyRequestTab() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('BuyerInfo')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.purple));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Buy Requests Found",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Get.off(const HomePage());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppMainColor.primaryColor),
                        child: Text(
                          'Back to Home',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      )
                    ],
                  ));
                }

                var buyers = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: buyers.length,
                  itemBuilder: (context, index) {
                    var buyer = buyers[index].data() as Map<String, dynamic>;
                    var docId = snapshot.data!.docs[index].id;
                    var timestamp = buyer['timestamp'] as Timestamp?;
                    var dateTime = timestamp
                        ?.toDate(); // Convert Firestore timestamp to DateTime

                    return Card(
                      color: Colors.white54,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              buyer['bookPicURL'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    buyer['bookName'] ?? 'Unknown',
                                    style: const TextStyle(fontSize: 16),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  "৳${buyer['totalPrice']}",
                                  style: const TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    _confirmDelete(context, 'BuyerInfo', docId),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name    : ${buyer['receiverName']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.visible),
                                    Text("Phone   : ${buyer['phone']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.visible),
                                    Text(
                                        "Address: ${buyer['receivedLocation']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.visible),
                                  ],
                                ),
                              ),
                              if (dateTime != null)
                                Flexible(
                                  flex:
                                      2, // Give less space to the date-time column
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end, // Align to the right
                                      children: [
                                        Text(
                                          DateFormat('hh:mma')
                                              .format(dateTime), // Display time
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(dateTime), // Display date
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
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
    );
  }

  // Widget to display the list of swappers with details (Swap Book tab)
  Widget _buildSwapRequestTab() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('SwapperInfo')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.purple));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Swap Requests Found",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Get.off(const HomePage());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppMainColor.primaryColor),
                        child: Text(
                          'Back to Home',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      )
                    ],
                  ));
                }

                var swappers = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: swappers.length,
                  itemBuilder: (context, index) {
                    var swapper =
                        swappers[index].data() as Map<String, dynamic>;
                    var docId = snapshot.data!.docs[index].id;
                    var timestamp = swapper['timestamp'] as Timestamp?;
                    var dateTime = timestamp
                        ?.toDate(); // Convert Firestore timestamp to DateTime

                    return Card(
                      color: Colors.white54,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: Colors.purpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              swapper['bookPicURL'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    swapper['bookName'] ?? 'Unknown',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.chat,
                                    color: AppMainColor.primaryColor,
                                    size: 26.sp,
                                  ),
                                  onPressed: () {
                                    // Chat functionality here
                                  },
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDelete(
                                    context, 'SwapperInfo', docId),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 4, // Take up most of the space
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name    : ${swapper['swapperName']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.visible),
                                    Text("Phone   : ${swapper['swapperPhone']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.visible),
                                    Text(
                                        "Swap Book : ${swapper['swapBookName']}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow
                                            .visible // Handle overflow by ellipsis
                                        ),
                                  ],
                                ),
                              ),
                              if (dateTime != null)
                                Flexible(
                                  flex:
                                      2, // Give less space to the date-time column
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end, // Align to the right
                                      children: [
                                        Text(
                                          DateFormat('hh:mma')
                                              .format(dateTime), // Display time
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(dateTime), // Display date
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
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
    );
  }

  // Function to show the confirmation dialog
  Future<void> _confirmDelete(
      BuildContext context, String collectionName, String docId) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 8.0,
          backgroundColor: Colors.white,
          title: const Text(
            'Confirm Delete',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this request?',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () {
                  Get.back(); // Dismiss the dialog
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () {
                  Get.back(); // Dismiss the dialog
                  _deleteRequest(
                      collectionName, docId); // Call the delete function
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to delete a document from Firestore
  Future<void> _deleteRequest(String collectionName, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(docId)
          .delete();
      Get.snackbar(
        'Success',
        'Request deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete request',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
