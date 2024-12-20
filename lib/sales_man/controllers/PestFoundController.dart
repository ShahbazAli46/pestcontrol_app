import 'package:accurate/jsonModels/ServicesResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class PestFoundName {
  final String pestName;
  final int pestId;
  final RxBool isSelected;




  PestFoundName({required this.pestName, bool selected = false, required this.pestId})
      : isSelected = RxBool(selected);
}

class PestFoundController extends GetxController {
  final RxList<PestFoundName> pests = <PestFoundName>[].obs;
  final api = APICall();

  var fetchingData = false.obs;

  @override
  void onInit() {
    super.onInit();
    getServices();
  }
  void updateSelection(int index) {
    pests[index].isSelected.toggle();
  }

  void getServices ()async{
    fetchingData.value = true;
    String url = Urls.services;
    final response = await api.getDataWithToken(url);
    ServicesResponse res = ServicesResponse.fromJson(response);
    print(res.data?.length);
    final reversed  = res.data?.reversed.toList();
    reversed?.forEach((item){
      pests.add(PestFoundName(pestName: item.pestName ?? "", pestId: item.id ?? 0));
    });

    fetchingData.value = false;
  }

}