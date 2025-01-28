import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/AddAddressRequest.dart';
import 'package:accurate/jsonModels/AddClientRequest.dart';
import 'package:accurate/jsonModels/AddClientResponse.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/ReffereceResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/superadmin/Components/AddAddressScreen.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddClientController extends GetxController {
  var fetchingData = true.obs;
  var sendingData = false.obs;
  var addingAddress = false.obs;
  var selectedButtonType = 0.obs;
  var clientID = 0;
  var api = APICall();
  List<ReffereceResponse> refferences = [];

  List<String> employeeNames = [];
  String refId = "";
  String selectedType = "";


  // edit contorllers for text fields

  TextEditingController clientName = TextEditingController();
  TextEditingController firmName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController industryName = TextEditingController();



  TextEditingController address = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController long = TextEditingController();
  TextEditingController area = TextEditingController();
  String country ="uae";
  String state = "Dubai";
  String city = "Dubai";

  

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRefrences();
  }
  void getRefrences() async{
    fetchingData.value = true;
    String url = Urls.baseURL + "client/references/get";
    try {
      final users = await api.getArrayDataWithToken(url);
      users.forEach((user) {
        if (user['type'] == 'App\\Models\\Vendor') {
          employeeNames.add('${user['name']} - VEN-ID - ${user['id']}');
        } else {
          employeeNames.add('${user['name']} - EMP ID - ${user['id']}');
        }
        refferences.add(ReffereceResponse(name: '${user['name']}', id: '${user['id']}', type: '${user['type']}'));
      });
      fetchingData.value = false;
    } catch (e) {
      print('Error: $e');
    }
  }
  void getId(value, index){
    refId = refferences[index].id ?? "";
    selectedType = refferences[index].type ?? "";
  }

  void addClient() async{
    if (!sendingData.value) {
      if (clientName.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter client name");
      } else if (firmName.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter Firm name");
      } else if (!email.text.isEmail) {
        AlertService.showAlert("Alert", "Please enter valid email ");
      } else if (phone.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter phone number");
      } else if (mobile.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter mobile number");
      } else if (industryName.text.isEmpty) {
        AlertService.showAlert("Alert", "Please enter industry name");
      } else if (refId == "") {
        AlertService.showAlert(
            "Alert", "Please select Refference employee name");
      } else {
        sendingData.value = true;
        AddClientRequest  request = AddClientRequest();
        request.name = clientName.text;
        request.email = email.text;
        request.phoneNumber = phone.text;
        request.mobileNumber = mobile.text;
        request.firmName = firmName.text;
        request.industryName = industryName.text;
        request.referencableId = refId;
        request.referencableType = selectedType;
        request.openingBalance = "0";
        String url = Urls.baseURL + "client/create";
        var response = await api.postDataWithToken(url, request.toJson());
        AddClientResponse clientResponse = AddClientResponse.fromJson(response);
        UiHelper.navigateToNextScreenGetX(AddAddressScreen(clientID: clientResponse.data?.id ?? 0,));
      }
    }

  }

  void addAddress() async{
    if (address.text.isEmpty){
      AlertService.showAlert("Alert", "Please enter address");
    } else if (lat.text.isEmpty){
      AlertService.showAlert("Alert", "Please enter latitude");
    } else if (long.text.isEmpty){
      AlertService.showAlert("Alert", "Please enter longitude");
    } else {
      addingAddress.value = true;
      AddAddressRequest request = AddAddressRequest();
      request.country = country;
      request.state = state;
      request.city = city;
      request.userId = "${clientID}";
      request.address = address.text;
      request.lat = lat.text;
      request.lang = long.text;
      request.area = area.text;

      String url = Urls.baseURL + "client/address/create";
      var response = await api.postDataWithToken(url, request.toJson());
      GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
      if (errorResponse.status == "success"){
         AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
           var screen = UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0);
           Get.offAll(screen);
         });
      }
      else{
        AlertService.showAlert("Alert", errorResponse.message ?? "Please try later");
      }
      addingAddress.value = false;

    }
  }



}