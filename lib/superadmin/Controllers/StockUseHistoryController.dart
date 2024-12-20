

import 'package:accurate/jsonModels/ProductHistoryResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class StockUseHistoryController extends GetxController {

  var fetchingData = false.obs;
  var productID = 0;
  List<AssignedStockHistory>? assignedStockHistory = [];
  List<PurchasedStockHistory>? purchasedStockHistory = [];
  StockUseHistoryController({required this.productID});
  @override
  void onInit() {
    super.onInit();
    getHistory();
  }

  void getHistory() async{
    fetchingData.value = true;
    String url = Urls.baseURL + "product/${productID}";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    ProductHistoryResponse history = ProductHistoryResponse.fromJson(response);
    print(history.data?.assignedStockHistory?.length);
    assignedStockHistory = history.data?.assignedStockHistory;

    fetchingData.value = false;

  }
}