import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/AddPaymentRequest.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../jsonModels/AllInvoicesResponse.dart';
import '../utils/appColors.dart';
import 'Conrollers/AllCompanyBanksController.dart';
import 'generic/GreenButton.dart';

class MakePaymentScreen extends StatefulWidget {
  InvoicesData item;
  MakePaymentScreen({required this.item});

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {

  var paymentType = -1;
  var bankId = -1;
  TextEditingController cashAmount = TextEditingController();
  TextEditingController vat = TextEditingController();
  late AllCompanyBanksController banksController;
  TextEditingController transactionNumber = TextEditingController();

  DateTime? chequeDate;

  @override
  void initState() {
    // TODO: implement initState
    banksController = Get.put(AllCompanyBanksController(context: context));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AllCompanyBanksController>();
    super.dispose();
  }


  @override
  void onInit() {
    // For example, fetch data from API or initialize variables
    cashAmount.text = "${(double.parse(widget?.item?.totalAmt ?? "0") - double.parse(widget.item.paidAmt ?? "0"))}";
  }

  @override
  void onReady() {
    cashAmount.text = "${(double.parse(widget?.item?.totalAmt ?? "0") - double.parse(widget.item.paidAmt ?? "0"))}";
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NavWithBack(),
              SizedBox(height: 20,),
              AppTextLabels.boldTextShort(label: "Enter Amount", fontSize: 20),
              SizedBox(height: 20,),
              invoiceItem(),
              SizedBox(height: 20,),
              AppTextLabels.boldTextShort(label: "Choose Payment Method", fontSize: 15, color: AppColors.appGreen),
              SizedBox(height: 10,),
              Obx(()=> banksController.fetchingBanks.value ? Center(child: CircularProgressIndicator(),) : Column(
                children: [
                  SelectableButtonGroup(titles: ["Cash", "Online", "POS"], onSelect: (selectedIndex){
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
      ),
    );
  }
  Widget invoiceItem(){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextLabels.regularShortText(label: "Invoice Id", color: AppColors.appGreen),
                    AppTextLabels.boldTextShort(label: widget.item.serviceInvoiceId ?? "", fontSize: 18)
                  ],
                ),
                Expanded(child: Container(child: Text(""),)),
                Container(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextLabels.regularShortText(label: "Issue Date", color: AppColors.appGreen),
                      AppTextLabels.boldTextShort(label: UiHelper.formatDate(widget.item.issuedDate ?? "") , fontSize: 18)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextLabels.regularShortText(label: "Total Amount", color: AppColors.appGreen),
                    AppTextLabels.boldTextShort(label: widget.item.totalAmt ?? "", fontSize: 18)
                  ],
                ),
                Expanded(child: Container(child: Text(""),)),
                Container(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextLabels.regularShortText(label: "Paid Amount", color: AppColors.appGreen),
                      AppTextLabels.boldTextShort(label: widget.item.paidAmt ?? "" , fontSize: 18)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
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
          AddPaymentRequest request = AddPaymentRequest(serviceInvoiceId: "${widget.item.id ?? 0}",
              paidAmt: "${cashAmount.text}", description: "desc", bankId: null, transectionId: null, paymentType: "cash" );
          banksController.addPaymentRequest(request);
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
          AddPaymentRequest request = AddPaymentRequest(serviceInvoiceId: "${widget.item.id ?? 0}",
              paidAmt: "${cashAmount.text}", description: "desc", bankId: "${bankId}", transectionId: transactionNumber.text, paymentType: "online" );
          banksController.addPaymentRequest(request);
        }
      } else if (paymentType == 2){
        if (transactionNumber.text.isEmpty){
          AlertService.showAlert("Alert", "Please enter Transaction number");
        } else if (cashAmount.text.isEmpty){
          AlertService.showAlert("Alert", "Please enter amount");
        }
        else{
          AddPaymentRequest request = AddPaymentRequest(serviceInvoiceId: "${widget.item.id ?? 0}",
              paidAmt: "${cashAmount.text}", description: "desc", bankId: "${bankId}", transectionId: transactionNumber.text , paymentType: "pos");
          banksController.addPaymentRequest(request);
        }
      }
  }
}
