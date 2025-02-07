import 'package:accurate/RecoveryOfficeDashboard/controllers/ProcessInvoiceController.dart';
import 'package:accurate/components/Conrollers/AllCompanyBanksController.dart';
import 'package:accurate/components/MultiSelectCheckbox.dart';
import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/InvoicePaymentRequest.dart';
import 'package:accurate/jsonModels/InvoiceResponse.dart';
import 'package:accurate/jsonModels/PromiseDateRequest.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../jsonModels/AddPaymentRequest.dart';

class ProcessInvoiceScreen extends StatefulWidget {
  AssignedInvoices invoices;

  ProcessInvoiceScreen({required this.invoices});

  @override
  State<ProcessInvoiceScreen> createState() => _ProcessInvoiceScreenState();
}

class _ProcessInvoiceScreenState extends State<ProcessInvoiceScreen> {
  late ProcessInvoiceController controller;
  late AllCompanyBanksController banksController;
  var addingPayment = false.obs;
  var submittingPromise = false.obs;
  String promiseDate = "";

  var paymentType = 0;
  var bankId = -1;
  var api = APICall();
  TextEditingController cashAmount = TextEditingController();
  TextEditingController vat = TextEditingController();
  TextEditingController transactionNumber = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  List<String> settlementOptions = [];

  @override
  void initState() {
    banksController = Get.put(AllCompanyBanksController(context: context));
    super.initState(); // Always call super.initState() first
    controller = Get.put(ProcessInvoiceController(),
        tag: "processInvoices", permanent: false);
    cashAmount.text = widget.invoices?.totalAmt ?? "";
    DateTime now = DateTime.now();
    promiseDate = UiHelper.formatDateForServer(now);
  }

