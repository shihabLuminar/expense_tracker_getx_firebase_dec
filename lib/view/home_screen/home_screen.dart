import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_getx_sqf/view/add_amount_screen/add_amount_screen.dart';
import 'package:expense_tracker_getx_sqf/view/home_screen/widgets/total_in_ex_container.dart';
import 'package:expense_tracker_getx_sqf/view/home_screen/widgets/trancaction_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var collection = FirebaseFirestore.instance.collection("transaction");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Balance",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "₹876543",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    TotalExInContainer(),
                    SizedBox(
                      width: 16,
                    ),
                    TotalExInContainer(),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: collection.orderBy("date").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot transactionData =
                        snapshot.data!.docs[index];
                    return TransactionCard(
                      transactionData: transactionData,
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAmountScreen(),
              ));
        },
      ),
    );
  }
}
