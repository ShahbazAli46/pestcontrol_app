import 'package:accurate/AccountantDashboard/Controllers/PaymentsController.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {

  late PaymentsController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(PaymentsController());

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<PaymentsController>();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          NavWithBack(),
          SizedBox(height: 20,),
          AppTextLabels.boldTextShort(label: "Payments", fontSize: 20),
          SizedBox(height: 20,),
          DateFilters(onOptionChange: onOptionChange),
          Obx(()=> controller.fetchingData.value ? UiHelper.loader() : Expanded(child: Column(
            children: [
              SelectableButtonGroup(titles: ["Cash", "Cheque", "Online"], onSelect: (index){controller.changetype(index);}),
              Expanded(child: CustomListView(items: controller.data, itemBuilder: (context, item, index)=>_buildItem(index))),
              UiHelper.commonContainer(Row(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextLabels.boldTextShort(label: "Cash", color: AppColors.appGreen, fontSize: 15),
                      AppTextLabels.boldTextShort(label: "${controller.cashTotal.toStringAsFixed(2)}", color: AppColors.appGreen, fontSize: 15),
                    ],
                  )),

                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextLabels.boldTextShort(label: "Cheque", color: AppColors.appGreen, fontSize: 15),
                      AppTextLabels.boldTextShort(label: "${controller.chequeTotal.toStringAsFixed(2)}", color: AppColors.appGreen, fontSize: 15),
                    ],
                  )),

                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextLabels.boldTextShort(label: "Online", color: AppColors.appGreen, fontSize: 15),
                      AppTextLabels.boldTextShort(label: "${controller.onlineTotal.toStringAsFixed(2)}", color: AppColors.appGreen, fontSize: 15),
                    ],
                  )),
                ],
              ))
            ],
          )))




        ],
      )),
    );
  }
  _buildItem(index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("Sr", "${index + 1}"),
        UiHelper.buildRow("Description:", "${controller.data[index].description ?? ""}"),
        UiHelper.buildRow("Amount", "${UiHelper.formatUAECurrency(double.parse(controller.data[index].drAmt ?? ""))}"),
        UiHelper.buildRow("Paid By: ", "${controller.data[index].personable?.name ?? ""}"),
        controller.data[index].referenceableType == "App\\Models\\Supplier" ? UiHelper.buildRow("Paid to: ", "${controller.data[index].referenceable?.supplierName ?? ""}") : controller.data[index].referenceableType == "App\\Models\\Vehicle" ? UiHelper.buildRow("Paid to: ", "${controller.data[index].referenceable?.vehicleNumber ?? ""}") : controller.data[index].referenceableType == "App\\Models\\User" ?UiHelper.buildRow("Paid to: ", "${controller.data[index].referenceable?.name ?? ""}"): Container(),
        controller.data[index].paymentType == "cheque" ?
        UiHelper.buildRow("Cheque Info", "Date : ${controller.data[index].chequeDate}\n Chq No : ${controller.data[index].chequeNo}") : Container()

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
