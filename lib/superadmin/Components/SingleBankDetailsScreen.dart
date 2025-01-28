import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/SingleBankDetailsResponse.dart';
import 'package:accurate/superadmin/Controllers/SingleBankDetailsController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:get/get.dart';

class SingleBankDetailsScreen extends StatefulWidget {
  int bankID;

  SingleBankDetailsScreen({required this.bankID});

  @override
  State<SingleBankDetailsScreen> createState() =>
      _SingleBankDetailsScreenState();
}

class _SingleBankDetailsScreenState extends State<SingleBankDetailsScreen> {
  late SingleBankDetailsController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = Get.put(SingleBankDetailsController(bankID: widget.bankID));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SingleBankDetailsController>();
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
            Obx(() => controller.fetchingData.value
                ? UiHelper.loader()
                : Expanded(
                    child: Column(
                      children: [
                        AppTextLabels.boldTextShort(
                            label: controller.data?.bankName ?? "",
                            fontSize: 20),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: UiHelper.buildRow(
                                "Balance", controller.data?.balance ?? "")),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: CustomListView(
                            items: controller.ledgers ?? [],
                            itemBuilder: (context, item, index) =>
                                bankItem(index),
                          ),
                        ),
                      ],
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  bankItem(int index) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          UiHelper.buildRow("Date",
              "${UiHelper.formatDate(controller.ledgers[index].createdAt ?? "")}"),
          UiHelper.buildRow(
              "Description", "${controller.ledgers[index].description ?? ""}"),
          UiHelper.buildRow(
              "Client / Supplier", "${getRef(controller.ledgers[index])}"),
          UiHelper.buildRow("Transaction ID",
              "${controller.ledgers[index].transectionId ?? ""}"),
          UiHelper.buildRow(
              "Debit", "${controller.ledgers[index]?.drAmt ?? ""}"),
          UiHelper.buildRow(
              "Credit", "${controller.ledgers[index]?.crAmt ?? ""}"),
        ],
      ),
    );
  }

  String getRef(SingleBankDetailsResponseDataLedgers item) {
    if (item.referenceable == null) {
      return "-";
    } else if (item.referenceableType == "App\\Models\\Supplier") {
      return item.referenceable?.supplierName ?? "";
    } else {
      return item.referenceable?.name ?? "";
    }
  }
}
