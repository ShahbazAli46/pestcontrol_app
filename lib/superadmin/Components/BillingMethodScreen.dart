import 'package:accurate/components/MultiSelectCheckbox.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/controllers/generic/AppRadioSelection.dart';
import 'package:accurate/jsonModels/CreateQuoteRequest.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/superadmin/Controllers/CreateQuoteController.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingMethodScreen extends StatefulWidget {
  const BillingMethodScreen({Key? key}) : super(key: key);

  @override
  State<BillingMethodScreen> createState() => _BillingMethodScreenState();
}

class _BillingMethodScreenState extends State<BillingMethodScreen> {
  late CreateQuoteController controller;
  String billingMethod = "service";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find(tag: Constants.createQuote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
              children: [
                NavWithBack(),
                SizedBox(
                  height: 20,
                ),
                AppTextLabels.boldTextShort(
                    label: "Billing Method", fontSize: 20),
                SizedBox(
                  height: 20,
                ),

                Expanded(child: SingleChildScrollView(child: Column(
                  children: [

                    SizedBox(
                      height: 10,
                    ),
                    AppTextLabels.boldTextShort(label: "Total", fontSize: 20),
                    AppTextLabels.boldTextShort(
                        label: "${controller.grandTotal}", fontSize: 20),
                    AppInput(
                      title: "VAT %",
                      controller: controller.vat,
                      onChange: controller.addVat,
                      inputType: TextInputType.number,
                    ),
                    Obx(() => !controller.refreshServiceView.value
                        ? Column(
                      children: [
                        AppTextLabels.boldTextShort(
                            label: "Grand Total", fontSize: 20),
                        AppTextLabels.boldTextShort(
                            label: "${controller.grandTotalWithVat}",
                            fontSize: 20),
                      ],
                    )
                        : Container()),
                    AppInput(
                      title: "Discount",
                      controller: controller.discount,
                      onChange: controller.calculateDiscount,
                      inputType: TextInputType.number,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GreenButton(title: "Create Quote", sendingData: controller.sendingData, onTap: ()async{
                        if (controller.vat.text == ""){
                          AlertService.showAlert("Alert", "Please enter value in VAT");
                        } else if (billingMethod == ""){
                          AlertService.showAlert("Alert", "Please select billing method");
                        }
                        else {
                          if (!controller.sendingData.value) {
                            controller.sendingData.value = true;
                            CreateQuoteRequest request = CreateQuoteRequest();
                            request.manageType = "create";
                            String serviceIdsString = '[' + controller.selectedAnimals.join(',') + ']';
                            request.service_ids = serviceIdsString;
                            request.userId = controller.selectedClientID;
                            request.quoteTitle = controller.title.text;
                            request.clientAddressId = controller
                                .selectedSelectedAddressID;
                            request.subject = controller.subject.text;
                            request.tmIds = controller.selectedTreatmentMethods;
                            request.description = controller.desc.text;
                            request.trn = 0;
                            request.tag = controller.tag.text;
                            request.durationInMonths = int.parse(
                                controller.duration.text);
                            request.isFoodWatchAccount = 1;
                            request.branch_id = "${controller.selectedBranched}";
                            request.billingMethod = billingMethod;
                            request.vatPer = int.parse(controller.vat.text);
                            request.dis_amt = controller.discount.text == ""
                                ? 0
                                : int.parse(controller.discount.text);
                            request.termAndConditionId = controller
                                .selectedTermAndConditionID;
                            request.services = controller.quoteServices;
                            String url = Urls.baseURL + "quote/manage";
                            var api = APICall();
                            var response = await api.postDataWithToken(
                                url, request.toJson());
                            GeneralErrorResponse errorResponse = GeneralErrorResponse
                                .fromJson(response);
                            if (errorResponse.status == "success") {
                              AlertService.showAlertWithAction(
                                  "Success", errorResponse.message ?? "",
                                  onOkPressed: () {
                                    Widget home = UiHelper
                                        .goToUserDashboardAsPerUserRole(
                                        userObj?.data?.roleId ?? 0);
                                    Get.offAll(home);
                                  });
                            }
                            else {
                              controller.sendingData.value = false;
                              AlertService.showAlert(
                                  "Alert", errorResponse.message ?? "");
                            }
                          }

                        }
                      }),
                    )
                  ],
                ),))


              ],
            )));
  }

}
