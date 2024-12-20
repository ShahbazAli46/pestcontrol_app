import 'package:accurate/jsonModels/AllInvoicesResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OutstandingController extends GetxController {
  var fetchingData = false.obs;

  late AllInvoicesResponse invoicesResponse;
  late double thisMonthAmount = 0.0;
  late double lastMonthAmount = 0.0;
  late double thirdMonthAmount = 0.0;
  late double olderThanThreeMonth = 0.0;


  List<InvoicesData> thisMonthData = [];
  List<InvoicesData> lastMonthData = [];
  List<InvoicesData> thirdMonthData = [];
  List<InvoicesData> olderThanMonthData = [];



  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    fetchingData.value = true;
    String url = "${Urls.baseURL}service_invoices";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    invoicesResponse = AllInvoicesResponse.fromJson(response);
    var invoices = invoicesResponse.data!;

    thisMonthAmount = 0.0;
    lastMonthAmount = 0.0;
    thirdMonthAmount = 0.0;
    olderThanThreeMonth = 0.0;

    // Clear previous data
    thisMonthData.clear();
    lastMonthData.clear();
    thirdMonthData.clear();
    olderThanMonthData.clear();

    invoices.forEach((item) {
      if (item.status == "unpaid") {
        double amount = double.parse(item.totalAmt ?? "0.0");

        if (isDateInCurrentMonth(item.issuedDate ?? "")) {
          thisMonthAmount += amount;
          thisMonthData.add(item);
        } else if (isDateInLastMonth(item.issuedDate ?? "")) {
          lastMonthAmount += amount;
          lastMonthData.add(item);
        } else if (isDateInThirdPastMonth(item.issuedDate ?? "")) {
          thirdMonthAmount += amount;
          thirdMonthData.add(item);
        } else if (isDateOlderThanThreeMonths(item.issuedDate ?? "")) {
          olderThanThreeMonth += amount;
          olderThanMonthData.add(item);
        }
      }
    });

    fetchingData.value = false;
  }

  bool isDateInCurrentMonth(String dateString) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  bool isDateInLastMonth(String dateString) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
    DateTime now = DateTime.now();
    DateTime lastMonth = DateTime(now.year, now.month - 1);
    return date.year == lastMonth.year && date.month == lastMonth.month;
  }

  bool isDateInThirdPastMonth(String dateString) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
    DateTime now = DateTime.now();
    DateTime thirdPastMonth = DateTime(now.year, now.month - 2);
    return date.year == thirdPastMonth.year && date.month == thirdPastMonth.month;
  }

  bool isDateOlderThanThreeMonths(String dateString) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateString);
    DateTime now = DateTime.now();
    DateTime threeMonthsAgo = DateTime(now.year, now.month - 3);
    return date.isBefore(threeMonthsAgo);
  }
}