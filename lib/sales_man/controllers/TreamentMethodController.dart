import 'package:accurate/jsonModels/ServicesResponse.dart';
import 'package:accurate/jsonModels/TreatmentMethodsResponse.dart';
import 'package:accurate/sales_man/TreatmentMethodsScreen.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class TreatmentMethods {
  final String methodName;
  final RxBool isSelected;
  final int id;




  TreatmentMethods({required this.methodName, required this.id,  bool selected = false})
      : isSelected = RxBool(selected);
}

class TreatmentMethosController extends GetxController {
  final RxList<TreatmentMethods> methods = <TreatmentMethods>[].obs;
  final api = APICall();

  var fetchingData = false.obs;

  @override
  void onInit() {
    super.onInit();

  }
  void updateSelection(int index) {
    methods[index].isSelected.toggle();
  }

  void getServices ()async{
    fetchingData.value = true;
    methods.clear();
    String url = Urls.treatmentMethod;
    final response = await api.getDataWithToken(url);
    TreatmentMethodsResponse res = TreatmentMethodsResponse.fromJson(response);
    res.data?.forEach((item){
      methods.add(new TreatmentMethods(methodName: item.name ?? "", id: item.id ?? 0));
    });

    fetchingData.value = false;
  }

}