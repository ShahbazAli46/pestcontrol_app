

import 'package:accurate/jsonModels/HistoryResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  var fetchingData = false.obs;

  List<HistoryData>? data;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTodayData();
  }

  void getData(start, end) async {
    fetchingData.value = true;
    int id = userObj?.data?.id ?? 0;
    String url = Urls.baseURL + "employee/sales_manager/job/history/${id}?start_date=${start}&end_date=${end}";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    HistoryResponse res  = HistoryResponse.fromJson(response);
    data = res?.data;
    fetchingData.value = false;
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  void getTodayData() {
    String start = formatDate(DateTime.now());
    String end = formatDate(DateTime.now());
    getData(start, end);
  }

}