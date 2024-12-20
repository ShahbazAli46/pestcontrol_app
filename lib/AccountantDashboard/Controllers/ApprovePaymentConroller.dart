import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

import '../../jsonModels/PendingPaymentsResponse.dart';

class ApprovePaymentController extends GetxController {

  var fetchingData = false.obs;
  var api = APICall();
  late PendingPaymentsResponse paymentsResponse ;

  int approvingIndex = -1;
  var approvingPayment = false.obs;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  void getData() async{
    approvingIndex = -1;
    approvingPayment.value = false;
    fetchingData.value = true;
    String url= "${Urls.baseURL}received_cash_record";
    var response = await api.getDataWithToken(url);
    paymentsResponse = PendingPaymentsResponse.fromJson(response);
    fetchingData.value = false;
  }

  void approvePayment(int index, int id) async {
    fetchingData.value = true;
    approvingIndex = index;
    approvingPayment.value  = true;
    fetchingData.value = false;
    String url= "${Urls.baseURL}received_cash_record/approve";
    ApprovePaymentRequest request = ApprovePaymentRequest(receivedCashRecordId: "${id}");
    var response = await api.postDataWithToken(url, request.toJson());
    GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
    if (errorResponse.status == "success"){
        AlertService.showAlertWithAction("Success", errorResponse.message ?? "" , onOkPressed: (){
          getData();
        });
    }
    else{
      AlertService.showAlert("Alert", errorResponse.message ?? "");
    }


  }
}




class ApprovePaymentRequest {
  String? receivedCashRecordId;

  ApprovePaymentRequest({this.receivedCashRecordId});

  ApprovePaymentRequest.fromJson(Map<String, dynamic> json) {
    receivedCashRecordId = json['received_cash_record_id'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['received_cash_record_id'] = this.receivedCashRecordId ?? "";
    return data;
  }
}
