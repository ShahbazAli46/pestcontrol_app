import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SearchableDropdown.dart';
import 'package:accurate/components/generic/SearchableDropdownWithID.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/CreateQuoteController.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

class CreateQuoteScreen extends StatefulWidget {
  const CreateQuoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuoteScreen> createState() => _CreateQuoteScreenState();
}

class _CreateQuoteScreenState extends State<CreateQuoteScreen> {

  late CreateQuoteController controller;
  final GlobalKey<SearchableDropdownWithIDState> addressKey = GlobalKey<SearchableDropdownWithIDState>();
  final GlobalKey<SearchableDropdownWithIDState> clinetKey = GlobalKey<SearchableDropdownWithIDState>();

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
  }

  @override
  void dispose() {
    if (Get.isRegistered<CreateQuoteController>(tag: Constants.createQuote)) {
      Get.delete<CreateQuoteController>(tag: Constants.createQuote, force: true);
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Create Quote", fontSize: 20),
            SizedBox(height: 20,),
            Obx(()=>controller.fetchingData.value ? UiHelper.loader() : Column(
              children: [
                SearchableDropdownWithID(title: "Select Firm / Client",  key: clinetKey, options: controller.firmNames , onChanged: clientChanged),
              ],
            )),
            Obx(()=>controller.refreshAddress.value ?  Container() : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchableDropdownWithID(title: "Address", options: controller.addresses, key: addressKey, onChanged: addressChanged),
                    AppInput(title: "Quote Title", controller: controller.title),
                    AppInput(title: "Quote Subject", controller: controller.subject),
                    AppInput(title: "Quote Tag", controller: controller.tag),
                    AppInput(title: "Duration in Month", controller: controller.duration,inputType: TextInputType.number),
                    AppMultilineInput(title: "Description", controller: controller.desc),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GreenButton(title: "Next", sendingData: false.obs, onTap: (){
                        controller.processClientInfo();
                      }),
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            )),



          ],
        ),
      ),
    );
  }
  clientChanged(value){
    addressKey.currentState?.clear();
    controller.selectedSelectedAddressID = 0;
    controller.selectedClientID = value.id;
    controller.getAddresses(value.id);
  }
  addressChanged(value){
    controller.selectedSelectedAddressID = value.id;
  }

}
