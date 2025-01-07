import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/ExpensesController.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVehicleExpenseScreen extends StatefulWidget {
  const AddVehicleExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddVehicleExpenseScreen> createState() =>
      _AddVehicleExpenseScreenState();
}

class _AddVehicleExpenseScreenState extends State<AddVehicleExpenseScreen> {


  late ExpensesController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find(tag: Constants.expensesController);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(
              height: 20,
            ),
            AppTextLabels.boldTextShort(
                label: "Add Vehicle Screen", fontSize: 20),
            SizedBox(
              height: 20,
            ),
            Expanded(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppDropdown(title: "Select Vehicle", options: controller.vehiclesList, onChanged: handleVehicleChanged),
                  AppDatePicker(title: "Expense Date", onDateSelected: handleExpanseDateChanged),
                  AppInput(title: "Fuel", controller: controller.fuelController, inputType: TextInputType.number, onChange: controller.calculateTotal,),
                  AppInput(title: "Oil Expense", controller: controller.oilController, inputType: TextInputType.number, onChange: controller.calculateTotal,),
                  AppInput(title: "Maintenance", controller: controller.maintainenceController, inputType: TextInputType.number, onChange: controller.calculateTotal,),
                  AppInput(title: "Next Oil Change Limit", controller: controller.nextOilController, inputType: TextInputType.number, onChange: controller.calculateTotal,),
                  AppInput(title: "VAT %", controller: controller.vatController, inputType: TextInputType.number, onChange: controller.calculateTotal,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: AppTextLabels.boldTextShort(label: "Total", fontSize: 20)),

                      Obx(() {
                        return AppTextLabels.boldTextShort(
                          label: controller.total.value, // Display the value from the controller
                          fontSize: 20,
                          color: AppColors.appGreen,
                        );
                      })
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: GreenButton(title: "Submit", sendingData: controller.submitingvehicleExp, onTap: handleSubmit))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  handleVehicleChanged(String? value, int? index){
    controller.setVehicleId(index ?? 0);
  }

  handleExpanseDateChanged(DateTime date){
      controller.vExpData = UiHelper.formatDateForServer(date);
  }

  handleSubmit(){
    controller.submitVehicleExp();
  }
}
