import 'dart:io';

import 'package:accurate/components/LocationHelper.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/SalesOfficerVisitRequest.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddSalesOfficerVisitController extends GetxController {

  var refreshScreen = false.obs;
  var sendingData = false.obs;
  var selectedClientID = 0;
  double? latitude;
  double? longitude;
  var selectedType = "";
  String contractEndData= DateFormat('yyyy-MM-dd').format(DateTime.now());
  String followUpDate= DateFormat('yyyy-MM-dd').format(DateTime.now());
  BuildContext context;
  List<File>? images;
  TextEditingController remarks = TextEditingController();

  AddSalesOfficerVisitController({required this.context});
  int addressID = 0;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(userObj?.data?.id);
    _getLocation();
  }


  void refreshView(){
    refreshScreen.value  = true;
    refreshScreen.value  = false;
  }

  void setSelectedType (type){
    selectedType = type;
  }

  void addVisit()async{
      if (selectedClientID == 0 ){
        AlertService.showAlert("Alert", "Please select client");
      } else if (addressID == 0){
        AlertService.showAlert("Alert", "Please select Address");
      } else if (selectedType == ""){
        AlertService.showAlert("Alert", "Please select Status");
      } else if (remarks.text == ""){
        AlertService.showAlert("Alert", "Please enter reamkrs");
      } else if (images?.length == 0){
        AlertService.showAlert("Alert", "Please enter remarks");
      }
      else{
        sendingData.value = true;
          String url = Urls.baseURL + "visit/create";
          SalesOfficerVisitRequest request = SalesOfficerVisitRequest();
          request.userId = "${userObj?.data?.id ?? 0}";
          request.description = remarks.text;
          request.currentContractEndDate = contractEndData;
          request.visitDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
          request.latitude = "${latitude}";
          request.status = selectedType;
          request.longitude = "${longitude}";
          request.userClientId = "${selectedClientID}";
          request.followUpDate = followUpDate;
          request.client_address_id = "${addressID}";

          var api = APICall();
        var response = await api.sendMultipartRequestWithImages(
          'POST',
          url,
          useToken: true,
          data: request.toJson(),
          images: images,
          imagesFieldName: 'images',
        );

        sendingData.value = false;
        GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
        if (errorResponse.status == "success"){
            AlertService.showAlertWithAction("Alert", errorResponse.message ?? "", onOkPressed: (){
              Get.offAll(()=>UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0));
            });
        }
        else{
          AlertService.showAlert("Alert", errorResponse.message ?? "");
        }

      }
  }




  final LocationService _locationService = LocationService();
  Future<void> _getLocation() async {
    try {
      final position = await _locationService.getCurrentLocation(context);
      latitude = position.latitude;
      longitude = position.longitude;
      print("Locations adde");
    } on LocationServiceException catch (e) {

    }
  }




}