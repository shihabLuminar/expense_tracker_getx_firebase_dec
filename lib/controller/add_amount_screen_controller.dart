import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class AddAmountScreenController extends GetxController {
  bool isIncome = true;
  RxBool isLoading = false.obs;
  var collection = FirebaseFirestore.instance.collection("transaction");

  onInExSelection(bool value) {
    isIncome = value;
    update();
  }

  Future<void> addNewRecord({
    required String amount,
    required String category,
    required String date,
    String? note = "",
  }) async {
    isLoading.value = true;

    await collection.add({
      "amount": num.parse(amount.toString()),
      "category": category,
      "date": date,
      "note": note,
      "type": isIncome ? "income" : "expense",
    });

    isLoading.value = false;
  }
}
