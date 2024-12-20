import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';

class GetEmployeeInfoDetails extends GetxController {
  var fetchingData = false.obs;
  var id = 0;
  GetEmployeeInfoDetails({required this.id});
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getInfo();
  }

  void getInfo() {
      String url = "${Urls.employeeInfo}id";
    print(url);

  }
}
