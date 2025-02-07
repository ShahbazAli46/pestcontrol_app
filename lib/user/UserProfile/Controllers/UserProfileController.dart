import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../utils/Constants.dart';

class UserProfileController extends GetxController {

  var fetchingData = false.obs;
  late UserDetails details = UserDetails();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserInfo();
  }

  void getUserInfo()async{
    fetchingData.value = true;
    int userID = userObj?.data?.id ?? 0;
    String url = "${Urls.upcomingJobs}$userID";
    var response = await APICall().getDataWithToken(url);
    details = UserDetails.fromJson(response);
    fetchingData.value = false;
  }

}