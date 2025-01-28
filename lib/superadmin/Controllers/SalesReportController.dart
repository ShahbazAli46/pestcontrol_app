import 'package:accurate/jsonModels/SalesReportHistoryResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SalesReportController extends GetxController {
  var fetchingData = false.obs;

  List<SalesReportHistoryResponseData>? data = [];
  List<SalesReportHistoryResponseData>? allData = [];

  TextEditingController filterController = TextEditingController();// not in use

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
    history.data?.forEach((item) {
      allData?.add(item);
      data?.add(item);
    });
    fetchingData.value = false;
  }


  onFilterChange(String value){
    fetchingData.value = true;
    if (value != ""){
      data?.clear();
      allData?.forEach((item){
        if (item.referencable!.name!.toLowerCase().contains(value.toLowerCase())){
          data!.add(item);
        }
      });
    }
    else{
      allData?.forEach((item) {
        data?.add(item);
      });
    }

    fetchingData.value = false;
  }
}
