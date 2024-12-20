import 'package:accurate/jsonModels/AllQuotesResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QuotesController extends GetxController {
  var fetchingData = false.obs;
  var api = APICall();
  List<AllQuotesResponseData>? list;

  List<AllQuotesResponseData>? approved = [];

  List<AllQuotesResponseData>? pending = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchQuotes(
      startDate: DateFormat('yyyy-MM-dd')
          .format(DateTime.now()),
      endDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
  }

  void fetchQuotes({required String startDate, required String endDate}) async {
    fetchingData.value = true;
    list?.clear();
    approved?.clear();
    pending?.clear();

    String url =
        '${Urls.baseURL}quote/all?start_date=$startDate&end_date=$endDate';
    var response = await api.getDataWithToken(url);
    AllQuotesResponse data =  AllQuotesResponse.fromJson(response as Map<String, dynamic>);

    data.data?.forEach((item){
      if (item.isContracted == 0){
        pending!.add(item);
      }
      else{
        approved!.add(item);
      }
    });
    list = approved;
    print(list?.length);
    fetchingData.value = false;
  }

  void changeType(int type){
    // type == 0 approved || type == 1 pending
    fetchingData.value = true;
    if (type == 0){
      list = approved;
    }
    else{
      list = pending;
    }
    fetchingData.value = false;
  }

}
