import 'package:accurate/SalesManagerAndSalesMan/SalesMan/Controlers/SalesManJobsController.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/generic/DateFilters.dart';
import '../../components/generic/UIHelper.dart';
import '../../utils/appColors.dart';

class SalesmanJobsScreen extends StatefulWidget {

  bool isSingleClient = false;
  int clientID = 0;

  SalesmanJobsScreen({required this.isSingleClient, this.clientID = 0});

  @override
  State<SalesmanJobsScreen> createState() => _SalesmanJobsScreenState();
}

class _SalesmanJobsScreenState extends State<SalesmanJobsScreen> {
  late SalesManJobsController controller;


  @override
  void initState() {
    super.initState();
    controller = Get.put(SalesManJobsController(isSingleClient: widget.isSingleClient, clientId: widget.clientID));
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<SalesManJobsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              NavWithBack(),
              SizedBox(height: 20,),
              AppTextLabels.boldTextShort(label: "My Client Jobs", fontSize: 20),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Container(child: AppTextLabels.regularShortText(label: "Select Date", color: AppColors.lightTextColor),)),
                    DateFilters(onOptionChange: onOptionChange),
                  ],
                ),
              ),
              Obx(()=>controller.fetchingData.value ? UiHelper.loader() : Expanded(child: Column(
                children: [
                  SelectableButtonGroup(titles: ["Completed (${controller.completed.length})", "Pending (${controller.pending.length})"], onSelect: controller.handleButtonTypeChange),
                    Expanded(child: CustomListView(items: controller.data ?? [], itemBuilder: (context, item, index)=>jobItem(index))),
                  Container(
                    child: Container(
                      child: UiHelper.commonContainer(Row(
                        children: [
                          Expanded(child: Column(
                            children: [
                              AppTextLabels.boldTextShort(label: "Completed Total", fontSize: 15, color: AppColors.appGreen),
                              Text("${controller.completedAmount}"),
                            ],
                          )),
                          Expanded(child: Column(
                            children: [
                              AppTextLabels.boldTextShort(label: "Pending Total", fontSize: 15, color: AppColors.appGreen),
                              Text("${controller.pendingAmount}"),
                            ],
                          ))
                        ],
                      )),
                    )
                  )


                ],
              )))

            ],
          ),
        ));
  }

  onOptionChange (name, start, end){
    String startDate = UiHelper.formatDateForServer(start);
    String endDate = UiHelper.formatDateForServer(end);
    controller.getData(startDate, endDate);
  }

  jobItem(int index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("Sr", "${index + 1}"),
        UiHelper.buildRow("Job ID", "${controller.data?[index].id}"),
        UiHelper.buildRow("Firm Name", controller.data?[index].user?.client?.firmName ?? ""),
        UiHelper.buildRow("Service Amount", controller.data?[index].grandTotal ?? ""),
        UiHelper.buildRow("Service Date", UiHelper.formatDate(controller.data?[index].rescheduleDates?.last.jobDate ?? "")),
      ],
    ));
  }
}
