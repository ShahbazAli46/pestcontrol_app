import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import '../../jsonModels/ItemHistoryResponse.dart';

class UsedItemHistoryController extends GetxController {
  var fetchingData = false.obs;
  var stockItemId = 0;
  APICall apiCall = APICall();

  List<UsedStock>? usedStock;

  void getHistory() async {
    fetchingData.value = true;
    String url = Urls.itemHistroy;
    ItemHistoryRequest item = ItemHistoryRequest(
        userId: "${userObj!.data!.id}", productId: "${stockItemId}");
    var response = await apiCall.postDataWithToken(url, item.toJson());
    try {
      ItemHistoryResponse historyResponse = ItemHistoryResponse.fromJson(response);
       usedStock  = historyResponse.data?.usedStock;
    } catch (e) {
      AlertService.showAlert("Error", "Please Try later ${e.toString()}");
    } finally {
      fetchingData.value = false;
    }
  }
}
