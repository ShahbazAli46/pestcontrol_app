import 'dart:io';

import 'package:accurate/components/MultiImagePicker.dart';
import 'package:accurate/components/generic/CameraImagePicker.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/GreenButtonBordered.dart';
import 'package:accurate/components/generic/ImageGrid.dart';
import 'package:accurate/components/generic/ImageUploadWidget.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/IpmRequest.dart';
import 'package:accurate/sales_man/CreateServiceReport.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../jsonModels/GeneralErrorResponse.dart';
import '../utils/Constants.dart';

class AddImagesForIPMReportScreen extends StatefulWidget {
  int serviceID;
  int clinetID;

  AddImagesForIPMReportScreen({required this.serviceID, required this.clinetID});

  @override
  State<AddImagesForIPMReportScreen> createState() => _AddImagesForIPMReportScreenState();
}

class _AddImagesForIPMReportScreenState extends State<AddImagesForIPMReportScreen> {


  var sendingData = false.obs;
  List<File> images = [];
  var apiCall = APICall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
      children: [
        NavWithBack(),
        SizedBox(height: 20,),

        MultiImagePicker(onImagesSelected: _handleImagesSelected),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GreenButton(title: "Submit Images And complete Service", sendingData: sendingData, onTap:(){
                submitImage();
          }),
        )

      ],
    )));
  }

  submitImage(){
    AlertService.showAlertWithCancelButton("Alert", "Are you sure? want to Submit", onOkPressed: (){
      addImages();
    });
  }

  void addImages() async {
    sendingData.value = true;
    DateTime now = DateTime.now();
    String date = UiHelper.formatDateForServer(now);

    var request = IpmRequest();
    request.description= "";
    request.jobId = "${widget.serviceID}";
    request.userClientId = "${widget.clinetID}";
    request.reportDate = date;
    String url = Urls.baseURL + "imp_report/create";
    var response = await apiCall.sendMultipartRequestWithImages("POST", url, data: request.toJson(), images: images, imagesFieldName: "images");
    GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
    if (errorResponse.status == "success"){
      completeJobRequest();
    }
    else{
      sendingData.value = false;
      AlertService.showAlert("Error", errorResponse.message ?? "Please try later");
    }



  }
  _handleImagesSelected(images){
    this.images = images;
  }



  void completeJobRequest() async {
    final url = Urls.completeJob + "${widget.serviceID}";
    var response = await apiCall.getDataWithToken(url);
    GeneralErrorResponse errorResponse =
    GeneralErrorResponse.fromJson(response);
    AlertService.showAlertWithAction(
        "Alert", errorResponse.message ?? "Please try later", onOkPressed: () {
      Future.delayed(Duration(milliseconds: 100), () {
        UiHelper.navigateToNextScreen(
            context,
            CreateServiceReport(
              jobId: widget.serviceID ?? 0,
              fromJob: true,
            ));
      });
    });

  }
}
