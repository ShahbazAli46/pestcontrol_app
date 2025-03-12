import 'package:accurate/components/Conrollers/AllCompanyBanksController.dart';
import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/ExpensesController.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddVehicleExpenseScreen extends StatefulWidget {
  const AddVehicleExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddVehicleExpenseScreen> createState() =>
      _AddVehicleExpenseScreenState();
}

class _AddVehicleExpenseScreenState extends State<AddVehicleExpenseScreen> {


  late ExpensesController controller;
  late AllCompanyBanksController banksController;


  var paymentType = 0;
  var bankId = -1;

  var sendingData = false.obs;



  TextEditingController cashAmount = TextEditingController();
  TextEditingController vat = TextEditingController();
  TextEditingController transactionNumber = TextEditingController();
  TextEditingController chequeNumber = TextEditingController();
  String chequeDate =  DateFormat('yyyy-MM-dd').format(DateTime.now());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find(tag: Constants.expensesController);
    banksController = Get.put(AllCompanyBanksController(context: context));
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
                      child: GreenButton(title: "Submit", sendingData: controller.submitingvehicleExp, onTap: handleSubmit)),

                  Obx(()=> banksController.fetchingBanks.value ? Center(child: CircularProgressIndicator(),) : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: SelectableButtonGroup(titles: ["Cash", "Cheque", "Online"], onSelect: (selectedIndex){
                          paymentType = selectedIndex;
                          bankId = -1;
                          setState(() {});
                        }),
                      ),
                      SizedBox(height: 20,),
                      setViewAsPerSelectedPaymentType()
                    ],
                  )),
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


  Widget setViewAsPerSelectedPaymentType(){
    if (paymentType == 0){
      return Container(
        child: Column(
          children: [
            AppInput(title: "Enter Amount", controller: cashAmount, inputType: TextInputType.number,),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GreenButton(title: "Submit", sendingData: sendingData, onTap: (){
                submitPayment();
              }),
            )
          ],
        ),
      );
    } else if (paymentType == 1){
      return Column(
        children: [
          AppDatePicker(title: "Cheque Date", onDateSelected: onChequeDateChanged),
          SizedBox(height: 10,),
          AppInput(title: "Cheque Number", controller: chequeNumber, inputType: TextInputType.number,),
          SizedBox(height: 10,),
          AppInput(title: "Amount", controller: cashAmount, inputType: TextInputType.number,),
          SizedBox(height: 20,),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: GreenButton(title: "Submit Payment", sendingData: sendingData, onTap: (){
                submitPayment();
              }))

        ],
      );
    } else if (paymentType == 2){
      return Column(
        children: [
          AppDropdown(title: "Chose Bank", options: banksController.bankNamesList ?? [], onChanged: (value,index){
            bankId = banksController.getBankId(index);
          }),
          AppInput(title: "Transaction Number", controller: transactionNumber),
          AppInput(title: "Amount", controller: cashAmount ,inputType: TextInputType.number,),
          SizedBox(height: 20,),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: GreenButton(title: "Submit Payment", sendingData: sendingData, onTap: (){
                submitPayment();
              }))
        ],
      );
    }
    else{
      return Container();
    }
  }

  submitPayment() async{
    FocusScope.of(context).unfocus();

     if (controller.selectedExpCatId == -1){
      AlertService.showAlert("Alert", "Please select Expense Category");
    } else if (banksController.selectedBranched == -1){
      AlertService.showAlert("Alert", "Please select branch");
    }
    else if (paymentType == 0){
      if (cashAmount.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter amount");
      }
      else{
        // ExpenseRequest request = ExpenseRequest();
        // request.expenseName = expenseName.text;
        // request.expenseDate = selectedDate;
        // request.expenseCategoryId = "${controller.selectedExpCatId}";
        // request.vat = "0";
        // request.branch_id = "${banksController.selectedBranched}";
        // request.amount = cashAmount.text;
        // request.paymentType = "cash";
        //
        // sendingData.value = true;
        // late GeneralErrorResponse errorResponse;
        // if (image == null) {
        //   var response  = await api.postDataWithToken(Urls.addExpense, request.toJson());
        //   errorResponse = GeneralErrorResponse.fromJson(response);
        // }
        // else{
        //   var response  = await api.postDataWithTokenWithImage(Urls.addExpense, request.toJson(), image!, "expense_file");
        //   errorResponse = GeneralErrorResponse.fromJson(response);
        // }
        //
        // if (errorResponse.status == "success"){
        //   AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
        //     controller.getCurrentMonthData();
        //     Get.back();
        //   });
        // }
        // else{
        //   AlertService.showAlert("Alert", errorResponse.message ?? "");
        // }
        sendingData.value = false;

      }
    } else if (paymentType == 1){
      if (cashAmount.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter amount");
      }  else if (chequeNumber.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter cheque number");
      }
      else{
        // ExpenseRequest request = ExpenseRequest();
        // request.expenseName = expenseName.text;
        // request.expenseDate = selectedDate;
        // request.expenseCategoryId = "${controller.selectedExpCatId}";
        // request.vat = "0";
        // request.amount = cashAmount.text;
        // request.paymentType = "cheque";
        // request.bankId = null;
        // request.branch_id = "${banksController.selectedBranched}";
        // request.chequeDate = "${chequeDate}";
        // request.cheque_no = "${chequeNumber.text}";
        // sendingData.value = true;
        //
        // late GeneralErrorResponse errorResponse;
        //
        // if (image == null) {
        //   var response  = await api.postDataWithToken(Urls.addExpense, request.toJson());
        //   errorResponse = GeneralErrorResponse.fromJson(response);
        // }
        // else{
        //   var response  = await api.postDataWithTokenWithImage(Urls.addExpense, request.toJson(), image!, "expense_file");
        //   errorResponse = GeneralErrorResponse.fromJson(response);
        // }
        //
        // if (errorResponse.status == "success"){
        //   AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
        //     controller.getCurrentMonthData();
        //     Get.back();
        //   });
        // }
        // else{
        //   AlertService.showAlert("Alert", errorResponse.message ?? "");
        // }
        sendingData.value = false;

      }
    } else if (paymentType == 2){
      if (transactionNumber.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter Transaction number");
      } else if (cashAmount.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter amount");
      }
      else{

        // ExpenseRequest request = ExpenseRequest();
        // request.expenseName = expenseName.text;
        // request.expenseDate = selectedDate;
        // request.expenseCategoryId = "${controller.selectedExpCatId}";
        // request.vat = "0";
        // request.amount = cashAmount.text;
        // request.paymentType = "online";
        // request.bankId = "${bankId}";
        // request.branch_id = "${banksController.selectedBranched}";
        // request.transectionId = transactionNumber.text;
        // sendingData.value = true;
        //
        // late GeneralErrorResponse errorResponse;
        // if (image == null) {
        //   var response  = await api.postDataWithToken(Urls.addExpense, request.toJson());
        //   errorResponse = GeneralErrorResponse.fromJson(response);
        // }
        // else{
        //   var response  = await api.postDataWithTokenWithImage(Urls.addExpense, request.toJson(), image!, "expense_file");
        //   errorResponse = GeneralErrorResponse.fromJson(response);
        // }
        //
        // if (errorResponse.status == "success"){
        //   AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
        //     controller.getCurrentMonthData();
        //     Get.back();
        //   });
        // }
        // else{
        //   AlertService.showAlert("Alert", errorResponse.message ?? "");
        // }
        sendingData.value = false;
      }
    }
  }


  onChequeDateChanged(DateTime date){
    chequeDate =  DateFormat('yyyy-MM-dd').format(date);
  }
}
