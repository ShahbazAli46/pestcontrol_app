
import 'package:accurate/jsonModels/BankCollectionResponse.dart';
import 'package:accurate/jsonModels/CashReceviedResponse.dart';
import 'package:accurate/jsonModels/ExpensesListResponse.dart';
import 'package:accurate/jsonModels/FinancialReportResponse.dart';
import 'package:accurate/jsonModels/PendingPaymentsResponse.dart';
import 'package:accurate/jsonModels/PosCollectionResponse.dart';
import 'package:accurate/jsonModels/VechileExpenseListResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class FinancialReportController extends GetxController {

  var fetchingData = false.obs;
  var api = APICall();

  late FinancialReportResponse financialReportResponse;
  late VehicleExpenseListResponse vehicleExpenseListResponse;
  late ExpensesListResponse listResponse;
  late BankCollectionResponse bankCollectionResponse;
  late PosCollectionResponse posCollectionResponse;
  late CashReceviedResponse cashReceviedResponse;

  double totalVehAmount = 0.0;
  double totalGeneralExpAmount = 0.0;
  var overAllTotalExpense = 0.0;




  /// Recived Amount
  var totalPendingPayment = 0.0;
  var overAllRecevied = 0.0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    String startDate = '${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-${firstDayOfMonth.day.toString().padLeft(2, '0')}';
    String endDate = '${lastDayOfMonth.year}-${lastDayOfMonth.month.toString().padLeft(2, '0')}-${lastDayOfMonth.day.toString().padLeft(2, '0')}';
    getData(startDate, endDate);
  }

  void getData(String startDate, String endDate) async{
    print("******************");
    fetchingData.value = true;
    String financialURL = "${Urls.baseURL}dashboard/monthly_financial_report?start_date=${startDate}&end_date=${endDate}";
    var response = await api.getDataWithToken(financialURL);
    financialReportResponse = FinancialReportResponse.fromJson(response);

    String vehicleUrl = "${Urls.baseURL}vehicle?start_date=${startDate}&end_date=${endDate}";
    var vehRes  = await api.getDataWithToken(vehicleUrl);
    vehicleExpenseListResponse = VehicleExpenseListResponse.fromJson(vehRes);

    vehicleExpenseListResponse.data?.forEach((item){
      totalVehAmount += double.parse(item.totalAmount ?? "");
    });

    var expensesUrl = "${Urls.baseURL}expense_category?start_date=${startDate}&end_date=${endDate}";
    var expRes = await api.getDataWithToken(expensesUrl);
    listResponse = ExpensesListResponse.fromJson(expRes);
    listResponse.data?.forEach((item){
      totalGeneralExpAmount += double.parse(item?.totalAmount ?? "");
    });
    overAllTotalExpense = double.parse(financialReportResponse.data?.paidEmployeeComm ?? "") + double.parse(financialReportResponse.data?.paidEmployeeSalary ?? "") + totalGeneralExpAmount +  totalVehAmount;

    // recevied amount Api..
    String pendingPaymentUrl = "${Urls.baseURL}received_cash_record?start_date=${startDate}&end_date=${endDate}";
    var pendingResponse = await api.getDataWithToken(pendingPaymentUrl);
    PendingPaymentsResponse pendingPaymentsResponse = PendingPaymentsResponse.fromJson(pendingResponse);
    pendingPaymentsResponse.data?.forEach((item){
      totalPendingPayment += double.parse(item?.paidAmt ?? "");
    });

    overAllRecevied += totalPendingPayment;

    String bankUrl = "${Urls.baseURL}dashboard/bank_collection?start_date=${startDate}&end_date=${endDate}";
    var bankResponse = await api.getDataWithToken(bankUrl);
    bankCollectionResponse = BankCollectionResponse.fromJson(bankResponse);
    overAllRecevied += double.parse(bankCollectionResponse.data?.totalChequeTransfer ?? "");

    String posUrl = "${Urls.baseURL}dashboard/pos_collection?start_date=${startDate}&end_date=${endDate}";
    var posResponse = await api.getDataWithToken(posUrl);
    posCollectionResponse = PosCollectionResponse.fromJson(posResponse);
    overAllRecevied += double.parse(posCollectionResponse.data?.totalPos ?? "0.0");

    String cashUrl = "${Urls.baseURL}dashboard/cash_collection?start_date=${startDate}&end_date=${endDate}";
    var cashResponse = await api.getDataWithToken(cashUrl);
    cashReceviedResponse = CashReceviedResponse.fromJson(cashResponse);

    overAllRecevied += double.parse(cashReceviedResponse.data?.totalCash ?? "0.0");






    fetchingData.value = false;


  }

}