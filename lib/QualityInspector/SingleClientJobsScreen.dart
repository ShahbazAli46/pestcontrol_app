import 'package:accurate/SalesManagerAndSalesMan/SalesMan/SalesManJobsScreen.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SearchableDropdownWithID.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/CreateQuoteController.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleClientJobsScreen extends StatefulWidget {


  @override
  State<SingleClientJobsScreen> createState() => _SingleClientJobsScreenState();
}

class _SingleClientJobsScreenState extends State<SingleClientJobsScreen> {
  late CreateQuoteController controller;
  final GlobalKey<SearchableDropdownWithIDState> clinetKey = GlobalKey<SearchableDropdownWithIDState>();
  final GlobalKey<SearchableDropdownWithIDState> addressKey = GlobalKey<SearchableDropdownWithIDState>();


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
    if (Get.isRegistered<CreateQuoteController>(tag: Constants.createSalesOfficerVisit)) {
      Get.delete<CreateQuoteController>(tag: Constants.createSalesOfficerVisit, force: true);
    }
    super.dispose();
    Get.deleteAll(force: true);
  }

  var clientId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Client Jobs", fontSize: 20),
            SizedBox(height: 20,),
            Obx(()=>controller.fetchingData.value ? UiHelper.loader() : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchableDropdownWithID(title: "Select Firm / Client",  key: clinetKey, options: controller.firmNames , onChanged: clientChanged),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GreenButton(title: "View Jobs", sendingData: false.obs, onTap: (){
                        if (clientId == 0){
                          AlertService.showAlert("Alert", "Please select Client");
                        }
                        else{
                          UiHelper.navigateToNextScreen(context, SalesmanJobsScreen(isSingleClient: true, clientID: clientId,));
                        }

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
    clientId = value.id;
    controller.getAddresses(value.id);
  }
}
