import 'package:accurate/SalesManagerAndSalesMan/SalesMan/Controlers/ViewVisitsController.dart';
import 'package:accurate/components/MapLauncher.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/DateRangePicker.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewVisitsScreen extends StatefulWidget {
  @override
  State<ViewVisitsScreen> createState() => _ViewVisitsScreenState();
}

class _ViewVisitsScreenState extends State<ViewVisitsScreen> {
  late ViewVisitsController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = Get.put(ViewVisitsController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<ViewVisitsController>();
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
            AppTextLabels.boldTextShort(label: "View Visits", fontSize: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    child: AppTextLabels.regularShortText(
                        label: "Select Date", color: AppColors.lightTextColor),
                  )),
                  DateFilters(onOptionChange: onOptionChange),
                ],
              ),
            ),
            Obx(() => controller.fetchingData.value
                ? UiHelper.loader()
                : Expanded(
                    child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  AppTextLabels.boldTextShort(
                                      label: "Total Visits",
                                      fontSize: 12,
                                      color: AppColors.appGreen),
                                  AppTextLabels.regularShortText(
                                      label: "${controller.total}",
                                      color: AppColors.appBlack,
                                      fontSize: 15)
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppTextLabels.boldTextShort(
                                          label: "Interested",
                                          fontSize: 12,
                                          color: AppColors.appGreen),
                                      AppTextLabels.regularShortText(
                                          label: "${controller.interested}",
                                          color: AppColors.appBlack,
                                          fontSize: 15)
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Container(
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppTextLabels.boldTextShort(
                                          label: "Not Interested",
                                          fontSize: 12,
                                          color: AppColors.appGreen,
                                          textAlign: TextAlign.center),
                                      AppTextLabels.regularShortText(
                                          label: "${controller.notInterested}",
                                          color: AppColors.appBlack,
                                          fontSize: 15)
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Container(
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppTextLabels.boldTextShort(
                                          label: "Contracted",
                                          fontSize: 12,
                                          color: AppColors.appGreen),
                                      AppTextLabels.regularShortText(
                                          label: "${controller.contracted}",
                                          color: AppColors.appBlack,
                                          fontSize: 15)
                                    ],
                                  ),
                                )),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Container(
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppTextLabels.boldTextShort(
                                          label: "Quoted",
                                          fontSize: 12,
                                          color: AppColors.appGreen),
                                      AppTextLabels.regularShortText(
                                          label: "${controller.quoted}",
                                          color: AppColors.appBlack,
                                          fontSize: 15)
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: CustomListView(
                        items: controller.visits ?? [],
                        itemBuilder: (context, item, index) => visitItem(index),
                      ))
                    ],
                  )))
          ],
        )));
  }

  onOptionChange(name, start, end) {
    String startDate = UiHelper.formatDateForServer(start);
    String endDate = UiHelper.formatDateForServer(end);
    controller.getData(startDate, endDate);
  }

  Widget visitItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            UiHelper.buildRow("Sr", "${index + 1}"),
            UiHelper.buildRow(
                "Firm", controller.visits?[index].userClient?.name ?? ""),
            UiHelper.buildRow("Status", controller.visits?[index].status ?? ""),
            UiHelper.buildRow(
                "Follow Up Date",
                UiHelper.formatDate(
                    controller.visits?[index].followUpDate ?? "")),
            UiHelper.buildRow(
                "Remarks", controller.visits?[index].description ?? ""),
            GreenButton(
                title: "Open Location",
                sendingData: false.obs,
                onTap: () {
                  openMaps(31.355036407386358, 74.18449202965172);
                })
          ],
        ),
      ),
    );
  }

  Future<void> openMaps(double lat, double long) async {
    MyMapLauncher.openMapsWithLocation(latitude: lat, longitude: long);
  }
}
