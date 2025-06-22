import 'package:accurate/SalesManagerAndSalesMan/SalesMan/SalesManJobsScreen.dart';
import 'package:accurate/SalesManagerAndSalesMan/SalesMan/SalesmanIncomeScreen.dart';
import 'package:accurate/SalesManagerAndSalesMan/SalesMan/ViewVisitsScreen.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/MonthPicker.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/SalesManController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesManScreen extends StatefulWidget {
  const SalesManScreen({super.key});

  @override
  State<SalesManScreen> createState() => _SalesManScreenState();
}

class _SalesManScreenState extends State<SalesManScreen> {

    late SalesManController controller;


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SalesManController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SalesManController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          NavWithBack(),
          SizedBox(height: 20,),
          AppTextLabels.boldTextShort(label: "Sales Man Report", color: AppColors.appBlack, fontSize: 20),
          SizedBox(height: 20,),

          MonthPicker(onMonthChanged: controller.onDateChange),
          SizedBox(height: 20,),

          Obx(() => Expanded(
            child: controller.fetchingData.value
                ? UiHelper.loader()
                : CustomListView(
              items: controller.data ?? [],
              itemBuilder: (context, item, index) => salesmanItem(index),
            ),
          ))
        ],
      )),
    );;
  }
  
  salesmanItem(index){
      return UiHelper.commonContainer(Column(
        children: [
          Padding(padding: EdgeInsets.all(8), child: AppTextLabels.boldTextShort(label: "${controller.data?[index].name}", fontSize: 20),),
          UiHelper.buildRow("Contract Target", "${controller.data?[index].empContractTargets?[0].contractTarget}"),
          UiHelper.buildRow("Achieved Target", "${controller.data?[index].empContractTargets?[0].achievedTarget}"),
          UiHelper.buildRow(
            "Achieved %",
            calculateAchievedPercentage(
              achievedTarget: controller.data?[index].empContractTargets?[0].achievedTarget,
              contractTarget: controller.data?[index].empContractTargets?[0].contractTarget,
            ),
          ),
          UiHelper.buildRow("Remaining Target", "${controller.data?[index].empContractTargets?[0].remainingTarget}"),
          SizedBox(height: 10,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 10,),
          AppTextLabels.boldTextShort(label: "Cash Sale Info", fontSize: 15),
          SizedBox(height: 10,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 10,),
          UiHelper.buildRow("MTD Sales", "${controller.data?[index].employeeCommissions?[0].target}"),
          UiHelper.buildRow("Cash Received", "${controller.data?[index].employeeCommissions?[0].sale}"),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){
                UiHelper.navigateToNextScreen(context, SalesmanIncomeScreen(agentID: "${controller.data?[index].id ?? 0}", agentName: controller.data?[index].name,));
              }, child: AppTextLabels.regularShortText(label: "View Income", color: AppColors.appGreen)),

              TextButton(onPressed: (){
                UiHelper.navigateToNextScreen(context, SalesmanJobsScreen(agentID: "${controller.data?[index].id ?? 0}", agentName: controller.data?[index].name, isSingleClient: false));
              }, child: AppTextLabels.regularShortText(label: "View Jobs", color: AppColors.appGreen)),

              TextButton(onPressed: (){
                UiHelper.navigateToNextScreen(context, ViewVisitsScreen(agentID: "${controller.data?[index].id ?? 0}", agentName: controller.data?[index].name));
              }, child: AppTextLabels.regularShortText(label: "View Visits", color: AppColors.appGreen)),
            ],
          )
        ],
      ));
  }


    String calculateAchievedPercentage({
      required String? achievedTarget,
      required String? contractTarget,
      int decimalPlaces = 2,
      String zeroDivisionText = 'N/A',
    }) {
      // Convert strings to numbers safely
      final achieved = double.tryParse(achievedTarget?.replaceAll(',', '') ?? '0') ?? 0;
      final contract = double.tryParse(contractTarget?.replaceAll(',', '') ?? '0') ?? 0;

      // Handle division by zero
      if (contract == 0) return zeroDivisionText;

      // Calculate and format percentage
      final percentage = (achieved / contract * 100);
      return '${percentage.toStringAsFixed(decimalPlaces)}%';
    }
}
