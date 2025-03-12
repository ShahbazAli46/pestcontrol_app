import 'package:accurate/jsonModels/AllJobsResponse.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../jsonModels/TeamListResponse.dart';

class SalesManJobsController extends GetxController {
  var fetchingData = true.obs;

  var api  = APICall();

  List<CaptainJobs>? data = [];
  List<CaptainJobs> completed = [];
  List<CaptainJobs> pending = [];
  List<CaptainJobs> allData  = [];

  double pendingAmount = 0.0;
  double completedAmount = 0.0;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);
    getData(today, today);

  }


  void getData(start, end)async{
    fetchingData.value = true;
    completed.clear();
    pending.clear();
    completedAmount = 0.0;
    pendingAmount = 0.0;
    String url = Urls.baseURL + "employee/reference/jobs/get/${userObj?.data?.id}?start_date=${start}&end_date=${end}";
    var response = await api.getDataWithToken(url);
    AllJobsResponse res = AllJobsResponse.fromJson(response);
    res.data?.forEach((item){
      if (item.isCompleted == 1){
        completed?.add(item);
        completedAmount += double.parse(item.grandTotal ?? "0");
      }
      else{
        pending?.add(item);
        pendingAmount += double.parse(item.grandTotal ?? "0");
      }
    });
    data = completed;
    fetchingData.value = false;
  }

  handleButtonTypeChange(int type){
    fetchingData.value = true;

    if (type == 0){
      data = completed;
    }
    else
      {
        data = pending;
      }



    fetchingData.value = false;

  }
}