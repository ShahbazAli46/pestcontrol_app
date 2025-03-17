import 'package:accurate/SalesManagerAndSalesMan/SalesMan/Controlers/SalesOfficerDashboardController.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/generic/DateFilters.dart';
import '../../utils/appColors.dart';

class SalesmanContractsListScreen extends StatefulWidget {
  const SalesmanContractsListScreen({Key? key}) : super(key: key);

  @override
  State<SalesmanContractsListScreen> createState() => _SalesmanContractsListScreenState();
}

class _SalesmanContractsListScreenState extends State<SalesmanContractsListScreen> {
  late SalesOfficerDashboardController controller;



  @override
  void initState() {
    super.initState();
    controller = Get.find(tag: Constants.salesMan);

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
            AppTextLabels.boldTextShort(label: "Contracts List", fontSize: 20),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Container(child: AppTextLabels.regularShortText(label: "Select Date", color: AppColors.lightTextColor),)),
                  DateFilters(onOptionChange: onOptionChange, ),
                ],
              ),
            ),

            SizedBox(height: 10,),
            Obx(()=>controller.gettingContracts.value ? Container() : Expanded(
              child: Column(
                children: [
                  SelectableButtonGroup(titles: ["All (${controller.allFiltered.length})", "Active (${controller.filteredActiveContractsList.length})", "Canceled (${controller.filteredCanceledContractsList.length})", "Completed (${controller.filteredCompletedContractsList.length})"], onSelect: onSelect),
                  Expanded(child: CustomListView(items: controller.listToShowContracts, itemBuilder: (context, item, index)=>contractItem(index))),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: UiHelper.commonContainer(Column(
                          children: [
                            AppTextLabels.boldTextShort(label: "All", fontSize: 12, color: AppColors.appBlack),
                            AppTextLabels.boldTextShort(label: "${controller.allFilteredAmount.toStringAsFixed(2)}", fontSize: 12, color: AppColors.appGreen),

                          ],
                        )),
                      ),
                      Expanded(
                        child: UiHelper.commonContainer(Column(
                          children: [
                            AppTextLabels.boldTextShort(label: "Active", fontSize: 12, color: AppColors.appBlack),
                            AppTextLabels.boldTextShort(label: "${controller.filteredActiveAmount.toStringAsFixed(2)}", fontSize: 12, color: AppColors.appGreen),

                          ],
                        )),
                      ),
                      Expanded(
                        child: UiHelper.commonContainer(Column(
                          children: [
                            AppTextLabels.boldTextShort(label: "Canceled", fontSize: 12, color: AppColors.appBlack),
                            AppTextLabels.boldTextShort(label: "${controller.filteredCanceledAmount.toStringAsFixed(2)}", fontSize: 12, color: AppColors.appGreen),

                          ],
                        )),
                      ),
                      Expanded(
                        child: UiHelper.commonContainer(Column(
                          children: [
                            AppTextLabels.boldTextShort(label: "Complete", fontSize: 12, color: AppColors.appBlack),
                            AppTextLabels.boldTextShort(label: "${controller.filteredCompletedAmount.toStringAsFixed(2)}", fontSize: 12, color: AppColors.appGreen),

                          ],
                        )),
                      ),
                    ],
                  )
                ],
              ),
            )),

          ],
        ),
      ),
    );
  }

  onOptionChange (name, start, end){
    String startDate = UiHelper.formatDateForServer(start);
    String endDate = UiHelper.formatDateForServer(end);
    controller.filterList(startDate, endDate);

  }

  onSelect(int type){
    controller.setContractsType(type);
  }

  contractItem(int index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("Sr", "${index + 1}"),
        UiHelper.buildRow("Firm Name", "${controller.listToShowContracts[index].user?.client?.firmName}"),
        UiHelper.buildRow("Amount", "${controller.listToShowContracts[index].grandTotal}"),
        UiHelper.buildRow("Total Jobs", "${controller.listToShowContracts[index].jobs?[0].totalJobs}"),
        UiHelper.buildRow("Completed Jobs", "${controller.listToShowContracts[index].jobs?[0].completedJobs}"),
        UiHelper.buildRow("Expire at", UiHelper.formatDate(controller.listToShowContracts[index].contractEndDate ?? "")),
        controller.listToShowContracts[index].contractCancelledAt != null ? UiHelper.buildRow("Canceled at", UiHelper.formatDate(controller.listToShowContracts[index].contractCancelledAt ?? "")) : Container(),
        controller.listToShowContracts[index].contractCancelledAt != null ? UiHelper.buildRow("Reasone", controller.listToShowContracts[index].contractCancelReason ?? "") : Container()
      ],
    ));
  }
}
