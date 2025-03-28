import 'package:accurate/jsonModels/PaymentScreenResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentsController extends GetxController {

  var fetchingData = false.obs;

  double cashTotal = 0.0;
  double chequeTotal = 0.0;
  double onlineTotal = 0.0;

  List<PaymentScreenResponseData> data = [];

  List<PaymentScreenResponseData>  cash = [];
  List<PaymentScreenResponseData>  online = [];
  List<PaymentScreenResponseData>  cheque = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    String startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    getData(startDate, endDate);
  }

  getData(start, end) async{
    fetchingData.value = true;
    cashTotal = 0.0;
    chequeTotal = 0.0;
    onlineTotal = 0.0;
    cash.clear();
    cheque.clear();
    online.clear();
    data.clear();
    String url = Urls.baseURL + "company/payments/get?start_date=$start&end_date=$end";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    PaymentScreenResponse paymentScreenResponse = PaymentScreenResponse.fromJson(response);
    for (var item in paymentScreenResponse.data ?? []){
      print(item.referenceableType);
      if (item.paymentType == "cash"){
        cash.add(item);
        cashTotal += double.parse(item.drAmt ?? "0.0");
      } else if (item.paymentType == "cheque"){
        cheque.add(item);
        chequeTotal += double.parse(item.drAmt ?? "0.0");
      } else if (item.paymentType == "online"){
        online.add(item);
        onlineTotal += double.parse(item.drAmt ?? "0.0");
      }
    }
    data = cash;
    fetchingData.value = false;
  }

  changetype(int index){
    fetchingData.value = true;
    if (index == 0){
      data = cash;
    } else if (index == 1){
      data = cheque;
    } else if (index == 2){
      data = online;
    }
    fetchingData.value = false;
  }






}