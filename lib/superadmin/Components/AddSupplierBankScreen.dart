import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/SingleSupplierController.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/UAEBankValidator.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSupplierBankScreen extends StatefulWidget {
  int supplierId;
  String supplierCompanyName;
  AddSupplierBankScreen({required this.supplierId, required this.supplierCompanyName});

  @override
  State<AddSupplierBankScreen> createState() => _AddSupplierBankScreenState();
}

class _AddSupplierBankScreenState extends State<AddSupplierBankScreen> {


  TextEditingController bankNameController = TextEditingController();
  TextEditingController IBANController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  SingleSupplierController controller = Get.find(tag: "suppliers");

  var sendingData = false.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
      children: [
        NavWithBack(),
        SizedBox(height: 20,),
        AppTextLabels.boldTextShort(label: "Add Bank", fontSize: 20),
        SizedBox(height: 20,),
        AppTextLabels.regularShortText(label: "${widget.supplierCompanyName}", color: AppColors.appBlack),
        SizedBox(height: 10,),
        AppInput(title: "Bank Name", controller: bankNameController),
        AppInput(title: "IBAN", controller: IBANController,),
        AppInput(title: "Account Number", controller: accountNumberController, inputType: TextInputType.number,),
        AppInput(title: "Address", controller: addressController),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GreenButton(title: "Submit", sendingData: controller.addingBank, onTap: submit),
        )
      ],
    )));
  }

  submit(){
    if (!controller.addingBank.value) {
      if (bankNameController.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter Bank Name");
      } else if (!UAEBankValidator.isValidAccountNumber(
          accountNumberController.text)) {
        AlertService.showAlert("Alert", "Please enter a valid account number");
      } else if (!UAEBankValidator.isValidUAEIBAN(IBANController.text)) {
        AlertService.showAlert("Alert", "Please enter a valid IBAN");
      } else if (addressController.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter ");
      }
      else {
        controller.addBank(bankName: bankNameController.text,
            iban: IBANController.text,
            account: addressController.text,
            address: addressController.text);
      }
    }
  }
}
