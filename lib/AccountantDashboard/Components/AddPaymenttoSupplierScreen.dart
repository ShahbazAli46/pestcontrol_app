import 'package:accurate/components/Conrollers/AllCompanyBanksController.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/AddSupplierPaymentRequest.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPaymentToSupplierScreen extends StatefulWidget {
  int supplierID;
  String supplierName;
  Function refreshData;
  AddPaymentToSupplierScreen({required this.supplierID, required this.supplierName, required this.refreshData});

  @override
  State<AddPaymentToSupplierScreen> createState() => _AddPaymentToSupplierScreenState();
}

class _AddPaymentToSupplierScreenState extends State<AddPaymentToSupplierScreen> {

  var paymentType = 0;
  var bankId = -1;
  TextEditingController cashAmount = TextEditingController();
  TextEditingController vat = TextEditingController();
  late AllCompanyBanksController banksController;
  TextEditingController transactionNumber = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    banksController = Get.put(AllCompanyBanksController(context: context));
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<AllCompanyBanksController>();
    super.dispose();
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
            AppTextLabels.boldTextShort(label: "Add Payment to ${widget.supplierName}", color: AppColors.appBlack, fontSize: 20),
            SizedBox(height: 20,),

            Obx(()=> banksController.fetchingBanks.value ? Center(child: CircularProgressIndicator(),) : Column(
              children: [
                SelectableButtonGroup(titles: ["Cash", "Online"], onSelect: (selectedIndex){
                  paymentType = selectedIndex;
                  bankId = -1;
                  setState(() {});
                }),
                SizedBox(height: 20,),
                setViewAsPerSelectedPaymentType()
              ],
            )),
          ],
        ),
      ),
    );
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
              child: GreenButton(title: "Submit", sendingData: banksController.addingPayment, onTap: (){
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
          AppInput(title: "Transaction Number", controller: transactionNumber),
          SizedBox(height: 10,),
          AppInput(title: "Amount", controller: cashAmount, inputType: TextInputType.number,),
          SizedBox(height: 20,),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: GreenButton(title: "Submit Payment", sendingData: banksController.addingPayment, onTap: (){
                submitPayment();
              }))

        ],
      );
    } else if (paymentType == 2){
      return Column(
        children: [
          AppInput(title: "Transaction Number", controller: transactionNumber),
          AppInput(title: "Amount", controller: cashAmount ,inputType: TextInputType.number,),
          SizedBox(height: 20,),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: GreenButton(title: "Submit Payment", sendingData: banksController.addingPayment, onTap: (){
                submitPayment();
              }))
        ],
      );
    }
    else{
      return Container();
    }
  }

  submitPayment(){
    FocusScope.of(context).unfocus();
    if (paymentType == 0){
      if (cashAmount.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter amount");
      }
      else{
        AddSupplierPaymentRequest request = AddSupplierPaymentRequest();
        request.supplierId = "${widget.supplierID}";
        request.amount = cashAmount.text;
        request.total = cashAmount.text;
        request.paymentType = "cash";
        banksController.addSupplierPayment(request, widget.refreshData);
      }
    } else if (paymentType == 1){
      if (bankId == -1){
        AlertService.showAlert("Alert", "Please Select Bank");
      } else if (transactionNumber.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter Transaction number");
      } else if (cashAmount.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter amount");
      }
      else{
        // submit
        AddSupplierPaymentRequest request = AddSupplierPaymentRequest();
        request.supplierId = "${widget.supplierID}";
        request.amount = cashAmount.text;
        request.total = cashAmount.text;
        request.paymentType = "online";
        request.bankId = "${bankId}";
        request.transectionId = transactionNumber.text;
        banksController.addSupplierPayment(request, widget.refreshData);
      }
    } else if (paymentType == 2){
      if (transactionNumber.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter Transaction number");
      } else if (cashAmount.text.isEmpty){
        AlertService.showAlert("Alert", "Please enter amount");
      }
      else{

      }
    }
  }
}
