import 'package:expense_tracker_getx_sqf/controller/add_amount_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAmountScreen extends StatefulWidget {
  const AddAmountScreen({Key? key}) : super(key: key);

  @override
  State<AddAmountScreen> createState() => _AddAmountScreenState();
}

class _AddAmountScreenState extends State<AddAmountScreen> {
  final AddAmountScreenController controller =
      Get.put(AddAmountScreenController());

  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Record"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GetBuilder<AddAmountScreenController>(
                builder: (_) {
                  return Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.onInExSelection(true);
                          },
                          child: Container(
                            color: controller.isIncome
                                ? Colors.black
                                : Colors.white,
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
                            color: controller.isIncome
                                ? Colors.white
                                : Colors.black,
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
                  );
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Amount",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  // Additional validation can be added here
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(
                  hintText: "Category",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  // Additional validation can be added here
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: "Date",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  // Additional validation can be added here
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                  hintText: "Notes",
                  border: OutlineInputBorder(),
                ),
                // No validation for notes, can be added if needed
              ),
              SizedBox(height: 16),
              Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await controller.addNewRecord(
                              amount: amountController.text,
                              category: categoryController.text,
                              date: dateController.text,
                            );
                            Navigator.pop(context);
                          }
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
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
