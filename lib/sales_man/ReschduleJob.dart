import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/AppTimePicker.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/ReschduleRequest.dart';
import 'package:accurate/sales_man/salesManDashboard.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReschduleJob extends StatefulWidget {
  int jobId;

  ReschduleJob({required this.jobId});

  @override
  State<ReschduleJob> createState() => _ReschduleJobState();
}

class _ReschduleJobState extends State<ReschduleJob> {
  final TextEditingController _descriptionController = TextEditingController();

  var sendingData = false.obs;
  var newDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height , // adjust the height
          child: Column(
            children: [
              NavWithBack(),
              SizedBox(
                height: 20,
              ),
              AppTextLabels.boldTextShort(label: "Reschedule ", fontSize: 20),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      AppDatePicker(
                          title: "Select Date", onDateSelected: onDateSelected),

                      AppTimePicker(title: "Job Time", onTimeSelected: onTimeSelected),
                      AppMultilineInput(
                          title: "Reason for Reschedule",
                          controller: _descriptionController),
                      SizedBox(
                        height: 30,
                      ),
                      GreenButton(
                          title: "Submit",
                          sendingData: sendingData,
                          onTap: () {
                            sendData();
                          })
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  onTimeSelected(timeValue){

  }
  onDateSelected(date) {
    newDate = date;
  }

  sendData() async{
    FocusScope.of(context).unfocus();
    if (_descriptionController.text.isEmpty) {
      AlertService.showAlert("Alert", "Please enter reason");
    } else {
      sendingData.value = true;

      ReschduleRequest request = ReschduleRequest();
      request.jobId = "${widget.jobId}";
      request.reason = _descriptionController.text;
      request.jobDate = newDate.toString();
      Map map = request.toJson();
      String url = Urls.reschduleJob;
      APICall apiCall = new APICall();
      var response = await apiCall.postDataWithToken(url, map);
      try {
        GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
        AlertService.showAlertWithAction('Alert', errorResponse.message ?? "Please Try later", onOkPressed : (){
          Get.off(()=>SalesManDashboard());
        });
      } catch(e) {

      }
      sendingData.value = false;
    }
  }
}
