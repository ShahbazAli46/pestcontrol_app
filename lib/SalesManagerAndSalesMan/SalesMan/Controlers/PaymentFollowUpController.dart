
import 'package:accurate/jsonModels/PaymentFollowUpsResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentFollowUpController extends GetxController {
  var fetchingData = false.obs;

  List<PaymentFollowUpsResponseData> data = [];
  List<FollowUpInfo> info = [];
  List<FollowUpInfo> filtered = [];
  List<FollowUpInfo> allFollowUps = [];


  @override
  void onInit() {
    super.onInit();

    getTodayData();
  }


  void getData(start, end) async{
    fetchingData.value = true;
    allFollowUps.clear();
    String url = Urls.baseURL + "client/follow_up/get?start_date=$start&end_date=$end";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    PaymentFollowUpsResponse paymentFollowUpsResponse = PaymentFollowUpsResponse.fromJson(response);

    allFollowUps = transformData(paymentFollowUpsResponse.data ?? []);
    print(allFollowUps.length);
    if (userObj?.data?.roleId == 1){
      allFollowUps.forEach((value){
        info.add(value);
      });
    }
    else{
      allFollowUps.forEach((value){
        if (value.salesManId == userObj?.data?.id){
          info.add(value);
        }
      });
    }
    fetchingData.value = false;
  }

  filter(int index){
    fetchingData.value = true;
    if (index == 0){
      info.clear();
      allFollowUps.forEach((followUp){
        if (userObj?.data?.roleId == 1){
          info.add(followUp);
        }
        else{
          if (followUp.salesManId == userObj?.data?.id){
            info.add(followUp);
          }
        }

      });
    } else if (index == 1){
      info.clear();

      allFollowUps.forEach((followUp){
        if (userObj?.data?.roleId == 1 && followUp.status == "completed"){
          info.add(followUp);
        }
       else{
         if (followUp.salesManId == userObj?.data?.id && followUp.status == "completed"){
           info.add(followUp);
         }
       }
      });
    } else if (index == 2){
      info.clear();
      allFollowUps.forEach((followUp){
        if (userObj?.data?.roleId == 1 && followUp.status == "pending"){
          info.add(followUp);
        }
        else{
          if (followUp.salesManId == userObj?.data?.id && followUp.status == "pending"){
            info.add(followUp);
          }
        }

      });
    }

    fetchingData.value = false;
  }



  void getTodayData() {
    String start = formatDate(DateTime.now());
    String end = formatDate(DateTime.now());
    getData(start, end);
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }


  List<FollowUpInfo> transformData(List<PaymentFollowUpsResponseData> data) {
    List<FollowUpInfo> transformed = [];
    for (var item in data) {
      final salesMan = item.clientUser?.client?.referencable?.name ?? "";
      final firmName = item.clientUser?.client?.firmName ?? "";
      final followUps = item.clientFollowDetailUps ?? [];
      for (var followUp in followUps) {

        FollowUpInfo info = FollowUpInfo(salesMan: salesMan, firmName: firmName, recoveryPersonName: followUp.employeeUser?.name ?? "", followUpDate: followUp.promiseDate ?? "", nextFollowUpDate: followUp.nextPromiseDate ?? "", latlong: "${followUp.longitude},${followUp.longitude}", status: item.completedAt== null ? "pending":"completed", salesManId: item.clientUser?.client?.referencableId ?? 0, desc: followUp.other ?? "");
        transformed.add(info);

      }
    }

    return transformed;
  }
}