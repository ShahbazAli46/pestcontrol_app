import 'package:accurate/SalesManagerAndSalesMan/SalesMan/Controlers/PaymentFollowUpController.dart';
import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/DateRangePicker.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentFollowUpScreen extends StatefulWidget {
  const PaymentFollowUpScreen({super.key});

  @override
  State<PaymentFollowUpScreen> createState() => _PaymentFollowUpScreenState();
}

class _PaymentFollowUpScreenState extends State<PaymentFollowUpScreen> {

  late PaymentFollowUpController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(PaymentFollowUpController());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<PaymentFollowUpController>();

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
            AppTextLabels.boldTextShort(label: "Payment Follow Ups", fontSize: 20),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextLabels.boldTextShort(label: "Select Date", fontSize: 15),
                  DateFilters(onOptionChange: onOptionChange),
                ],
              ),
            ),
            Obx(()=> controller.fetchingData.value ? UiHelper.loader() : Expanded(child: Column(
              children: [
                SelectableButtonGroup(titles: ["All", "Completed", "Pending"], onSelect: controller.filter),
                Expanded(child: CustomListView(items: controller.info ?? [], itemBuilder: (context, item, index)=>_item(index))),
              ],
            ))
            )

          ],
        ),
      ),
    );
  }

  _item(index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("Sr", "${index+1}"),
        UiHelper.buildRow("Sales Man", controller.info[index].salesMan),
        UiHelper.buildRow("Firm Name", controller.info[index].firmName),
        UiHelper.buildRow("Recovery Person Name", controller.info[index].recoveryPersonName),
        UiHelper.buildRow("Follow Up Date", UiHelper.formatDate(controller.info[index].followUpDate)),
        UiHelper.buildRow("Next Follow Up Date", controller.info[index].nextFollowUpDate == "" ?  "-" :UiHelper.formatDate(controller.info[index].nextFollowUpDate)),
        UiHelper.buildRow("Description", controller.info[index].desc),
        UiHelper.buildRow("Status", controller.info[index].status),

      ],
    ));
  }

  onOptionChange(type, start, end) {
    if (end != null) {
      String startDate = DateFormat('yyyy-MM-dd').format(start);
      String endDate = DateFormat('yyyy-MM-dd').format(end);
      controller.getData(startDate, endDate);
    }
  }
}
