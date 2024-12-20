import 'package:accurate/jsonModels/ViewAllProductsResponse.dart';
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
  var api = APICall();
  var selectedProductID = -1;
  String selectedProductName =  "";
  late DateTime orderData;




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

  void saveBill(){

  }
}


class BillItems{
  String productName;
  String price;
  int productId;
  String qty;
  BillItems({required this.productName, required this.price, required this.productId, required this.qty});
}