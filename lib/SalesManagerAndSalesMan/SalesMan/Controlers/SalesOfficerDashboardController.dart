import 'package:accurate/jsonModels/AllJobsResponse.dart';
import 'package:accurate/jsonModels/SalesManCompletedJobsResponse.dart';
import 'package:accurate/jsonModels/SalesManContractsResponse.dart';
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

  double allContracts = 0.0;
  double allContractValue = 0.0;
  double completedContracts = 0.0;
  double completedContractAmount = 0.0;
  double canceledContracts = 0.0;
  double cancelContractsAmount = 0.0;
  double activeContracts = 0.0;
  double activeContractAmount = 0.0;
  List<SalesManContractsResponseData> contractsList = [];
  List<SalesManContractsResponseData> activeContractsList = [];
  List<SalesManContractsResponseData> canceledContractsList = [];
  List<SalesManContractsResponseData> completedContractsList = [];
  List<SalesManContractsResponseData> listToShowContracts = [];

  List<SalesManContractsResponseData> allFiltered = [];
  double allFilteredAmount = 0.0;
  List<SalesManContractsResponseData> filteredActiveContractsList = [];
  double filteredActiveAmount = 0.0;
  List<SalesManContractsResponseData> filteredCanceledContractsList = [];
  double filteredCanceledAmount = 0.0;
  List<SalesManContractsResponseData> filteredCompletedContractsList = [];
  double filteredCompletedAmount = 0.0;

  var api = APICall();

  var gettingContracts = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getThisMonthData();
    getContracts();
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
    String url =
        "${Urls.baseURL}employee/reference/jobs/get/${userObj?.data?.id ?? 0}?start_date=${start}&end_date=${end}";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    SalesManCompletedJobsResponse completedJobsResponse =
        SalesManCompletedJobsResponse.fromJson(response);
    completedJobsResponse.data?.forEach((item) {
      if (item.isCompleted == 1) {
        completedAmount += double.parse(item.grandTotal ?? "");
      }
    });
    fetchingData.value = false;
  }

  getContracts() async {
    gettingContracts.value = true;
    String url =
        "${Urls.baseURL}quote/contracted?employee_user_id=${userObj?.data?.id ?? 0}";
    var response = await api.getDataWithToken(url);
    SalesManContractsResponse salesManContractsResponse =
        SalesManContractsResponse.fromJson(response);
    for (var item in salesManContractsResponse.data ?? []){
      contractsList.add(item);
      allFiltered.add(item);
    }
    allContracts = double.parse("${salesManContractsResponse?.data?.length}");
    for (var item in contractsList) {
      allContractValue += double.parse(item.grandTotal ?? "0.0");
      allFilteredAmount += double.parse(item.grandTotal ?? "0.0");
      if (item.contractCancelledAt != null) {
        canceledContracts++;
        cancelContractsAmount += double.parse(item.grandTotal ?? "0.0");
        canceledContractsList.add(item);

        filteredCanceledContractsList.add(item);
        filteredCanceledAmount += double.parse(item.grandTotal ?? "0.0");
      } else if (item.jobs?[0].totalJobs == item.jobs?[0].completedJobs) {
        completedContracts++;
        completedContractAmount += double.parse(item.grandTotal ?? "0.0");
        completedContractsList.add(item);

        filteredCompletedAmount += double.parse(item.grandTotal ?? "0.0");
        filteredCompletedContractsList.add(item);
      } else {
        activeContracts++;
        activeContractAmount += double.parse(item.grandTotal ?? "0.0");
        activeContractsList.add(item);

        filteredActiveAmount += double.parse(item.grandTotal ?? "0.0");
        filteredActiveContractsList.add(item);
      }
    }
    listToShowContracts = contractsList;
    gettingContracts.value = false;
  }

  setContractsType(int type) {
    gettingContracts.value = true;
    var selectedList ;
    if (type == 0) {
      selectedList = allFiltered;
    } else if (type == 1) {
      selectedList = filteredActiveContractsList;
    } else if (type == 2) {
      selectedList = filteredCanceledContractsList;
    } else if (type == 3) {
      selectedList = filteredCompletedContractsList;
    }
    listToShowContracts = sortContractsBySoonestExpiry(selectedList);
    gettingContracts.value = false;
  }

  filterList(start, end) {
    allFiltered.clear();
    allFilteredAmount = 0.0;
    filteredActiveContractsList.clear();
    filteredActiveAmount = 0.0;
    filteredCanceledContractsList.clear();
    filteredCanceledAmount = 0.0;
    filteredCompletedContractsList.clear();
    filteredCompletedAmount = 0.0;

    gettingContracts.value = true;
    var allFilteredByDate = filterHistoryByDate(contractsList, start, end);
    allFiltered = allFilteredByDate;
    for (var item in allFiltered) {
      allFilteredAmount += double.parse(item.grandTotal ?? "0.0");
      if (item.contractCancelledAt != null) {
        filteredCanceledContractsList.add(item);
        filteredCanceledAmount += double.parse(item.grandTotal ?? "0.0");
      } else if (item.jobs?[0].totalJobs == item.jobs?[0].completedJobs) {
        filteredCompletedAmount += double.parse(item.grandTotal ?? "0.0");
        filteredCompletedContractsList.add(item);
      } else {
        filteredActiveAmount += double.parse(item.grandTotal ?? "0.0");
        filteredActiveContractsList.add(item);
      }
    }
    listToShowContracts = allFiltered;
    listToShowContracts = sortContractsBySoonestExpiry(allFiltered);
    gettingContracts.value = false;
  }

  List<SalesManContractsResponseData> filterHistoryByDate(
    List<SalesManContractsResponseData> contractsList,
    String startDate,
    String endDate,
  ) {
    return contractsList
        .where((contract) =>
            DateTime.parse(contract.createdAt!).isAfter(
                DateTime.parse(startDate).subtract(Duration(days: 1))) &&
            DateTime.parse(contract.createdAt!)
                .isBefore(DateTime.parse(endDate).add(Duration(days: 1))))
        .toList();
  }


  List<SalesManContractsResponseData> sortContractsBySoonestExpiry(
      List<SalesManContractsResponseData> contracts) {
    // Create a copy of the original list to avoid modifying it directly
    final sortedContracts = List<SalesManContractsResponseData>.from(contracts);

    // Sort the list based on contract end date
    sortedContracts.sort((a, b) {
      // Parse the contractEndDate strings to DateTime objects
      // Assuming the date format is something like "yyyy-MM-dd"
      final dateA = DateTime.parse(a!.contractEndDate!);
      final dateB = DateTime.parse(b!.contractEndDate!);

      // Compare dates - earlier dates come first
      return dateA.compareTo(dateB);
    });

    return sortedContracts;
  }
}
