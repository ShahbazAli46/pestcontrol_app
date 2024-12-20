import 'package:accurate/jsonModels/PurchaseOrderDetailsResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class PurchaseOrderDetailsController extends GetxController {
  var fetchingData = false.obs;
  var id;
  PurchaseOrderDetailsController({required this.id});



  var api = APICall();

  late PurchaseOrderDetailsResponse detailsResponse;
  double totalVat = 0.0;

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  void getData()async {
    fetchingData.value = true;
    String url = "${Urls.baseURL}purchase_order/${id}";
    var response = await api.getDataWithToken(url);
    detailsResponse = PurchaseOrderDetailsResponse.fromJson(response);
    detailsResponse.data?.orderDetails?.forEach((item){
      totalVat += double.parse(item.vatAmount ?? "0.0");
    });
    fetchingData.value = false;
  }
}