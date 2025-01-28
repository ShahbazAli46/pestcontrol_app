import 'package:accurate/jsonModels/AllBanksReponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BanksController extends GetxController{

  TextEditingController filterController = TextEditingController();

  var fetchingData = true.obs;
  List<BankData>? data  = [];
  List<BankData>? allData  = [];



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBanks();
  }

  getBanks() async{
    fetchingData.value = true;
    String url = Urls.baseURL  + "bank";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    AllBanksReponse  banksResponse = AllBanksReponse.fromJson(response);
    banksResponse.data?.forEach((item){
      data?.add(item);
      allData?.add(item);
    });
    fetchingData.value = false;
  }



  filterBankByName (String value){
    fetchingData.value = true;
    data?.clear();
    if (value != ""){
      allData?.forEach((item){
        if (item.bankName!.toLowerCase().contains(value.toLowerCase())){
          data?.add(item);
        }
      });
    }
    else{
      allData?.forEach((item){
        data?.add(item);
      });
    }
    fetchingData.value = false;
  }

}