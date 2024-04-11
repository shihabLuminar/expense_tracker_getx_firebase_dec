import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transactionData});
  final DocumentSnapshot transactionData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.3), blurRadius: 4)
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_circle_up,
              color: transactionData["type"] == "income"
                  ? Colors.green
                  : Colors.red,
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              children: [
                Text(
                  transactionData["category"],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  transactionData["note"],
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  transactionData["amount"].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  transactionData["date"],
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
