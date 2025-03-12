import 'package:accurate/jsonModels/AllJobsResponse.dart';
import 'package:accurate/jsonModels/SalesManCompletedJobsResponse.dart';
import 'package:accurate/jsonModels/SalesmanIncomeResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../jsonModels/SalesOfficerTargetResponse.dart';

class SalesOfficerDashboardController extends GetxController {
  var fetchingData = true.obs;
  late EmpContractTargets targets = EmpContractTargets();
  late EmployeeCommissions commissions = EmployeeCommissions();
  List<SalesmanIncomeResponseData>? data;
  double completedAmount = 0.0;

  var api = APICall();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getThisMonthData();
  }

  void getThisMonthData() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM').format(now);
    getData(formattedDate);
  }

  void getData(String date) async {
    fetchingData.value = true;
    String url = Urls.baseURL +
        "employee/contract/target/get/${userObj?.data?.id}/${date}";
    var response = await api.getDataWithToken(url);
    SalesOfficerTargetResponse targetResponse =
        SalesOfficerTargetResponse.fromJson(response);
    if (targetResponse.data!.empContractTargets!.length > 0) {
      targets = targetResponse.data!.empContractTargets![0];
      commissions = targetResponse.data!.employeeCommissions![0];
    } else {
      targets.contractTarget = "0.0";
      targets.achievedTarget = "0.0";
    }

    List<String> parts = date.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);

    // First date of the month
    DateTime firstDate = DateTime(year, month, 1);

    // Last date of the month
    DateTime nextMonth = DateTime(year, month + 1, 1);
    DateTime lastDate = nextMonth.subtract(Duration(days: 1));

    // Formatting dates
    var formatter = DateFormat('yyyy-MM-dd');
    String firstDateString = formatter.format(firstDate);
    String lastDateString = formatter.format(lastDate);
    getInvoices(firstDateString, lastDateString);
  }

  onMonthChanged(date) {
    getData(date);
  }

  getInvoices(start, end) async {
    completedAmount = 0.0;
    String url = "${Urls.baseURL}employee/reference/jobs/get/${userObj?.data?.id ?? 0}?start_date=${start}&end_date=${end}";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    SalesManCompletedJobsResponse completedJobsResponse = SalesManCompletedJobsResponse.fromJson(response);
    completedJobsResponse.data?.forEach((item){
      if (item.isCompleted == 1){
        completedAmount += double.parse(item.grandTotal ?? "");
      }

    });
    fetchingData.value = false;
  }
}
