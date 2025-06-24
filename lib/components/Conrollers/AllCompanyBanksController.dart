import 'dart:io';
import 'dart:typed_data';

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
import 'package:path_provider/path_provider.dart';

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

  addPaymentRequest (AddPaymentRequest request, clientSig, receiverSign ) async{
    addingPayment.value = true;
    String url = Urls.addPaymentForInvoices;

    File clientFile = await uint8ListToFile(clientSig);
    File receiverFile = await uint8ListToFile(receiverSign);


    var response  = await api.postDataWithTokenWithTwoImages(url, request.toJson(), clientFile, "client_signature_img", receiverFile, "employee_signature_img");
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

  Future<File> uint8ListToFile(Uint8List uint8list) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(uint8list);
    return file;
  }
}
