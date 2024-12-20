import 'package:accurate/jsonModels/AllSuppliersResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AllSupplierController extends GetxController {
  var fetchingData = false.obs;
  List<AllSuppliersResponseData>? list = [];
  List<AllSuppliersResponseData>? all = [];

  TextEditingController filterTextController = TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  void getData()async{
    fetchingData.value = true;
    String url = "${Urls.baseURL}supplier";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    AllSuppliersResponse allSuppliersResponse = AllSuppliersResponse.fromJson(response);
    list = allSuppliersResponse.data;
    all = allSuppliersResponse.data;
    fetchingData.value = false;
  }

  onChangeInFilter(String filterValue){
    fetchingData.value = true;
    if (filterValue.isEmpty) {
      list = all;
      fetchingData.value = false;
      return;
    }
    // Apply the filter
    String lowerCaseFilter = filterValue.toLowerCase();
    List<AllSuppliersResponseData> filteredList = all!.where((supplier) {
      return (supplier.supplierName!.toLowerCase().contains(lowerCaseFilter) ||
          supplier.companyName!.toLowerCase().contains(lowerCaseFilter));
    }).toList();
    list = filteredList;
    fetchingData.value = false;

  }
}