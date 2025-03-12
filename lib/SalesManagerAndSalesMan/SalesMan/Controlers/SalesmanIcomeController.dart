import 'package:accurate/jsonModels/SalesmanIncomeResponse.dart';
import 'package:accurate/jsonModels/SalesmanReceivedAmountResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesmanIncomeController extends GetxController {
  
  var fetchingData = true.obs;
  int userId;
  SalesmanIncomeController({required this.userId});
  List<SalesmanReceivedAmountResponseData> data  = [];
  List<SalesmanReceivedAmountResponseData> completed  = [];
  List<SalesmanReceivedAmountResponseData> pending = [];
  double completedAmount = 0.0;
  double pendingAmount = 0.0;
  
  

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);
    getData(today, today);
  }

  getData(start, end) async{
    pendingAmount = 0.0;
    completedAmount = 0.0;
    data.clear();
    completed.clear();
    pending.clear();
    fetchingData.value = true;
    String url = Urls.baseURL + "employee/reference/income/get/${userId}?start_date=${start}&end_date=${end}";
    var api = APICall();
    var response  = await api.getDataWithToken(url);
    SalesmanReceivedAmountResponse receivedAmountResponse = SalesmanReceivedAmountResponse.fromJson(response);
    data = receivedAmountResponse.data ?? [];
    for (var item in data) {
      List<AmountHistory> allPaid = filterHistoryByDate(item!.amountHistory ?? [], start, end);
      print(allPaid.length);
      for (var paidItem in allPaid) {
        completedAmount += double.parse(paidItem.paidAmt ?? "0.0");
      }
      if (item.status == "paid"){
        completed.add(item);
      }
      else{
        pendingAmount+= double.parse(item.totalAmt ?? "0.0") - double.parse(item.paidAmt ?? "0.0");
        pending.add(item);
      }
    }

    data = completed;
    fetchingData.value = false;
  }

  handleChange (type){
    fetchingData.value = true;
      if (type == 0){
        data = completed;
      }
      else{
        data = pending;
      }
    fetchingData.value = false;

  }


  List<AmountHistory> filterHistoryByDate(
      List<AmountHistory> historyList,
      String startDate,
      String endDate,
      ) {
    return historyList
        .where((history) =>
    DateTime.parse(history.createdAt!).isAfter(DateTime.parse(startDate).subtract(Duration(days: 1))) &&
        DateTime.parse(history.createdAt!).isBefore(DateTime.parse(endDate).add(Duration(days: 1)))
    )
        .toList();
  }

}