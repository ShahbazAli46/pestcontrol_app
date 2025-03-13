import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/InspectorVisitsResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InspectorVisitsController extends GetxController {

  var fetchingData = false.obs;

  List<InspectorVisitsResponseData>? data  = [];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTodayData();
  }

  void getTodayData() {
    String start = formatDate(DateTime.now());
    String end = formatDate(DateTime.now());
    getData(start, end);
  }
  getData(start, end)async{
    data?.clear();
    fetchingData.value = true;
    String url = "${Urls.baseURL}inspection/report/get?start_date=$start&end_date=$end";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    InspectorVisitsResponse visitsResponse = InspectorVisitsResponse.fromJson(response);
    data = visitsResponse.data ?? [];
    fetchingData.value = false;
  }


  String formatDate(DateTime date) {
    return UiHelper.formatDateForServer(date);
  }
}