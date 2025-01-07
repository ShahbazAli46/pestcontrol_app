import 'dart:math';

import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/ExpensesListResponse.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../jsonModels/VechileExpenseListResponse.dart';

class ExpensesController extends GetxController {
  var fetchingTotalExpense = false.obs;
  late TotalExpenseResponse expenses;
  late ExpensesListResponse listResponse;
  late VehicleExpenseListResponse vehicleExpenseListResponse;
  var selectedExpCatId = -1;
  var vehicleId = -1;
  var addingFine = false.obs;
  var api = APICall();
  String fineDate = "";


  var submitingvehicleExp = false.obs;

  TextEditingController fuelController = TextEditingController();
  TextEditingController oilController = TextEditingController();
  TextEditingController maintainenceController = TextEditingController();
  TextEditingController nextOilController = TextEditingController();
  TextEditingController vatController = TextEditingController();
  String vExpData = UiHelper.formatDateForServer(DateTime.now());

  var total = "0.0".obs;

  TextEditingController fineController = TextEditingController();




  List<String> categoriesList = [];
  List<String> vehiclesList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentMonthData();

    fuelController.text = "0";
    oilController.text = "0";
    maintainenceController.text = "0";
    vatController.text = "0";
  }

  void getCurrentMonthData() {
    DateTime now = DateTime.now();
    fineDate = UiHelper.formatDateForServer(now);
    String startDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-01';
    String endDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${DateTime(now.year, now.month + 1, 0).day.toString().padLeft(2, '0')}';
    getTotalExpense(startDate, endDate);
  }

  void getTotalExpense(String startDate, String endDate) async {
      fetchingTotalExpense.value = true;
      try {
        String url = "${Urls.baseURL}dashboard/expense_collection?start_date=${startDate}&end_date=${endDate}";

        var response  = await api.getDataWithToken(url);
        expenses = TotalExpenseResponse.fromJson(response);
        var expensesUrl = "${Urls.baseURL}expense_category?start_date=${startDate}&end_date=${endDate}";
        var expRes = await api.getDataWithToken(expensesUrl);
        listResponse = ExpensesListResponse.fromJson(expRes);
        categoriesList.clear();
        listResponse.data?.forEach((item){
          categoriesList.add(item?.expenseCategory ?? "");
        });

        String vehicleUrl = "${Urls.baseURL}vehicle?start_date=${startDate}&end_date=${endDate}";
        var vehRes  = await api.getDataWithToken(vehicleUrl);
        vehicleExpenseListResponse = VehicleExpenseListResponse.fromJson(vehRes);
        vehicleExpenseListResponse.data?.forEach((item){
          String  name = " ${item.user?.name ?? ""}";
          vehiclesList.add("${item?.vehicleNumber} (${name})");
        });


      } catch (e){
        AlertService.showAlert("Error", "Request could not be completed at the moment, Please Contact App Developer  ${e.toString()} ");
      }

    fetchingTotalExpense.value = false;
  }

  void setExpenseId(int index){
    selectedExpCatId = listResponse.data?[index].id ?? 0;
  }

  void setVehicleId(int index){
    vehicleId = vehicleExpenseListResponse.data?[index].id ?? 0;
  }

  void submitVehicleExp ()async {
    if (vehicleId == -1){
      AlertService.showAlert("Alert", "Please select Vehicle");
    } else if (total.value == "0.0"){
      AlertService.showAlert("Alert", "Please enter any expense");
    }
    else{
      submitingvehicleExp.value = true;

      AddVehicleExpenseRequest request = AddVehicleExpenseRequest();
      request.paymentType = "cash";
      request.fuelAmount = "${parseDouble(fuelController.text)}";
      request.expenseDate = vExpData;
      request.vehicleId = "${vehicleId}";
      request.vatPer = "${parseDouble(vatController.text)}";
      request.total = total.value;
      request.oilAmount = "${parseDouble(oilController.text)}";
      request.maintenanceAmount = "${parseDouble(maintainenceController.text)}";
      request.oilChangeLimit = nextOilController.text;
      var response = await api.postDataWithToken(Urls.baseURL + "vehicle_expense/create", request.toJson());
      GeneralErrorResponse  errorResponse = GeneralErrorResponse.fromJson(response);
      if (errorResponse.status == "success"){
        fuelController.text = "0";
        oilController.text = "0";
        maintainenceController.text = "0";
        vatController.text = "0";
        submitingvehicleExp.value = false;
          AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: ()async{
            getCurrentMonthData();
            Get.back();
          });
      }
      else{
        AlertService.showAlert("Error", errorResponse.message ?? "");
      }
    }
  }

  calculateTotal(String value){
    double fuel = parseDouble(fuelController.text);
    double oil = parseDouble(oilController.text);
    double main = parseDouble(maintainenceController.text);
    double vat = parseDouble(vatController.text);
     double sub = fuel + oil + main;
     double withVat = (sub * vat / 100) + sub;
     this.total.value = "${withVat}";
  }

  double parseDouble(String? text) {
    return double.tryParse(text ?? "0") ?? 0;
  }

  void addFine() async {
    if (vehicleId == -1){
      AlertService.showAlert("Error", "Please select Vehicle ");
    } else if (fineController.text.isEmpty){
      AlertService.showAlert("Error", "Enter Fine Amount");
    } else {
      addingFine.value = true;
      AddFineRequest request = AddFineRequest();
      request.vehicleId = "${vehicleId}";
      request.fine = fineController.text;
      request.fineDate = fineDate;
      






    }

  }




}

