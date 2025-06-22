import 'package:accurate/jsonModels/CompleteJobResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class CompleteJobController extends GetxController {

  var fetchingData = true.obs;
  int jobID;
  CompleteJobController({required this.jobID});
  var api = APICall();
  late CompleteJobResponse completeJobResponse;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();

  }

  void fetchData() async {
    fetchingData.value = true;
    print("gettting data");
    var url = Urls.baseURL + "job/overall/captain_info/${jobID}";
    var response = await api.getDataWithToken(url);
    completeJobResponse = CompleteJobResponse.fromJson(response);
    print("data fetched");
    fetchingData.value = false;
  }



}






