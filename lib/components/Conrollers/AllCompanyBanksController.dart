import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/AddPaymentRequest.dart';
import 'package:accurate/jsonModels/AddSupplierPaymentRequest.dart';
import 'package:accurate/jsonModels/AllBanksReponse.dart';
import 'package:accurate/jsonModels/AllBranchesResponse.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/sales_man/salesManDashboard.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCompanyBanksController extends GetxController {
  var fetchingBanks = false.obs;
  var fetchingBranches = true.obs;
  List<BankData>? banksList;
  List<String> bankNamesList = [];
  var addingPayment = false.obs;
  var api = APICall();
  late Function refreshData;

  BuildContext context;
  AllCompanyBanksController({required this.context});
  List<AllBranchesResponseData>? allBranches;
  List<String> branchNames = [];
  var selectedBranched = -1;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBanksList();
    getBranches();
  }
  getBanksList() async {
    fetchingBanks.value = true;

    String url = Urls.bank;
    var response = await api.getDataWithToken(url);
    AllBanksReponse allBanks = AllBanksReponse.fromJson(response);
    banksList = allBanks.data;
    banksList?.forEach((item){
      bankNamesList.add(item.bankName ?? "");
    });
    fetchingBanks.value = false;
  }

  int getBankId  (index){
    return banksList?[index].id ?? 0;
  }

  setSelectedBranchID(int index){
    selectedBranched = allBranches?[index].id ?? 0;
  }

  getBranches ()async{
    fetchingBranches.value = true;
    String url = Urls.baseURL + "branch";
    var response = await api.getDataWithToken(url);
    AllBranchesResponse branchesResponse = AllBranchesResponse.fromJson(response);
    allBranches = branchesResponse.data;
    allBranches?.forEach((item){
      branchNames.add(item.name ?? "");
    });

    fetchingBranches.value = false;
  }

  addPaymentRequest (AddPaymentRequest request) async{
    addingPayment.value = true;
    String url = Urls.addPaymentForInvoices;
    var response  = await api.postDataWithToken(url, request.toJson());
    try {
        GeneralErrorResponse generalErrorResponse = GeneralErrorResponse.fromJson(response);
        print(generalErrorResponse.status);
        if (generalErrorResponse.status == "success"){
          AlertService.showAlertWithAction("Sucess", generalErrorResponse.message ?? "", onOkPressed: (){
            int roleId = userObj?.data?.roleId ?? 0;
            Navigator.pushAndRemoveUntil(
              context!,
              MaterialPageRoute(builder: (context) => UiHelper.goToUserDashboardAsPerUserRole(int.parse("${roleId}"))),
                  (Route<dynamic> route) => false,
            );

          });
        }
        else{
          AlertService.showAlert("Error", generalErrorResponse.message ?? "Please try later");
        }
    } catch (e) {
      AlertService.showAlert("Error", e.toString());
    }
    addingPayment.value = false;
  }


  addSupplierPayment(AddSupplierPaymentRequest item, Function refreshData) async{
    addingPayment.value = true;
    String url = "${Urls.baseURL}supplier/add_payment";
    var response = await api.postDataWithToken(url, item.toJson());
    GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
    if (errorResponse.status == "success"){
        AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
          refreshData();
          Get.back();
        });
    }
    else{
    AlertService.showAlert("Error", errorResponse.message ?? "");
    }
    addingPayment.value = false;
  }
}
