import 'package:accurate/RecoveryOfficeDashboard/controllers/AssinedInvoicesController.dart';
import 'package:accurate/RecoveryOfficeDashboard/views/ProcessInvoiceScreen.dart';
import 'package:accurate/components/UpcomignJobs/UpcomingJobsController.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/DateRangePicker.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/MapLauncher.dart';

class AssignedInvoicesScreen extends StatefulWidget {
  const AssignedInvoicesScreen({Key? key}) : super(key: key);

  @override
  State<AssignedInvoicesScreen> createState() => _AssignedInvoicesScreenState();
}

class _AssignedInvoicesScreenState extends State<AssignedInvoicesScreen> {
  late UpcomingJobsController controller;

  @override
  void initState() {
    super.initState(); // Always call super.initState() first
    controller =
        Get.put(UpcomingJobsController(), tag: "recInvoices", permanent: false);
    controller.getTodayData();
  }

  @override
  void dispose() {
    if (Get.isRegistered<UpcomingJobsController>(tag: "recInvoices")) {
      Get.delete<UpcomingJobsController>(tag: "recInvoices");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: AppTextLabels.boldTextShort(
                              label: "Select Date", fontSize: 15)),
                      DateFilters(onOptionChange: onOptionChange),
                    ],
                  ),
                ],
              ),
            ),
            Obx(() => controller.fetchingData.value
                ? UiHelper.loader()
                : Expanded(
                    child: Column(
                    children: [
                      Expanded(child: CustomListView(
                        items: controller.assignedInvoices ?? [],
                        itemBuilder: (context, item, index)=> _listItem(index),
                      ))
                    ],
                  )))
          ],
        ),
      ),
    );
  }
  _listItem(int index){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
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
          UiHelper.buildRow("Name", controller.assignedInvoices?[index].user?.name ?? ""),
          UiHelper.buildRow("Firm Name", controller.assignedInvoices?[index].user?.name ?? ""),
          UiHelper.buildRow("Address", controller.assignedInvoices?[index].address?.address ?? "N/A"),
          UiHelper.buildRow("Amount", controller.assignedInvoices?[index].totalAmt ?? "N/A"),
          UiHelper.buildRow("Status", controller.assignedInvoices?[index].status ?? "N/A"),

          controller.assignedInvoices?[index].promiseDate != null  ? UiHelper.buildRow("Promise Date", controller.assignedInvoices?[index].promiseDate ?? "N/A") :
          controller.assignedInvoices?[index].status == "paid" ? Container():
          Column(
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child: GreenButton(
                      title: "open location",
                      sendingData: false.obs,
                      onTap: () {
                        double lat = double.parse(
                            controller.assignedInvoices?[index].address?.lat ?? "0.0");
                        double long = double.parse(
                            controller.assignedInvoices?[index].address?.lang ?? "0.0");
                        _openGoogleMaps(lat, long);
                      })),
                  SizedBox(width: 10,),
                  Expanded(child: GreenButton(
                      title: "Process",
                      sendingData: false.obs,
                      onTap: () {
                        UiHelper.navigateToNextScreen(context, ProcessInvoiceScreen(invoices: controller.assignedInvoices![index],));
                      }))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  onOptionChange(option, start, end) {
    controller.getData(UiHelper.formatDateForServer(start), UiHelper.formatDateForServer(end));
  }
  Future<void> _openGoogleMaps(double lat, double long) async {
    MyMapLauncher.openMapsWithLocation(latitude: lat, longitude: long);
  }
}
