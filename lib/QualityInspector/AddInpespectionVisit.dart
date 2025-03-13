import 'package:accurate/QualityInspector/Controllers/AddInspectionVisitController.dart';
import 'package:accurate/components/MultiImagePicker.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SearchableDropdownWithID.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/CreateQuoteController.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInspectionVisit extends StatefulWidget {
  const AddInspectionVisit({Key? key}) : super(key: key);

  @override
  State<AddInspectionVisit> createState() => _AddInspectionVisitState();
}

class _AddInspectionVisitState extends State<AddInspectionVisit> {

  late CreateQuoteController controller;
  final GlobalKey<SearchableDropdownWithIDState> clinetKey = GlobalKey<SearchableDropdownWithIDState>();
  final GlobalKey<SearchableDropdownWithIDState> addressKey = GlobalKey<SearchableDropdownWithIDState>();
  late AddInspectionVisitController inspectionVisitController;

  @override
  void initState() {
    super.initState();
    // Force remove any existing instance first
    if (Get.isRegistered<CreateQuoteController>(tag: Constants.createQuote)) {
      Get.delete<CreateQuoteController>(tag: Constants.createQuote, force: true);
    }

    controller = Get.put(
      CreateQuoteController(),
      tag: Constants.createQuote,
      permanent: false,
    );

    inspectionVisitController = Get.put(AddInspectionVisitController());
  }

  @override
  void dispose() {
    if (Get.isRegistered<CreateQuoteController>(tag: Constants.createSalesOfficerVisit)) {
      Get.delete<CreateQuoteController>(tag: Constants.createSalesOfficerVisit, force: true);
    }
    super.dispose();
    Get.deleteAll(force: true);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Add Inspection", fontSize: 20),
            SizedBox(height: 20,),
            Obx(()=>controller.fetchingData.value ? CircularProgressIndicator() : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchableDropdownWithID(title: "Select Firm / Client",  key: clinetKey, options: controller.firmNames , onChanged: clientChanged),
                    SearchableDropdownWithID(title: "Address", options: controller.addresses, key: addressKey, onChanged: addressChanged),
                    AppMultilineInput(title: "Client Remarks", controller: inspectionVisitController.clientRemarks),
                    AppMultilineInput(title: "Recommendations for Operations ", controller: inspectionVisitController.recommendations),
                    AppMultilineInput(title: "General Comments ", controller: inspectionVisitController.generalComments),
                    AppMultilineInput(title: "Nesting Areas", controller: inspectionVisitController.nestingArea),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GreenButton(title: "Add Inspection Visit", sendingData: inspectionVisitController.sendingData, onTap: (){
                        inspectionVisitController.addVisit();
                      }),
                    )
                  ],
                ),
              ),
            )),


          ],
        )));
  }

  clientChanged(value){
    addressKey.currentState?.clear();
    controller.selectedSelectedAddressID = 0;
    controller.selectedClientID = value.id;
    inspectionVisitController.selectedClientId = value.id;
    controller.getAddresses(value.id);
  }

  addressChanged(value){
    if (value != null){
      inspectionVisitController.addressID = value.id;
    }

  }

  _handleImagesSelected(images){
    inspectionVisitController.images = images;
  }
}
