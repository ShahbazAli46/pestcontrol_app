import 'dart:io';

import 'package:accurate/AccountantDashboard/Components/AddProductToPurcaseOrderScreen.dart';
import 'package:accurate/AccountantDashboard/Controllers/AddPurchaseController.dart';
import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/ImageUploadWidget.dart';
import 'package:accurate/components/generic/SearchableDropdown.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/sales_man/controllers/UsedItemHistoryController.dart';
import 'package:accurate/utils/AppImages.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPurchaseOrderScreen extends StatefulWidget {
  int supplierID;
  String supplierName;
  Function refreshData;
  AddPurchaseOrderScreen({required this.supplierID, required this.supplierName, required this.refreshData });

  @override
  State<AddPurchaseOrderScreen> createState() => _AddAddPurchaseOrderScreen();
}

class _AddAddPurchaseOrderScreen extends State<AddPurchaseOrderScreen> {

  bool isImageSelected = true;
  late File image;

  late AddPurchaseController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller =  Get.put(AddPurchaseController(), tag: Constants.products, permanent: false);
  }



  @override
  void dispose() {
    // TODO: implement dispose
    Get.deleteAll(force: true);
    controller.billItems.clear();
    super.dispose();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
      children: [
        NavWithBack(),
        SizedBox(height: 20,),
        AppTextLabels.boldTextShort(label: "Add Purchase from ${widget.supplierName}", color: AppColors.appBlack, fontSize: 20),
        SizedBox(height: 20,),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                ImageUploadWidget(onImageSelected: onImageSelected),
                AppTextLabels.boldTextShort(label: "Bill Receipt", fontSize: 10),
                AppDatePicker(title: "Order Date", onDateSelected: handleOrderDateChanged),
                AppDatePicker(title: "Delivery Date", onDateSelected: handleDeliveryDateChanged),
                AppInput(title: "Invoice Number", controller: controller.invoiceNumber),
                Obx(() => !controller.refreshList.value
                    ? Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,

                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  AppTextLabels.regularShortText(label: "Sr", color: AppColors.appBlack)
                                ],
                              )
                            ),
                            Expanded(
                              child: Container(
                                  height: 50,

                                  child: Row(
                                    children: [
                                      AppTextLabels.regularShortText(label: "Product Name", color: AppColors.appBlack)
                                    ],
                                  )
                              ),
                            ),
                            Container(
                                height: 50,
                                width: 80,
                                child: Row(
                                  children: [
                                    AppTextLabels.regularShortText(label: "Price", color: AppColors.appBlack)
                                  ],
                                )
                            ),
                            Container(
                                height: 50,
                                width: 80,
                                child: Row(
                                  children: [
                                    AppTextLabels.regularShortText(label: "Qty", color: AppColors.appBlack)
                                  ],
                                )
                            )
                          ],
                        ),
                        ListView.builder(
                                          itemBuilder: (context, index)=>billItemView(index),
                                          itemCount: controller.billItems.length,
                                          primary: false,
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                        ),
                        UiHelper.dashedBoarder(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: 50,


                                child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    AppTextLabels.boldTextShort(label: "Total  Amount", color: AppColors.appBlack, fontSize: 18)
                                  ],
                                )
                            ),


                            Container(
                                height: 50,


                                child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    AppTextLabels.boldTextShort(label: "${UiHelper.formatUAECurrency(controller.totalAmount)}", color: AppColors.appBlack, fontSize: 18)
                                  ],
                                )
                            ),
                          ],
                        ),
                      ],
                    )
                    : Container()),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: GreenButton(
                    title: "Add Product",
                    sendingData: false.obs,
                    onTap: () {
                      UiHelper.navigateToNextScreen(
                          context, AddProductToPurchaseOrdersScreen(addItem: addItem));
                    },
                  ),
                ),
                SizedBox(height: 20),
                AppInput(title: "Over all Bill VAT %", controller: controller.vat, inputType: TextInputType.number,onChange: controller.vatChanged,),
                SizedBox(height: 10),
                UiHelper.dashedBoarder(),
                SizedBox(height: 10),
                Obx(()=>controller.refreshList.value ? Text("") : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        AppTextLabels.boldTextShort(label: "Vat Amount", color: AppColors.appBlack, fontSize: 15),
                        AppTextLabels.boldTextShort(label: "${controller.percentage}", color: AppColors.appBlack, fontSize: 15),

                      ],
                    ),
                    Column(
                      children: [
                        AppTextLabels.boldTextShort(label: "Grand Total", color: AppColors.appBlack, fontSize: 15),
                        AppTextLabels.boldTextShort(label: "${controller.percentage + controller.totalAmount}", color: AppColors.appBlack, fontSize: 15),

                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
        SizedBox(height: 20),


        Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: GreenButton(title: "Save Bill", sendingData: false.obs, onTap: (){
              controller.saveBill();
            })),
        SizedBox(height: 20),
      ],
    )));
  }
  onImageSelected (File image){
    isImageSelected = true;
    this.image = image;
  }

  handleOrderDateChanged(DateTime date){

  }

  handleDeliveryDateChanged(DateTime date){

  }

  addItem(item){

  }


  Widget billItemView (int index){
    return Container(
      child: Row(
        children: [
          Container(
              height: 50,
              width: 50,
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  AppTextLabels.regularShortText(label: "${index + 1}", color: AppColors.appBlack)
                ],
              )
          ),
          Expanded(
            child: Container(
                height: 50,

                child: Row(
                  children: [

                    AppTextLabels.regularShortText(label: "${controller.billItems[index].productName}", color: AppColors.appBlack)
                  ],
                )
            ),
          ),
          Container(
              height: 50,
              width: 80,
              child: Row(
                children: [
                  AppTextLabels.regularShortText(label: "${controller.billItems[index].price}", color: AppColors.appBlack)
                ],
              )
          ),
          Container(
              height: 50,
              width: 80,
              child: Row(
                children: [
                  AppTextLabels.regularShortText(label: "${controller.billItems[index].qty}", color: AppColors.appBlack)
                ],
              )
          )
        ],
      ),
    );
  }

}
