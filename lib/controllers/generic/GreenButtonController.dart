import 'package:get/get.dart';

class GreenButtonController extends GetxController {
  RxBool isSending = false.obs;

  void submitData() async {
    isSending.value = true;
    await Future.delayed(Duration(seconds: 2)); // Simulating network request
    isSending.value = false;
  }
}
