import 'package:accurate/jsonModels/SingleExpenseDetailsResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class SingleExpenseDetailsController extends GetxController {

  var fetchingData = false.obs;
  var expesnseId = 0;
  var startDate = "".obs;
  var endDate = "".obs;
  var total = 0.0;

  late SingleExpenseDetailsResponse singleExpenseDetailsResponse;
  SingleExpenseDetailsController({required this.expesnseId});

  List<String> cats = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentMonthData();


  }
  void getCurrentMonthData() {
    DateTime now = DateTime.now();
    String startDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-01';
    String endDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${DateTime(now.year, now.month + 1, 0).day.toString().padLeft(2, '0')}';
    this.startDate.value = startDate;
    this.endDate.value = endDate;
    getDetails(startDate, endDate);
  }

  void getDetails(String startDate, String endDate) async{
    total = 0.0;
    this.startDate.value = startDate;
    this.endDate.value = endDate;
    fetchingData.value = true;
    String url = "${Urls.baseURL}expense_category/${expesnseId}?start_date=${startDate}&end_date=${endDate}";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    singleExpenseDetailsResponse = SingleExpenseDetailsResponse.fromJson(response);
    singleExpenseDetailsResponse.data?.expenses?.forEach((item){
      total += double.parse(item.amount ?? "0.0");
    });
    fetchingData.value = false;

  }

}