import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_getx_sqf/controller/home_screen_controller.dart';
import 'package:expense_tracker_getx_sqf/view/add_amount_screen/add_amount_screen.dart';
import 'package:expense_tracker_getx_sqf/view/home_screen/widgets/total_in_ex_container.dart';
import 'package:expense_tracker_getx_sqf/view/home_screen/widgets/trancaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var collection = FirebaseFirestore.instance.collection("transaction");

  late HomeScreenController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: collection.orderBy("date", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

            controller.calculate(documents);
            return Column(
              children: [
                Obx(() => Container(
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
                          "₹${controller.balance.value}",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            TotalExInContainer(
                              amount: controller.income.value,
                              textColor: Colors.green,
                              title: "Income",
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            TotalExInContainer(
                              amount: controller.expense.value,
                              textColor: Colors.red,
                              title: "Expense",
                            ),
                          ],
                        )
                      ],
                    ))),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot transactionData =
                          snapshot.data!.docs[index];
                      return TransactionCard(
                        transactionData: transactionData,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
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
