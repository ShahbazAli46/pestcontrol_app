import 'package:accurate/SalesManagerAndSalesMan/SalesMan/Controlers/SalesmanIcomeController.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appColors.dart';

class SalesmanIncomeScreen extends StatefulWidget {


  @override
  State<SalesmanIncomeScreen> createState() => _SalesmanIncomeScreenState();
}

class _SalesmanIncomeScreenState extends State<SalesmanIncomeScreen> {

  late SalesmanIncomeController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SalesmanIncomeController(userId: userObj?.data?.id ?? 0));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SalesmanIncomeController>();
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
            AppTextLabels.boldTextShort(label: "My Client Income Report", fontSize: 20),
            SizedBox(height: 20,),

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
                UiHelper.commonContainer(Row(
                  children: [
                    Expanded(child: UiHelper.buildRow("Paid", "${controller.completedAmount}")),
                    Expanded(child: UiHelper.buildRow("Pending", "${controller.pendingAmount}")),
                  ],
                )),
                SelectableButtonGroup(titles: ["Paid (${controller.completed.length})", "Pending (${controller.pending.length})"], onSelect: controller.handleChange),
                Expanded(child: CustomListView(items: controller.data ?? [], itemBuilder: (context, item, index)=> invoiceItem(index)))
              ],
            )))

          ],
        ),
      ),
    );
  }

  onOptionChange (name, start, end){
    String startDate = UiHelper.formatDateForServer(start);
    String endDate = UiHelper.formatDateForServer(end);
    controller.getData(startDate, endDate);
  }

  invoiceItem(index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("sr", "${index + 1}"),
        UiHelper.buildRow("Firm Name", controller.data?[index]?.user?.client?.firmName ?? ""),
        UiHelper.buildRow("Invoice Date", controller.data?[index]?.issuedDate ?? ""),
        UiHelper.buildRow("Amount", controller.data?[index]?.totalAmt ?? ""),
        UiHelper.buildRow("Remaining", "${double.parse(controller.data?[index]?.totalAmt ?? "") - double.parse(controller.data?[index]?.paidAmt ?? "") }"),

      ],
    ));
  }
}
