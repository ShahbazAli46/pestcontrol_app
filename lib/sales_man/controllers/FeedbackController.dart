import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/sales_man/salesManDashboard.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  var sendingData = false.obs;
  String reportId = "0";
  void sendFeedback(String feedback) async{
    sendingData.value = true;
    FeedbackRequest ojb = FeedbackRequest(jobServiceReportId: "${reportId}",forOfficeUse : feedback );
    String url = Urls.sendFeedback;
    var api = new APICall();
    var response = await api.postDataWithToken(url, ojb.toJson());
    GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
    if (errorResponse.status == "success"){
      AlertService.showAlertWithAction("Success", errorResponse?.message ?? "", onOkPressed: (){
        if (userObj?.data?.roleId == 4){
          Get.offAll(()=>SalesManDashboard());
        }
      });
    }
    else{
      AlertService.showAlert("Error", errorResponse?.message ?? "Please try later");
    }
  }
}



class FeedbackRequest {
  String? jobServiceReportId;
  String? forOfficeUse;

  FeedbackRequest({this.jobServiceReportId, this.forOfficeUse});

  FeedbackRequest.fromJson(Map<String, dynamic> json) {
    jobServiceReportId = json['job_service_report_id'];
    forOfficeUse = json['for_office_use'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['job_service_report_id'] = this.jobServiceReportId ?? "";
    data['for_office_use'] = this.forOfficeUse ?? "";
    return data;
  }
}