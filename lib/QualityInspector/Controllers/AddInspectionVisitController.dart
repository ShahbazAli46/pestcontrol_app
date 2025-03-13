
import 'dart:io';

import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/AddInspectionVisitRequest.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddInspectionVisitController extends GetxController {

  var sendingData = false.obs;
  int selectedClientId = 0;
  int addressID = 0;
  TextEditingController clientRemarks = TextEditingController();
  TextEditingController recommendations = TextEditingController();
  TextEditingController generalComments = TextEditingController();
  TextEditingController nestingArea = TextEditingController();
  List<File>? images;



  void addVisit()async{

    if (selectedClientId == 0){
      AlertService.showAlert("Alert", "Please Select Client");
    } else if (addressID == 0){
      AlertService.showAlert("Alert", "Please Select Address");
    } else if (clientRemarks.text.isEmpty){
      AlertService.showAlert("Alert", "Enter Client Remarks");
    } else if (recommendations.text.isEmpty){
      AlertService.showAlert("Alert", "Enter Recommendations for Operation Team");
    } else if (generalComments.text.isEmpty){
      AlertService.showAlert("Alert", "Enter General Comments");
    }
    else {
      if (!sendingData.value) {
        String url = Urls.addInspectionVisit;
        AddInspectionVisitRequest request = AddInspectionVisitRequest();
        request.userId = "${userObj?.data?.id ?? ""}";
        request.clientRemarks = clientRemarks.text;
        request.recommendationForOperation = recommendations.text;
        request.generalComment = generalComments.text;
        request.nestingArea = nestingArea.text;
        request.userClientId = "$selectedClientId";
        request.addressId = "$addressID";
        sendingData.value = true;
        var api = APICall();
        var response = await api.sendMultipartRequestWithImages(
          'POST',
          url,
          useToken: true,
          data: request.toJson(),
          images: images,
          imagesFieldName: 'pictures',
        );

        sendingData.value = false;
        GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(
            response);
        if (errorResponse.status == "success") {
          AlertService.showAlertWithAction(
              "Alert", errorResponse.message ?? "", onOkPressed: () {
            Get.offAll(() =>
                UiHelper.goToUserDashboardAsPerUserRole(
                    userObj?.data?.roleId ?? 0));
          });
        }
        else {
          AlertService.showAlert("Alert", errorResponse.message ?? "");
        }
      }
    }
  }


}