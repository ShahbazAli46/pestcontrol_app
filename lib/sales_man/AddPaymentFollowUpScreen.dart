import 'package:accurate/components/LocationHelper.dart';
import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/PaymentFollowUpRequest.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPaymentFollowUpScreen extends StatefulWidget {
  int clientId;
  AddPaymentFollowUpScreen({required this.clientId});

  @override
  State<AddPaymentFollowUpScreen> createState() => _AddPaymentFollowUpScreenState();
}

class _AddPaymentFollowUpScreenState extends State<AddPaymentFollowUpScreen> {
  int paymentPromiseType = 0;

  TextEditingController descController = TextEditingController();
  final textFiledFoucesNode = FocusNode();

  double? latitude;
  double? longitude;
  var sendingData = false.obs;
  String promiseDate =  DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          NavWithBack(),
          SizedBox(height: 20,),
          AppTextLabels.boldTextShort(label: "Add Payment Follow Up", fontSize: 20),
          SizedBox(height: 20,),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableButtonGroup(titles: ["Promise", "Payment", "Partial Payment"], onSelect: (index){
                    paymentPromiseType = index;
                    setState(() {

                    });
                  }),
                ),
                Column(
                  children: [
                    AppDatePicker(title: "Follow Up Date", onDateSelected: onDateSelected),
                    SizedBox(height: 10,),
                    AppMultilineInput(title: "Description", controller: descController, focusNode: textFiledFoucesNode,),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GreenButton(title: "Submit", sendingData: sendingData, onTap: (){
                        textFiledFoucesNode.unfocus();
                        FocusScope.of(context).unfocus();
                        AlertService.showAlertWithCancelButton("Alert", "Are you sure, want to submit", onOkPressed: (){
                          submitData();

                        });
                      }),
                    )
                  ],
                )
                
                
              ],
            ),
          ))


        ],
      )),
    );
  }

  onDateSelected(date){
    promiseDate =  DateFormat('yyyy-MM-dd').format(date);
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


  void submitData() async{
    if (!sendingData.value) {
      FocusScope.of(context).unfocus();
      sendingData.value = true;
      PaymentFollowUpRequest request = PaymentFollowUpRequest();
      request.clientUserId = "${widget.clientId}";
      request.responseType =
      paymentPromiseType == 0 ? "promise" : paymentPromiseType == 1
          ? "payment"
          : "other";
      request.promiseDate = promiseDate;
      request.other = descController.text;
      request.longitude = "$longitude";
      request.latitude = "$latitude";

      String url = Urls.baseURL + "client/follow_up/create";
      var api = APICall();
      var response = await api.postDataWithToken(url, request.toJson());
      GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
      sendingData.value = false;
      if (errorResponse.status == "success"){
        AlertService.showAlertWithCancelButton("Success", errorResponse.message ?? "Data submitted", onOkPressed: (){
          var home = UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0);
          Get.offAll(home);
        });
      }
      else{
        AlertService.showAlert("Alert", errorResponse.message ?? "Please try later");
      }




    }

  }

}
