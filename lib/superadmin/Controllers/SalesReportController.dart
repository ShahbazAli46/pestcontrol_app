import 'package:accurate/jsonModels/SalesReportHistoryResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesReportController extends GetxController {
  var fetchingData = false.obs;

  List<SalesReportHistoryResponseData>? data;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM").format(now);
    getData(formattedDate);
  }

  void getData(String date) async {
    fetchingData.value = true;
    String url = Urls.salesHistory + date;
    var api = APICall();
    var response = await api.getDataWithToken(url);
    SalesReportHistoryResponse history =
        SalesReportHistoryResponse.fromJson(response);
    data = history.data;
    fetchingData.value = false;
  }
}
