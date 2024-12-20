import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/sales_man/TypesOfVisit.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/UpcomignJobs/Controllers/JobDetailsController.dart';
import '../controllers/generic/GreenButtonController.dart';
import '../jsonModels/CreateReportRequest.dart';
import '../utils/Constants.dart';
import 'controllers/AddInspectedAreasController.dart';
import 'controllers/ChemicalController.dart';
import 'controllers/PestFoundController.dart';
import 'controllers/SubmitRequestController.dart';
import 'controllers/TreamentMethodController.dart';
import 'controllers/VisitController.dart';

class RecomendationsScreen extends StatefulWidget {
  const RecomendationsScreen({Key? key}) : super(key: key);

  @override
  State<RecomendationsScreen> createState() => _RecomendationsScreenState();
}

class _RecomendationsScreenState extends State<RecomendationsScreen> {
  TextEditingController textEditingController = TextEditingController();
  SubmitRequestController req  = Get.put(SubmitRequestController());
  var sendingData = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20),
            AppTextLabels.boldTextShort(
                label: "Recomendations and Note", fontSize: 20),
            SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  AppMultilineInput(
                    title: "Recomendations ",
                    controller: textEditingController,
                  ),
                  SizedBox(height: 100,),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 20, bottom: 20),
                    child: GreenButton(
                      title: "Create Report",
                      sendingData: req.sendingData,
                      onTap: makeRequest,
                    )
                  )
                ],
              ),
            )),

          ],
        ),
      ),
    );
  }


  makeRequest(){
    if (textEditingController.text.isEmpty){
      AlertService.showAlert("Alert", "Please enter Recomedation text");
    }
    else {
      req.sendData(textEditingController.text!);
    }
  }
}
