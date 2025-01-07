import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/ExpensesController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVechicleFineScreen extends StatefulWidget {
  const AddVechicleFineScreen({Key? key}) : super(key: key);

  @override
  State<AddVechicleFineScreen> createState() => _AddVechicleFineScreenState();
}

class _AddVechicleFineScreenState extends State<AddVechicleFineScreen> {

  late ExpensesController  controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ExpensesController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<ExpensesController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Add Vehicle Expense", color: AppColors.appBlack, fontSize: 20),
            SizedBox(height: 20,),
            Obx(()=>controller.fetchingTotalExpense.value ? UiHelper.loader() : Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  AppDropdown(title: "Select Vehicle", options: controller.vehiclesList, onChanged: handleVehicleChanged),
                  AppInput(title: "Enter Fine Amount", controller: controller.fineController, inputType: TextInputType.number,),
                  SizedBox(height: 20,),
                  AppDatePicker(title: "Fine Date", onDateSelected: handleFineDateChange),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GreenButton(title: "Save ", sendingData: controller.addingFine, onTap: (){
                      controller.addFine();
                    }),
                  )
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

  handleFineDateChange(value){
    controller.fineDate = UiHelper.formatDateForServer(value);
  }
}