  @override
  void dispose() {
    if (Get.isRegistered<ProcessInvoiceController>(tag: "processInvoices")) {
      Get.delete<ProcessInvoiceController>(tag: "processInvoices");
    }
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
            SizedBox(
              height: 20,
            ),
            AppTextLabels.boldTextShort(
                label: "Process Invoice",
                color: AppColors.appBlack,
                fontSize: 20),
            SizedBox(
              height: 20,
            ),

            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
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
                    child: Column(
                      children: [
                        UiHelper.buildRow("Name", widget.invoices.user?.name ?? ""),
                        UiHelper.buildRow("Amount", widget.invoices?.totalAmt ?? ""),
                      ],
                    ),
                  ),
                  SelectableButtonGroup(
                      titles: ["Pay", "Pay Later", "Other"], onSelect: onSelect),
                  Obx(() => controller.option.value == 0
                      ? paymentView()
                      : controller.option.value == 1
                      ? promiseView()
                      : other())
                ],
              ),
            ))
          ],
        )));
  }

  Container paymentView() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          AppTextLabels.boldTextShort(
              label: "Please Select Payment type", fontSize: 15),
          SizedBox(
            height: 20,
          ),

          Obx(() => banksController.fetchingBanks.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SelectableButtonGroup(
                        titles: ["Cash", "Online"],
                        onSelect: (selectedIndex) {
                          paymentType = selectedIndex;
                          bankId = -1;
                          setState(() {});
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    MultiSelectCheckbox(title: "Settlement", onSelectionChanged: settlementChanged, items: [CheckboxItem(id: "1", value: "Yes")].obs,),
                    SizedBox(
                      height: 10,
                    ),

                    setViewAsPerSelectedPaymentType()
                  ],
                )),
        ],
      ),
    );
  }

  Widget setViewAsPerSelectedPaymentType() {
    if (paymentType == 0) {
      return Container(
        child: Column(
          children: [
            AppInput(
              title: "Enter Amount",
              controller: cashAmount,
              inputType: TextInputType.number,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GreenButton(
                  title: "Submit",
                  sendingData: addingPayment,
                  onTap: () {
                    submitPayment();
                  }),
            )
          ],
        ),
      );
    } else if (paymentType == 1) {
      return Column(
        children: [
          AppDropdown(
              title: "Chose Bank",
              options: banksController.bankNamesList ?? [],
              onChanged: (value, index) {
                bankId = banksController.getBankId(index);
              }),
          AppInput(title: "Transaction Number", controller: transactionNumber),
          SizedBox(
            height: 10,
          ),
          AppInput(
            title: "Amount",
            controller: cashAmount,
            inputType: TextInputType.number,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: GreenButton(
                  title: "Submit Payment",
                  sendingData: banksController.addingPayment,
                  onTap: () {
                    submitPayment();
                  }))
        ],
      );
    } else if (paymentType == 2) {
      return Column(
        children: [
          AppInput(title: "Transaction Number", controller: transactionNumber),
          AppInput(
            title: "Amount",
            controller: cashAmount,
            inputType: TextInputType.number,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: GreenButton(
                  title: "Submit Payment",
                  sendingData: addingPayment,
                  onTap: () {
                    submitPayment();
                  }))
        ],
      );
    } else {
      return Container();
    }
  }

  Container promiseView() {
    return Container(
      child: Column(
        children: [
          AppDatePicker(title: "Promise Date", onDateSelected: onDateSelected),
          AppMultilineInput(title: "Comments", controller: commentsController),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GreenButton(title: "Submit", sendingData: submittingPromise, onTap: ()async{
              if (commentsController.text.isEmpty){
                AlertService.showAlert("Alert", "Please enter Comments");
              } else {
                submittingPromise.value = true;
                PromiseDateRequest request = PromiseDateRequest();
                request.invoiceId = "${widget.invoices.id  ?? 0}";
                request.recoveryOfficerId = "${userObj?.data?.id ?? 0}";
                request.responseType = "promise";
                request.comment = commentsController.text;
                request.promiseDate = promiseDate;
                String url = Urls.baseURL + "employee/invoice/assign/response";
                var response = await api.postDataWithToken(url, request.toJson());
                GeneralErrorResponse generalErrorResponse = GeneralErrorResponse.fromJson(response);
                if (generalErrorResponse.status == "success"){
                  AlertService.showAlertWithAction("Success", generalErrorResponse.message ??  "", onOkPressed: (){
                    Get.deleteAll();
                    Get.offAll(UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0));
                  });
                }
                else{
                  AlertService.showAlert("Failed", generalErrorResponse.message ?? "");
                }


              }
            }),
          )
        ],
      ),
    );
  }

  onDateSelected(date){
    promiseDate = UiHelper.formatDateForServer(date);
  }

  Container other() {
    return Container(
      child: Column(
        children: [
          AppMultilineInput(title: "Comments", controller: commentsController),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GreenButton(title: "Submit", sendingData: submittingPromise, onTap: ()async{
              if (commentsController.text.isEmpty){
                AlertService.showAlert("Alert", "Please enter Comments");
              } else {
                submittingPromise.value = true;
                PromiseDateRequest request = PromiseDateRequest();
                request.invoiceId = "${widget.invoices.id  ?? 0}";
                request.recoveryOfficerId = "${userObj?.data?.id ?? 0}";
                request.responseType = "other";
                request.comment = commentsController.text;
                String url = Urls.baseURL + "employee/invoice/assign/response";
                var response = await api.postDataWithToken(url, request.toJson());
                GeneralErrorResponse generalErrorResponse = GeneralErrorResponse.fromJson(response);
                if (generalErrorResponse.status == "success"){
                  AlertService.showAlertWithAction("Success", generalErrorResponse.message ??  "", onOkPressed: (){
                    Get.deleteAll();
                    Get.off(UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0));
                  });
                }
                else{
                  AlertService.showAlert("Failed", generalErrorResponse.message ?? "");
                }


              }
            }),
          )
        ],
      ),
    );
  }

  submitPayment() async{
    FocusScope.of(context).unfocus();
    if (paymentType == 0) {
      if (cashAmount.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter amount");
      } else {

        InvoiceResponse invoiceResponse = InvoiceResponse();
        invoiceResponse.comment = "paid";
        invoiceResponse.recoveryOfficerId = "${userObj!.data?.id ?? 0}";
        invoiceResponse.responseType = "payment";
        invoiceResponse.invoiceId = "${widget.invoices.id}";
        String url = Urls.baseURL + "employee/invoice/assign/response";


        addingPayment.value = true;
        var response = await api.postDataWithToken(url, invoiceResponse.toJson());
        GeneralErrorResponse generalErrorResponse = GeneralErrorResponse.fromJson(response);

        if (generalErrorResponse.status == "success"){
          InvoicePaymentRequest paymentRequest = InvoicePaymentRequest(is_settlement: settlementOptions.length > 0 ? 1: 0);
          paymentRequest.serviceInvoiceId = "${widget.invoices.id}";
          paymentRequest.paidAmt = "${cashAmount.text}";
          paymentRequest.paymentType = "cash";
          paymentRequest.is_settlement = settlementOptions.length > 0 ? 1: 0;

          String addPaymentURL = Urls.baseURL + "service_invoices/add_payment";
          var response = await api.postDataWithToken(addPaymentURL, paymentRequest.toJson());
          GeneralErrorResponse generalErrorResponse = GeneralErrorResponse.fromJson(response);
          if (generalErrorResponse.status == "success"){
            AlertService.showAlertWithAction("Success", generalErrorResponse.message ??  "", onOkPressed: (){
              Get.deleteAll();
              Get.off(UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0));
            });
          }
          else{
            AlertService.showAlert("Failed", generalErrorResponse.message ?? "");
          }
        }
        else{
          AlertService.showAlert("Failed", generalErrorResponse.message ?? "");
        }
      }
    } else if (paymentType == 1) {
      if (bankId == -1) {
        AlertService.showAlert("Alert", "Please Select Bank");
      } else if (transactionNumber.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter Transaction number");
      } else if (cashAmount.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter amount");
      } else {

        AddPaymentRequest request = AddPaymentRequest(
            is_settlement: settlementOptions.length > 0 ? 1 : 0,
            serviceInvoiceId: "${widget.invoices.id ?? 0}",
            paidAmt: "${cashAmount.text}", description: "desc", bankId: "${bankId}", transectionId: transactionNumber.text, paymentType: "online" );
        String url = Urls.addPaymentForInvoices;
        var response = await api.postDataWithToken(url, request.toJson());
        GeneralErrorResponse generalErrorResponse = GeneralErrorResponse.fromJson(response);
        if (generalErrorResponse.status == "success"){
          AlertService.showAlertWithAction("Success", generalErrorResponse.message ??  "", onOkPressed: (){
            Get.deleteAll();
            Get.off(UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0));
          });
        }
        else{
          AlertService.showAlert("Failed", generalErrorResponse.message ?? "");
        }
      }
    } else if (paymentType == 2) {
      if (transactionNumber.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter Transaction number");
      } else if (cashAmount.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter amount");
      } else {}
    }
  }

  onSelect(index) {
    controller.changeView(index);
  }

  settlementChanged(value){
    settlementOptions = value;
  }
}
