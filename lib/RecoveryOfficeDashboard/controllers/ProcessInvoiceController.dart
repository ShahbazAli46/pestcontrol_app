import 'package:get/get.dart';

class ProcessInvoiceController extends GetxController {

  var option = 0.obs;


   void changeView(index){
     option.value = index;
   }




}