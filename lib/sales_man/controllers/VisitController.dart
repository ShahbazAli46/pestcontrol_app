import 'package:get/get.dart';

import '../TypesOfVisit.dart';

class VisitController extends GetxController {
  RxList<TypesOfVisit> visits = TypesOfVisit.visits.obs;
  TypesOfVisit selected = TypesOfVisit(visitTitle: "");

  void selectVisit(int index) {
    for (int i = 0; i < visits.length; i++) {
      visits[i].isSelect = i == index;
    }
    selected = visits[index];
    visits.refresh();
  }
}