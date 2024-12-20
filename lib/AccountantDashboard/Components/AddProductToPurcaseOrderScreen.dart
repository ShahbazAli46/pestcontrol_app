import 'package:accurate/AccountantDashboard/Controllers/AddPurchaseController.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SearchableDropdown.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductToPurchaseOrdersScreen extends StatefulWidget {
  Function addItem;
  AddProductToPurchaseOrdersScreen({required this.addItem});

  @override
  State<AddProductToPurchaseOrdersScreen> createState() => _AddProductToPurchaseOrdersScreenState();
}

class _AddProductToPurchaseOrdersScreenState extends State<AddProductToPurchaseOrdersScreen> {

  AddPurchaseController controller = Get.find(tag: Constants.products);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                NavWithBack(),
                SizedBox(height: 20,),
                AppTextLabels.boldTextShort(label: "Add Item to bill", color: AppColors.appBlack, fontSize: 20),
                SizedBox(height: 20,),
                Obx(() => controller.productNamesList.isNotEmpty ?  SearchableDropdown(
                  title: "Product",
                  options: controller.productNamesList,
                  onChanged: (String? value, int? index) {
                    if (value != null) {
                      print("Selected product: $value at index $index");
                      controller.setSelectedProductID(index ?? 0);
                    }
                  },
                ) : CircularProgressIndicator()),
                AppInput(title: "Quantity", controller: controller.quantity),
                AppInput(title: "Price", controller: controller.price),
                SizedBox(height: 20,),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: GreenButton(title: "Add Item In Bill", sendingData: false.obs, onTap: (){
                      controller.addItem();
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