class TotalExpenseResponse {
  String? startDate;
  String? endDate;
  TotalExpenseResponseData? data;

  TotalExpenseResponse({this.startDate, this.endDate, this.data});

  TotalExpenseResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    data = json['data'] != null
        ? new TotalExpenseResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TotalExpenseResponseData {
  NormalExpense? normalExpense;
  NormalExpense? vehicleExpense;
  String? totalExpense;
  String? totalCount;

  TotalExpenseResponseData(
      {this.normalExpense,
      this.vehicleExpense,
      this.totalExpense,
      this.totalCount});

  TotalExpenseResponseData.fromJson(Map<String, dynamic> json) {
    normalExpense = json['normal_expense'] != null
        ? new NormalExpense.fromJson(json['normal_expense'])
        : null;
    vehicleExpense = json['vehicle_expense'] != null
        ? new NormalExpense.fromJson(json['vehicle_expense'])
        : null;
    totalExpense = "${json['total_expense']}";
    totalCount = "${json['total_count']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.normalExpense != null) {
      data['normal_expense'] = this.normalExpense!.toJson();
    }
    if (this.vehicleExpense != null) {
      data['vehicle_expense'] = this.vehicleExpense!.toJson();
    }
    data['total_expense'] = this.totalExpense;
    data['total_count'] = this.totalCount;
    return data;
  }
}

class NormalExpense {
  String? total;
  String? count;

  NormalExpense({this.total, this.count});

  NormalExpense.fromJson(Map<String, dynamic> json) {
    total = "${json['total']}";
    count = "${json['count']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    return data;
  }
}

class AddVehicleExpenseRequest {
  String? fuelAmount;
  String? expenseDate;
  String? vehicleId;
  String? vatPer;
  String? total;
  String? oilAmount;
  String? maintenanceAmount;
  String? paymentType;
  String? oilChangeLimit;

  AddVehicleExpenseRequest(
      {this.fuelAmount,
        this.expenseDate,
        this.vehicleId,
        this.vatPer,
        this.total,
        this.oilAmount,
        this.maintenanceAmount,
        this.paymentType,
        this.oilChangeLimit});

  AddVehicleExpenseRequest.fromJson(Map<String, dynamic> json) {
    fuelAmount = json['fuel_amount'];
    expenseDate = json['expense_date'];
    vehicleId = json['vehicle_id'];
    vatPer = json['vat_per'];
    total = json['total'];
    oilAmount = json['oil_amount'];
    maintenanceAmount = json['maintenance_amount'];
    paymentType = json['payment_type'];
    oilChangeLimit = json['oil_change_limit'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['fuel_amount'] = this.fuelAmount ?? "";
    data['expense_date'] = this.expenseDate ?? "";
    data['vehicle_id'] = this.vehicleId ?? "";
    data['vat_per'] = this.vatPer ?? "";
    data['total'] = this.total ?? "";
    data['oil_amount'] = this.oilAmount ?? "";
    data['maintenance_amount'] = this.maintenanceAmount ?? "";
    data['payment_type'] = this.paymentType ?? "";
    data['oil_change_limit'] = this.oilChangeLimit ?? "";
    return data;
  }
}

class AddFineRequest {
  String? fine;
  String? fineDate;
  String? vehicleId;

  AddFineRequest({this.fine, this.fineDate, this.vehicleId});

  AddFineRequest.fromJson(Map<String, dynamic> json) {
    fine = json['fine'];
    fineDate = json['fine_date'];
    vehicleId = json['vehicle_id'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['fine'] = this.fine ?? "";
    data['fine_date'] = this.fineDate ?? "";
    data['vehicle_id'] = this.vehicleId ?? "";
    return data;
  }
}

