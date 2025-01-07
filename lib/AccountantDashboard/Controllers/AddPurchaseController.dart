import 'dart:io';

import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/AddPurcahseOrderRequest.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/ViewAllProductsResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddPurchaseController extends GetxController {

  TextEditingController invoiceNumber = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController vat = TextEditingController();
  TextEditingController price = TextEditingController();
  late File image;
  bool isImageSelected = false;
  late String supplierID = "";
  var api = APICall();
  DateTime currentDate = DateTime.now();
  var selectedProductID = -1;
  String selectedProductName =  "";
  late String orderData = UiHelper.formatDateForServer(currentDate);
  late String deliveryData = UiHelper.formatDateForServer(currentDate);
  late String invNumber = "";
  var savingBill = false.obs;






  List<ViewAllProductsResponseData>? allList = [];
  RxList<String> productNamesList = <String>[].obs;



  var refreshList = true.obs;
  List<BillItems> billItems = [];

  var totalAmount = 0.0;
  var percentage = 0.0;








  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
  }


  void getProducts() async {
    String url = "${Urls.baseURL}product";
    totalAmount = 0.0;
    var response = await api.getDataWithToken(url);
    ViewAllProductsResponse allProductsResponse = ViewAllProductsResponse.fromJson(response);
    allList = allProductsResponse.data;
    allList?.forEach((item){
      print(item.productName);
      productNamesList.add(item.productName ?? "");
    });
  }
  void setSelectedProductID(int index){
    selectedProductID = allList?[index].id ?? 0;
    selectedProductName = allList?[index].productName ?? "";
  }

  void addItem(){
    if (selectedProductID == -1){
      AlertService.showAlert("Alert", "Please Select Product");
    } else if (quantity.text.isEmpty){
      AlertService.showAlert("Alert", "Please Enter Quantity");
    } else if (price.text.isEmpty){
      AlertService.showAlert("Alert", "Please enter price ");
    }
    else{
      refreshList.value = true;
      totalAmount += double.parse(price.text) * double.parse(quantity.text);
      BillItems item = BillItems(
        productName: selectedProductName,
        productId: selectedProductID,
        price: price.text ?? "",
        qty: quantity.text
      );
      billItems.add(item);
      refreshList.value = false;
      price.text = "";
      quantity.text = "";
      Get.back();
    }

  }

  void vatChanged(String value){
    refreshList.value = true;
    double perValue = double.parse(value);
    percentage = (perValue / 100) * totalAmount;
    refreshList.value = false;

  }

  void saveBill()async{


    List<int> ids = [];
    List<String> qtys = [];
    List<String> prices = [];
    List<String> vats = [];

    billItems.forEach((item){
      ids.add(item.productId);
      qtys.add(item.qty);
      prices.add(item.price);
      vats.add(vat.text);
    });
    String idsStrings = ids.join(",");
    String qtysString = qtys.join(",");
    String pricesString = prices.join(",");


    AddPurcahseOrderRequest  request = AddPurcahseOrderRequest();
    request.invoiceNo = invoiceNumber.text;
    request.supplierId = supplierID;
    request.orderDate = orderData;
    request.deliveryDate = deliveryData;
    request.privateNote = "note";
    request.disPer = "0";
    request.productId = idsStrings;
    request.quantity = qtysString;
    request.price = pricesString;
    request.vatPer = vats.join(",");
  savingBill.value = true;
    if (isImageSelected){
      var response = await api.postDataWithTokenWithImage("${Urls.baseURL}purchase_order/create", request.toJson(), image, "purchase_invoice");
      GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
      savingBill.value = false;
      if (errorResponse.status == "error"){
          AlertService.showAlert("Error", " ${errorResponse.message ?? ""} Please try later");
      }
      else{
        AlertService.showAlertWithAction("Success", "${errorResponse.message ?? ""}", onOkPressed: (){
          Get.back();
        });
      }

    }
    else{
      var response = await api.postDataWithToken("${Urls.baseURL}purchase_order/create", request.toJson());
      GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
      savingBill.value = false;
      if (errorResponse.status == "error"){
        AlertService.showAlert("Error", " ${errorResponse.message ?? ""} Please try later");
      }
      else{
        AlertService.showAlertWithAction("Success", "${errorResponse.message ?? ""}", onOkPressed: (){
          Get.back();
        });
      }
    }









  }
}


class BillItems{
  String productName;
  String price;
  int productId;
  String qty;
  BillItems({required this.productName, required this.price, required this.productId, required this.qty});
}