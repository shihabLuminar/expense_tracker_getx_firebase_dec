import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  Rx<num> balance = 0.0.obs;
  Rx<num> income = 0.0.obs;
  Rx<num> expense = 0.0.obs;

  calculate(List<QueryDocumentSnapshot> entireData) {
    income.value = 0.0;
    expense.value = 0.0;
    // get income and expense list
    var incomeList =
        entireData.where((element) => element["type"] == "income").toList();
    var expenseList =
        entireData.where((element) => element["type"] == "expense").toList();

    log(incomeList.length.toString());
    log(expenseList.length.toString());

    // calculate total income

    for (var element in incomeList) {
      income.value += num.parse(element["amount"].toString());
    }

    log("income :${income.toString()}");

    // calculate total expense
    for (var element in expenseList) {
      expense.value += num.parse(element["amount"].toString());
    }
    log("expense :${expense.toString()}");
    balance.value = income.value - expense.value;
    log("balance :${balance.toString()}");
  }
}
