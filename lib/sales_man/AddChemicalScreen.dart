import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/InputWithGetxTitle.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/controllers/generic/AppRadioSelection.dart';
import 'package:accurate/main.dart';
import 'package:accurate/sales_man/RecomendationsScreen.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/UpcomignJobs/UpcomingJobsController.dart';
import '../components/generic/AppDropdown.dart';
import '../components/generic/AppInput.dart';
import '../components/generic/BlueButton.dart';
import '../controllers/GetEmployeeInfoDetails.dart';
import '../utils/Constants.dart';
import '../utils/appColors.dart';
import 'controllers/AddInspectedAreasController.dart';
import 'controllers/ChemicalController.dart';

class AddChemicalsScreen extends StatefulWidget {
  const AddChemicalsScreen({Key? key}) : super(key: key);

  @override
  State<AddChemicalsScreen> createState() => _AddChemicalsScreenState();
}

class _AddChemicalsScreenState extends State<AddChemicalsScreen> {
  late UpcomingJobsController userInfoController;
  int product_id = 0;
  String chemicalName = "";
  bool isExtra = false;



  late ChemicalController usedController;
  @override
  Widget build(BuildContext context) {
    userInfoController = Get.find(tag: "emp");
    usedController = Get.put(ChemicalController(), tag: Constants.usedChemicalController);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20),
            AppTextLabels.boldTextShort(
                label: "Create Service Report", fontSize: 20),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Text("")),
                GreenButton(title: "    +Add Chemicals   ", sendingData: false.obs, onTap: (){
                  isExtra = false;
                  chemicalName = "";
                  product_id = 0;
                  showCustomDialog(context);
                }),
                SizedBox(width: 20,),
              ],
            ),
            SizedBox(height: 20),
            GetBuilder<ChemicalController>(
              init: usedController,
              builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.list.length ?? 0,
                    itemBuilder: (context, index) {
                      return addItem(controller.list[index], index);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20,),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: GreenButton(title: "Next", sendingData: false.obs, onTap: (){
                  UiHelper.navigateToNextScreen(context, RecomendationsScreen());
                })),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }


  Widget addItem ( UsedChemicals item, int index) {
    return Card(
      color: Colors.white,  // Explicitly set the card color to white
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                _buildRow('Sr.', "${index + 1}"),
                Row(
                  children: [
                    Expanded(child: Container(child: Text(""),)),
                    GestureDetector(
                      onTap: () {
                        usedController.removeItem(index);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                    SizedBox(width: 20,)
                  ],
                ),

              ],
            ),

            _buildRow('Chemical Name', item.name),
            _buildRow('Qunatity', "${item.quantity} ${item.unit}"),
            _buildRow('is Extra', item.isExtra ? "True" : "False"),
            _buildRow('Price', "${item.isExtra ? item.price : "0"}"),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String areaObject) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xffF9FAFB)
              ),
              child: Center(child: AppTextLabels.regularShortText(label: label, color: AppColors.appBlack, textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            flex: 3,
            child:
            Container(
              height: 50,
              decoration: BoxDecoration(

              ),
              child: Center(child: AppTextLabels.regularShortText(label: areaObject, color: AppColors.appBlack, textAlign: TextAlign.center)),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    userInfoController.remainingStock.value = "";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
          ),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: double.infinity),
                AppTextLabels.boldTextShort(label: "Add Chemicals", fontSize: 18),
                AppDropdown(
                    title: "Chemicals and material",
                    options: userInfoController.stocksList,
                    onChanged: chemicalChanged
                ),
                Obx(() => AppTextLabels.boldTextShort(
                    label: userInfoController.remainingStock.value,
                    fontSize: 15
                )),
                Obx(() => userInfoController.currentStock.value > 0
                    ? Column(
                  children: [
                    InputWithGetxTitle(
                        title: userInfoController.currentUnit,
                        controller: usedController.quantityController
                    ),
                    AppRadioSelection(
                      title: "Is Extra",
                      options: ["No", "Yes"],
                      initialValue: "No",
                      onChanged: extraValueChanged,
                    ),
                    SizedBox(height: 20),
                    AppInput(
                        title: "Price",
                        controller: usedController.price,
                        enabled: true
                    ),
                    // Fixed Row structure
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Bluebutton(
                              title: "Cancel",
                              sendingData: false.obs,
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            flex: 1,
                            child: GreenButton(
                              title: "Submit",
                              sendingData: false.obs,
                              onTap: () {
                                print(userInfoController.currentStock.value);
                                if (double.parse(usedController.quantityController.text ?? "") > userInfoController.currentStock.value){
                                  AlertService.showAlert("Alert", "Your Stock is less");
                                }
                                else{
                                  Navigator.pop(context);
                                  UsedChemicals usedItem = UsedChemicals(
                                      name: chemicalName,
                                      product_id: product_id,
                                      price: isExtra ? usedController.price.text : "0",
                                      isExtra: isExtra,
                                      quantity: usedController.quantityController.text,
                                      unit: userInfoController.currentUnit.value
                                  );
                                  usedController.addItem(usedItem, () {
                                    Navigator.pop(context);
                                  });
                                }

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    : Bluebutton(
                  title: "Cancel",
                  sendingData: false.obs,
                  onTap: () => Navigator.pop(context),
                ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  chemicalChanged(value, index){
    product_id = userInfoController.getProductId(index);
    chemicalName = value;
  }
  extraValueChanged (value, index){
    print(index);
    isExtra = index == 1;
    print(isExtra);
  }
}
