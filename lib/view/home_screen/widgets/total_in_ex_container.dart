import 'package:flutter/material.dart';

class TotalExInContainer extends StatelessWidget {
  const TotalExInContainer({
    super.key,
    required this.amount,
    required this.title,
    required this.textColor,
  });
  final num amount;
  final String title;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Icon(
                Icons.arrow_circle_up,
                // color: Colors.white,
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                children: [
                  Text(
                    "$title",
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "₹$amount",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
