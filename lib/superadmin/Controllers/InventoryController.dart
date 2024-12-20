
import 'package:accurate/jsonModels/InventoryResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class InventoryController extends GetxController {

    var fetchingData = false.obs;

    List<InventoryResponseData>? data = [];

    List<InventoryResponseData>? allItem = [];

    @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInventory();
  }


  void getInventory() async {
      fetchingData.value = true;
      String url = Urls.baseURL + "product";
      var api = APICall();
      var response = await api.getDataWithToken(url);
      InventoryResponse inv = InventoryResponse.fromJson(response);
      data = inv.data;
      allItem = inv.data;
      fetchingData.value = false;
  }

  void filter(String filter){
    if (allItem != null) {
      fetchingData.value = true;
      List<InventoryResponseData> filteredData = filter.isEmpty
          ? allItem!.toList()
          : allItem!.where((item) {
        return item.productName?.toLowerCase().contains(filter.toLowerCase()) ?? false;
      }).toList();
      data = filteredData;
      print(data?.length);
      fetchingData.value = false;
    }
  }

}