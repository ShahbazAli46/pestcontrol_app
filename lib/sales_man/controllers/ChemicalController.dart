import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChemicalController extends GetxController {
  var list = RxList<UsedChemicals>();
  TextEditingController quantityController = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void addItem(UsedChemicals item, close) {
    list.value.add(item);
    update();
  }

  void removeItem(int index) {
    if (index >= 0 && index < list.length) {
      print("Hello ");
      list.removeAt(index);
      update();
    }
  }
}

class UsedChemicals {
  late String name;
  late int product_id;
  late String quantity;
  late String price;
  late bool isExtra;
  late String unit;

  UsedChemicals(
      {required this.name,
      required this.product_id,
      required this.price,
      required this.isExtra,
      required this.quantity,
      required this.unit
      });
}
