import 'package:accurate/jsonModels/FollowUpsResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewVisitsController extends GetxController {

  var fetchingData = true.obs;
  var api = APICall();

  List<FollowUpsResponseData>? visits = [];


  var total = 0;
  var interested = 0;
  var notInterested = 0;
  var contracted = 0;
  var quoted = 0;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);
    getData(today, today);

  }

  getData(String start, String end)async{
    fetchingData.value = true;
    total = 0;
    interested = 0;
    notInterested = 0;
    contracted = 0;
    quoted = 0;
    String url = Urls.baseURL + "visit/get/${userObj?.data?.id ?? 0}?start_date=${start}&end_date=${end}";
    var response = await api.getDataWithToken(url);
    FollowUpsResponse followUpsResponse = FollowUpsResponse.fromJson(response);
    visits = followUpsResponse.data ?? [];

    total = visits?.length ?? 0;
    followUpsResponse.data?.forEach((item){
      if (item.status == Constants.interested){
        interested +=1;
      } else if (item.status == Constants.notInterested){
        notInterested += 1;
      } else if (item.status == Constants.contracted){
        contracted += 1;
      }
      else if (item.status == Constants.quoted){
        quoted += 1;
      }
    });


    fetchingData.value = false;
  }

}