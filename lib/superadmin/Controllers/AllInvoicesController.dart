import 'package:accurate/jsonModels/AdminViewAllInvoices.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllInvoicesController extends GetxController {

  var fetchingData = false.obs;

  var apiStartDate = "".obs;
  var apiEndDate  = "".obs;
  List<AdminViewAllInvoicesData> all = [];
  List<AdminViewAllInvoicesData> paid = [];
  List<AdminViewAllInvoicesData> unpaid = [];

  List<AdminViewAllInvoicesData> selectedTypeList = [];
  var unpaidAmount = 0.0.obs;
  var paidAmount = 0.0.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  void fetchData({required String startDate, required String endDate}) async {
    apiStartDate = "".obs;
    apiEndDate  = "".obs;
    all = [];
    paid = [];
    unpaid = [];

    selectedTypeList = [];
    unpaidAmount = 0.0.obs;
    paidAmount = 0.0.obs;

    fetchingData.value = true;
    String url = '${Urls.baseURL}service_invoices?start_date=$startDate&end_date=$endDate';
    var api = APICall();
    var response = await api.getDataWithToken(url);
    try {
      AdminViewAllInvoices data = AdminViewAllInvoices.fromJson(response);
      apiStartDate.value = data.startDate ?? "";
      apiEndDate.value = data.endDate ?? "";
      print(startDate);
      all = data.data!;

      data.data?.forEach((item){
        if ((item.totalAmt ?? "") == (item.paidAmt ?? "")){
          paidAmount.value += double.parse(item?.paidAmt ?? "");
          paid.add(item);
        }
        else{
          unpaidAmount.value += double.parse(item.totalAmt ?? "");
          unpaid.add(item);
        }
      });

      selectedTypeList = all;
    } catch (e){
      AlertService.showAlert("Error", e.toString());
    }
    fetchingData.value = false;
  }

  void setType(int type){
    /// type == 0 all
    /// type == 1 paid
    /// typpe == 2 unpaid
    fetchingData.value = true;
      if (type == 0){
        selectedTypeList = all;
      } else if (type == 1){
        selectedTypeList = paid;
      } else {
        selectedTypeList = unpaid;
      }
    fetchingData.value = false;
  }

}