import 'dart:io';
import 'package:accurate/components/SignaturePad.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/sales_man/TypesOfVisit.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

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


  @override
  State<RecomendationsScreen> createState() => _RecomendationsScreenState();
}

class _RecomendationsScreenState extends State<RecomendationsScreen> {
  TextEditingController textEditingController = TextEditingController();
  late SubmitRequestController req;
  var sendingData = false.obs;

  var isSignatureScreen = false;

  final signatureKey = GlobalKey<SignaturePadState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    req  = Get.put(SubmitRequestController());
    req.context = context;
  }


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
                label: isSignatureScreen ? "Add Client Signature":"Recomendations and Note", fontSize: 20),
            SizedBox(height: 20),
            isSignatureScreen ? Column(
              children: [
                SignaturePad(
                  key: signatureKey,
                  strokeColor: AppColors.appGreen,
                  strokeWidth: 1.0,
                ),
                SizedBox(height: 20,),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 20, bottom: 20),
                    child: GreenButton(
                      title: "Submit",
                      sendingData: req.sendingData,
                      onTap: makeRequest,
                    )
                )
              ],
            ) :
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  AppMultilineInput(
                    title: "Recomendations ",
                    controller: textEditingController,
                  ),
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


  makeRequest()async{
    if (textEditingController.text.isEmpty){
      AlertService.showAlert("Alert", "Please enter Recomedation text");
    }
    else {

      req.sendData(textEditingController.text);

    }
  }

  Future<File> uint8ListToFile(Uint8List uint8list) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(uint8list as List<int>);
    return file;
  }
}
