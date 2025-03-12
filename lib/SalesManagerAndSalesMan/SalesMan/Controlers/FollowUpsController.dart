import 'package:accurate/jsonModels/FollowUpsResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FollowupsController extends GetxController {

  var fetchingData = true.obs;
  var api = APICall();
  List<FollowUpsResponseData>? visits = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);
    getData(today, today);
  }

  void getData(String start, String end) async{
    fetchingData.value = true;
    String url =  Urls.baseURL +  "visit/filter/get?follow_up_start_date=${start}&follow_up_end_date=${end}";
    var response = await api.getDataWithToken(url);
    FollowUpsResponse followUpsResponse = FollowUpsResponse.fromJson(response);
    visits = followUpsResponse.data ?? [];
    fetchingData.value = false;
  }

}