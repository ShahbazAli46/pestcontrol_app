import 'package:accurate/jsonModels/SingleBankDetailsResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class SingleBankDetailsController extends GetxController {
  int bankID;
  var fetchingData = true.obs;
  SingleBankDetailsController({required this.bankID});
  SingleBankDetailsResponseData? data;
  List<SingleBankDetailsResponseDataLedgers> ledgers = [];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBankDetails();
  }

  void getBankDetails() async {
    fetchingData.value = true;
    String url = Urls.baseURL + "bank/${bankID}";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    SingleBankDetailsResponse singleBankDetailsResponse = SingleBankDetailsResponse.fromJson(response);
    data = singleBankDetailsResponse.data;
    ledgers = singleBankDetailsResponse.data!.ledgers!;
    fetchingData.value = false;
  }

}