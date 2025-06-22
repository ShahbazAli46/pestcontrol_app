
import 'package:accurate/jsonModels/SalesManReportResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesManController extends GetxController {

  var fetchingData = true.obs;
  var api = APICall();

  List<SalesManReportResponseData>? data;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('yyyy-MM').format(now);
    getData(currentMonth);
  }


  getData(dateRange) async{
    fetchingData.value = true;
    String url = Urls.baseURL + "employee/sales_man/get/${dateRange}";
    var response = await api.getDataWithToken(url);
    SalesManReportResponse salesManReportResponse = SalesManReportResponse.fromJson(response);
    data?.clear();
    data = salesManReportResponse.data;
    fetchingData.value = false;
  }


  onDateChange(start){
  getData(start);
  }

}