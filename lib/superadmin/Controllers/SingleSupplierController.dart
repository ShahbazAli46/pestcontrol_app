import 'package:accurate/jsonModels/AddSupplierBankRequest.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/SupplierInfoResponse.dart';
import 'package:accurate/jsonModels/SupplierledgerResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class SingleSupplierController extends GetxController {
  var fetchingData = false.obs;
  var addingBank = false.obs;
  var type = 0.obs;
  var id;

  SingleSupplierController({required this.id});
  late SupplierInfoResponse infoResponse;
  late SupplierledgerResponse ledgers;

  var api = APICall();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  void getData() async {
    fetchingData.value = true;
    String infoUrl = "${Urls.baseURL}supplier/${id}";
    var response = await api.getDataWithToken(infoUrl);
    infoResponse = SupplierInfoResponse.fromJson(response);
    String ledgerUrl = "${Urls.baseURL}supplier/ledger/get/${id}";
    var ledgerResponse = await api.getDataWithToken(ledgerUrl);
    ledgers = SupplierledgerResponse.fromJson(ledgerResponse);
    fetchingData.value = false;
  }


  void addBank({required String bankName, required String iban, required String account, required String address}) async{
    addingBank.value = true;
    String addBankUrl = "${Urls.baseURL}supplier/bank_info/add";
    AddSupplierBankRequest request = AddSupplierBankRequest();
    request.supplierId = "${id}";
    request.bankName = bankName;
    request.iban = iban;
    request.accountNumber = account;
    request.address = address;
    Map map = request.toJson();
    var response = await api.postDataWithToken(addBankUrl, map);
    GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
    if (errorResponse.status == "success"){
      AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
        Get.back();
        getData();
      });
    }
    else{
      AlertService.showAlert("Error", errorResponse.message ?? "");
    }
    addingBank.value = false;
  }


  void changeType(int index){
    /// index 0 == info
    /// index 1 == legder view
    type.value = index;
  }


}
