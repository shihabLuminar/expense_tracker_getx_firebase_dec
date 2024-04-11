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

  Future addNewRecors() async {
    isLoading.value = true;

    await collection.add({
      "amount": 3567,
      "category": "fuel",
      "date": "02-02-2024",
      "note": "",
      "type": isIncome ? "income" : "expense",
    });
    isLoading.value = false;
  }
}
