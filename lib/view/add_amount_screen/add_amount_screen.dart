import 'package:expense_tracker_getx_sqf/controller/add_amount_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAmountScreen extends StatefulWidget {
  const AddAmountScreen({super.key});

  @override
  State<AddAmountScreen> createState() => _AddAmountScreenState();
}

class _AddAmountScreenState extends State<AddAmountScreen> {
  @override
  Widget build(BuildContext context) {
    AddAmountScreenController controller = Get.put(AddAmountScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Record"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GetBuilder<AddAmountScreenController>(
              builder: (_) => Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.onInExSelection(true);
                      },
                      child: Container(
                        color:
                            controller.isIncome ? Colors.black : Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Text(
                          "Income",
                          style: TextStyle(
                            color: controller.isIncome
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.onInExSelection(false);
                      },
                      child: Container(
                        color:
                            controller.isIncome ? Colors.white : Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Text(
                          "Expense",
                          style: TextStyle(
                            color: controller.isIncome
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Amount", border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Category", border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Date", border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Notes", border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            Obx(() => controller.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : InkWell(
                    onTap: () async {
                      await controller.addNewRecors();
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        "Add Record",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
