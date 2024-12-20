import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

import '../../jsonModels/AllInvoicesResponse.dart';

class InvoicesController extends GetxController {
  var fetchingData = false.obs;
  var clientId = 0;
  List<InvoicesData>? unpaidInvoices =[];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getInvoices() async {
    fetchingData.value = true;
    var api = APICall();
    String url = "${Urls.allInvoices}${clientId}";
    var response = await api.getDataWithToken(url);
    AllInvoicesResponse res = AllInvoicesResponse.fromJson(response);
    List<InvoicesData> unPaids = res.data
        ?.where((item) => item.status == "unpaid")
        .toList()
        ?? [];
    unpaidInvoices = unPaids;
    fetchingData.value = false;
  }
}
