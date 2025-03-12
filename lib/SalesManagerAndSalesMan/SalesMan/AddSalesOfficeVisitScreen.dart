import 'package:accurate/SalesManagerAndSalesMan/SalesMan/Controlers/AddSalesOffierVisitController.dart';
import 'package:accurate/components/LocationHelper.dart';
import 'package:accurate/components/MultiImagePicker.dart';
import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SearchableDropdownWithID.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/CreateQuoteController.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddSalesOfficeVisitScreen extends StatefulWidget {
  const AddSalesOfficeVisitScreen({Key? key}) : super(key: key);

  @override
  State<AddSalesOfficeVisitScreen> createState() => _AddSalesOfficeVisitScreenState();
}

class _AddSalesOfficeVisitScreenState extends State<AddSalesOfficeVisitScreen> {
  late CreateQuoteController controller;
  final GlobalKey<SearchableDropdownWithIDState> clinetKey = GlobalKey<SearchableDropdownWithIDState>();
  final GlobalKey<SearchableDropdownWithIDState> addressKey = GlobalKey<SearchableDropdownWithIDState>();

  late AddSalesOfficerVisitController visitController;




  @override
  void initState() {
    super.initState();
    // Force remove any existing instance first
    if (Get.isRegistered<CreateQuoteController>(tag: Constants.createQuote)) {
      Get.delete<CreateQuoteController>(tag: Constants.createQuote, force: true);
    }
    if (Get.isRegistered<AddSalesOfficerVisitController>(tag: Constants.createSalesOfficerVisit)) {
      Get.delete<AddSalesOfficerVisitController>(tag: Constants.createSalesOfficerVisit, force: true);
    }
    controller = Get.put(
      CreateQuoteController(),
      tag: Constants.createQuote,
      permanent: false,
    );
    visitController = Get.put(
      AddSalesOfficerVisitController(context: context),
      tag: Constants.createSalesOfficerVisit,
      permanent: false,
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<CreateQuoteController>(tag: Constants.createSalesOfficerVisit)) {
      Get.delete<CreateQuoteController>(tag: Constants.createSalesOfficerVisit, force: true);
    }

    if (Get.isRegistered<AddSalesOfficerVisitController>(tag: Constants.createSalesOfficerVisit)) {
      Get.delete<AddSalesOfficerVisitController>(tag: Constants.createSalesOfficerVisit, force: true);
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
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Add Visit", fontSize: 20),
            SizedBox(height: 20,),
            Obx(()=> visitController.refreshScreen.value ? Container() : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(()=>controller.fetchingData.value ? CircularProgressIndicator() : Column(
                      children: [
                        SearchableDropdownWithID(title: "Select Firm / Client",  key: clinetKey, options: controller.firmNames , onChanged: clientChanged),

                      ],
                    )),
                    SearchableDropdownWithID(title: "Address", options: controller.addresses, key: addressKey, onChanged: addressChanged),
                    AppDropdown(title: "Status", options: [Constants.interested, Constants.notInterested, Constants.contracted, Constants.quoted], onChanged: statusChange),
                    visitController.selectedType == "Interested" || visitController.selectedType == "Quoted" ? AppDatePicker(title: "Follow Up Date", onDateSelected: followUpDateChange):Container(),

                    visitController.selectedType == "Contracted" ? AppDatePicker(title: "Current Contract End Date", onDateSelected: currentContractEndData) : Container(),
                    SizedBox(height: 20,),
                    AppMultilineInput(title: "Remarks", controller: visitController.remarks),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MultiImagePicker(
                        onImagesSelected: _handleImagesSelected,
                        maxImages: 9,
                        crossAxisCount: 3,
                        spacing: 8,
                      ),
                    ),

                    SizedBox(height: 20,),
                    Padding(padding: EdgeInsets.all(8), child: GreenButton(title: "Add Visit", sendingData: visitController.sendingData, onTap: (){
                      if(!visitController.sendingData.value){
                        visitController.addVisit();
                      }
                    },),)
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  clientChanged(value){
    addressKey.currentState?.clear();
    controller.selectedSelectedAddressID = 0;
    controller.selectedClientID = value.id;
    visitController.selectedClientID= value.id;
    controller.getAddresses(value.id);

  }

  statusChange(type, index){
    visitController.setSelectedType(type);
    visitController.refreshView();
  }

  currentContractEndData(date){
    visitController.contractEndData =  DateFormat('yyyy-MM-dd').format(date);
  }

  _handleImagesSelected(images){
      visitController.images = images;
  }

  followUpDateChange(date){
    visitController.followUpDate = DateFormat('yyyy-MM-dd').format(date);
  }

  addressChanged(value){
    if (value != null){
      controller.selectedSelectedAddressID = value.id;
      visitController.addressID = value.id;
    }

  }
}