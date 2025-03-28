import 'package:accurate/AccountantDashboard/Components/DailyReceiveAmountScreen.dart';
import 'package:accurate/jsonModels/DailyReceivesResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReceivedAmountController extends GetxController {

  var fetchingData = false.obs;

  List<DailyReceivesResponseData> data = [];
  List<DailyReceivesResponseData> cash = [];
  List<DailyReceivesResponseData> cheque = [];
  List<DailyReceivesResponseData> online = [];

  double cashTotal = 0.0;
  double chequeTotal = 0.0;
  double onlineTotal = 0.0;

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

      String url = "${Urls.baseURL}company/receives/get?start_date=$start&end_date=$end";
      var api = APICall();
      var response = await api.getDataWithToken(url);
      DailyReceivesResponse receivesResponse = DailyReceivesResponse.fromJson(response);
      for (var item in receivesResponse.data ?? []){
        if (item.paymentType == "cash"){
            cash.add(item);
            cashTotal += double.parse(item.crAmt ?? "0.0");
        } else if (item.paymentType == "cheque"){
          cheque.add(item);
          chequeTotal += double.parse(item.crAmt ?? "0.0");
        } else if (item.paymentType == "online"){
          online.add(item);
          print(item.crAmt);
          onlineTotal += double.parse(item.crAmt ?? "0.0");
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