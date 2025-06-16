import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/CreateReportResponse.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/sales_man/salesManDashboard.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../components/UpcomignJobs/Controllers/JobDetailsController.dart';
import '../../jsonModels/CreateReportRequest.dart';
import '../../utils/APICall.dart';
import '../../utils/Constants.dart';
import '../AddFeedBackScreen.dart';
import '../TypesOfVisit.dart';
import 'AddInspectedAreasController.dart';
import 'ChemicalController.dart';
import 'PestFoundController.dart';
import 'TreamentMethodController.dart';
import 'VisitController.dart';

class SubmitRequestController extends GetxController {
  var sendingData = false.obs;

  APICall api = APICall();

  void sendData(String recomendation, File image) async {
    sendingData.value = true;
    JobDetailsController jobController = Get.find(tag: Constants.jobController);
    VisitController visitController =
        Get.find(tag: Constants.visitsTypeController);
    AddInspectedAreasController inspectedAreasController =
        Get.find(tag: Constants.inspectedAreaController);
    PestFoundController pestFoundController =
        Get.find(tag: Constants.pestController);
    TreatmentMethosController treatmentMethosController =
        Get.find(tag: Constants.treatmentmethodController);
    ChemicalController usedController =
        Get.find(tag: Constants.usedChemicalController);

    TypesOfVisit selectedVisit = TypesOfVisit(visitTitle: "");
    visitController.visits.forEach((item) {
      if (item.isSelect) {
        selectedVisit = item;
      }
    });
    List<int> pest_found_ids = [];
    pestFoundController.pests.forEach((item) {
      if (item.isSelected.value) {
        pest_found_ids.add(item.pestId);
      }
    });

    List<int> tm_ids = [];
    treatmentMethosController.methods.forEach((item) {
      if (item.isSelected.value) {
        tm_ids.add(item.id);
      }
    });

    List<Addresses>? addresses = [];
    inspectedAreasController.inspectedAreas.forEach((item) {
      Addresses address = Addresses(
          inspectedAreas: item.areaName,
          manifestedAreas: item.manifestedArea,
          infestationLevel: item.manifestationLevel,
          pestFound: item.pestFound,
          reportAndFollowUpDetail: item.followUp);
      addresses.add(address);
    });
    List<UsedProducts> used_products = [];
    usedController.list.forEach((item) {
      used_products.add(UsedProducts(
          productId: item.product_id,
          dose: 1,
          qty: int.parse(item.quantity),
          price: int.tryParse(item.price),
          isExtra: item.isExtra ? 1 : 0));
    });
    CreateReportRequest reportRequest = CreateReportRequest(
        jobId: jobController.jobId,
        typeOfVisit: selectedVisit.visitTitle,
        tmIds: tm_ids,
        addresses: addresses,
        usedProducts: used_products,
        pestFoundIds: pest_found_ids,
        recommendationsAndRemarks: recomendation);
    Map<String, dynamic> map = reportRequest.toJson().cast<String, dynamic>();
    print(map);
    final response = await api.postDataWithTokenWithImageAndArrays(Urls.createServiceReport, map, image,);

    CreateReportResponse errorResponse = CreateReportResponse.fromJson(response);
    if (errorResponse.status == "success") {
      AlertService.showAlertWithAction("Alert", errorResponse.message ?? "",
          onOkPressed: () {
        Get.offAll(AddFeedBackScreen(reportID: errorResponse.data?.id ?? "0",));
      });
    } else {
      AlertService.showAlert("Alert", errorResponse.message ?? "");
    }
    sendingData.value = false;
  }
}
