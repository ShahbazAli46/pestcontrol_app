import 'dart:io';

import 'package:accurate/components/Conrollers/AllCompanyBanksController.dart';
import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/ImageUploadWidget.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/ExpnseRequest.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/superadmin/Controllers/ExpensesController.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {


  TextEditingController expenseName = TextEditingController();
  TextEditingController descController = TextEditingController();
  late AllCompanyBanksController banksController;


  TextEditingController cashAmount = TextEditingController();
  TextEditingController vat = TextEditingController();
  TextEditingController transactionNumber = TextEditingController();

  String selectedDate =  DateFormat('yyyy-MM-dd').format(DateTime.now());
  String chequeDate =  DateFormat('yyyy-MM-dd').format(DateTime.now());
  late ExpensesController controller;

  var paymentType = 0;
  var bankId = -1;

  var sendingData = false.obs;
  bool isImageSelected = true;

  late File image;

  var api = APICall();


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
        body: SafeArea(child: Column(
      children: [
        Container(),
        NavWithBack(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                AppTextLabels.boldTextShort(label: "Add Expense", fontSize: 20),
                SizedBox(height: 20,),
                ImageUploadWidget(onImageSelected: onImageSelected),
                AppTextLabels.boldTextShort(label: "Bill Receipt", fontSize: 10),
                SizedBox(height: 20,),
                AppInput(title: "Expense Name", controller: expenseName),
                AppDatePicker(title: "Expense Date", onDateSelected: onDateSelected),
                AppDropdown(title: "Select Category", options: controller.categoriesList, onChanged: onCategoryChanged),
                AppMultilineInput(title: "Description", controller: descController),
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
          ),
        )
      ],
    )));
  }

  onImageSelected (File image){
    isImageSelected = true;
    this.image = image;
  }

  onDateSelected(DateTime date){
    selectedDate =  DateFormat('yyyy-MM-dd').format(date);
  }

  onCategoryChanged(value, index){
    controller.setExpenseId(index);
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
          AppDropdown(title: "Chose Bank", options: banksController.bankNamesList ?? [], onChanged: (value,index){
            bankId = banksController.getBankId(index);
          }),
          AppDatePicker(title: "Cheque Date", onDateSelected: onChequeDateChanged),
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

    if (expenseName.text.isEmpty){
      AlertService.showAlert("Alert", "Please enter Expense Name");
    } else if (controller.selectedExpCatId == -1){
      AlertService.showAlert("Alert", "Please select Expense Category");
    } else if (paymentType == 0){
      if (cashAmount.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter amount");
      }
      else{
        ExpenseRequest request = ExpenseRequest();
        request.expenseName = expenseName.text;
        request.expenseDate = selectedDate;
        request.expenseCategoryId = "${controller.selectedExpCatId}";
        request.vat = "0";
        request.amount = cashAmount.text;
        request.paymentType = "cash";
        sendingData.value = true;
        late GeneralErrorResponse errorResponse;
        if (image == null) {
          var response  = await api.postDataWithToken(Urls.addExpense, request.toJson());
          errorResponse = GeneralErrorResponse.fromJson(response);
        }
        else{
          var response  = await api.postDataWithTokenWithImage(Urls.addExpense, request.toJson(), image, "expense_file");
          errorResponse = GeneralErrorResponse.fromJson(response);
        }

        if (errorResponse.status == "success"){
          AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
            controller.getCurrentMonthData();
            Get.back();
          });
        }
        else{
          AlertService.showAlert("Alert", errorResponse.message ?? "");
        }
        sendingData.value = false;

      }
    } else if (paymentType == 1){
      if (bankId == -1){
        AlertService.showAlert("Alert", "Please Select Bank");
      } else if (cashAmount.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter amount");
      }
      else{
        ExpenseRequest request = ExpenseRequest();
        request.expenseName = expenseName.text;
        request.expenseDate = selectedDate;
        request.expenseCategoryId = "${controller.selectedExpCatId}";
        request.vat = "0";
        request.amount = cashAmount.text;
        request.paymentType = "cash";
        request.bankId = "${bankId}";
        request.chequeDate = "${chequeDate}";
        sendingData.value = true;

        late GeneralErrorResponse errorResponse;
        if (image == null) {
          var response  = await api.postDataWithToken(Urls.addExpense, request.toJson());
          errorResponse = GeneralErrorResponse.fromJson(response);
        }
        else{
          var response  = await api.postDataWithTokenWithImage(Urls.addExpense, request.toJson(), image, "expense_file");
          errorResponse = GeneralErrorResponse.fromJson(response);
        }

        if (errorResponse.status == "success"){
          AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
            controller.getCurrentMonthData();
            Get.back();
          });
        }
        else{
          AlertService.showAlert("Alert", errorResponse.message ?? "");
        }
        sendingData.value = false;

      }
    } else if (paymentType == 2){
      if (transactionNumber.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter Transaction number");
      } else if (cashAmount.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter amount");
      }
      else{

        ExpenseRequest request = ExpenseRequest();
        request.expenseName = expenseName.text;
        request.expenseDate = selectedDate;
        request.expenseCategoryId = "${controller.selectedExpCatId}";
        request.vat = "0";
        request.amount = cashAmount.text;
        request.paymentType = "cash";
        request.bankId = "${bankId}";
        request.transectionId = transactionNumber.text;
        sendingData.value = true;

        late GeneralErrorResponse errorResponse;
        if (image == null) {
          var response  = await api.postDataWithToken(Urls.addExpense, request.toJson());
          errorResponse = GeneralErrorResponse.fromJson(response);
        }
        else{
          var response  = await api.postDataWithTokenWithImage(Urls.addExpense, request.toJson(), image, "expense_file");
          errorResponse = GeneralErrorResponse.fromJson(response);
        }

        if (errorResponse.status == "success"){
          AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
            controller.getCurrentMonthData();
            Get.back();
          });
        }
        else{
          AlertService.showAlert("Alert", errorResponse.message ?? "");
        }
        sendingData.value = false;
      }
    }
  }


  onChequeDateChanged(DateTime date){
    chequeDate =  DateFormat('yyyy-MM-dd').format(date);
  }
}