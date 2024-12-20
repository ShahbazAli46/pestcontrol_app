import 'package:accurate/jsonModels/SingleVehicleResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class SingleVehicleDetailsController extends GetxController {
  var fetchingData = false.obs;
  var id = 0;
  SingleVehicleDetailsController({required this.id});

  List<VehicleExpenses>? vehicleExpenses = [];
  SingleVehicleResponseDataUser? user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }

  void getData() async {
    fetchingData.value = true;
    String url = "${Urls.baseURL}vehicle/${id}";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    SingleVehicleResponse singleVehicleResponse =
        SingleVehicleResponse.fromJson(response);
    vehicleExpenses = singleVehicleResponse.data?.vehicleExpenses;
    vehicleExpenses = vehicleExpenses?.reversed.toList();
    user = singleVehicleResponse?.data?.user;
    fetchingData.value = false;
  }
}
