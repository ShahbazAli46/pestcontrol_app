import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelQuoteScreen extends StatefulWidget {
  int quoteId;

  CancelQuoteScreen({required this.quoteId});
  @override
  State<CancelQuoteScreen> createState() => _CancelQuoteScreenState();
}

class _CancelQuoteScreenState extends State<CancelQuoteScreen> {



  TextEditingController reason = TextEditingController();

  var sendingData = false.obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Cancel Quote", fontSize: 20),
            SizedBox(height: 20,),
            Expanded(child: SingleChildScrollView(child: Column(
              children: [
                AppMultilineInput(title: "Reasone", controller: reason),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GreenButton(title: "Submit", sendingData: sendingData, onTap: ()async {
                    if (reason.text.length < 5){
                      AlertService.showAlert("Alert", "Please enter a valid reason");
                    }
                    else{
                      sendingData.value = true;
                      String url = Urls.baseURL + "quote/move/cancel/${widget.quoteId}";
                      var api = APICall();
                      CancelQuoteRequest cancel = CancelQuoteRequest();
                      cancel.contractCancelReason = reason.text;
                      var response = await api.postDataWithToken(url, cancel.toJson());
                      GeneralErrorResponse errorResponse  = GeneralErrorResponse.fromJson(response);
                      if (errorResponse.status == "success"){
                        AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
                          var home = UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0);
                          Get.offAll(()=>home);
                        });
                      }
                      else{
                        AlertService.showAlert("Alert", errorResponse.message ?? "");
                      }
                      sendingData.value = false;
                    }
                  }),
                )



              ],
            )))
          ],
        ),
      ),
    );
  }
}


class CancelQuoteRequest {
  String? contractCancelReason;

  CancelQuoteRequest({this.contractCancelReason});

  CancelQuoteRequest.fromJson(Map<String, dynamic> json) {
    contractCancelReason = json['contract_cancel_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contract_cancel_reason'] = this.contractCancelReason;
    return data;
  }
}
