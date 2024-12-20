import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/AllInvoicesController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/MakePaymentScreen.dart';

class ViewAllInvoicesScreen extends StatefulWidget {


  @override
  State<ViewAllInvoicesScreen> createState() => _ViewAllInvoicesScreenState();
}

class _ViewAllInvoicesScreenState extends State<ViewAllInvoicesScreen> {
  late AllInvoicesController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(AllInvoicesController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<AllInvoicesController>();
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
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  AppTextLabels.boldTextShort(
                      label: "All Invoices", fontSize: 20),
                  Expanded(child: Container()),
                  DateFilters(onOptionChange: onOptionChange)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SelectableButtonGroup(
                titles: ["All", "Paid", "Unapid"], onSelect: listTypeChanged),
            SizedBox(
              height: 20,
            ),
            Obx(() => controller.fetchingData.value
                ? UiHelper.loader()
                : Expanded(
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      AppTextLabels.boldTextShort(
                                          label: "Start Date", fontSize: 15),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AppTextLabels.regularShortText(
                                          label: UiHelper.formatDate(
                                              controller.apiStartDate.value),
                                          color: AppColors.appGreen)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      AppTextLabels.boldTextShort(
                                          label: " End Date", fontSize: 15),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AppTextLabels.regularShortText(
                                          label: UiHelper.formatDate(
                                              controller.apiEndDate.value),
                                          color: AppColors.appGreen)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      AppTextLabels.boldTextShort(
                                          label: "Received Amount", fontSize: 15),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AppTextLabels.regularShortText(
                                          label:
                                              "${UiHelper.formatUAECurrency(controller.paidAmount.value)}",
                                          color: AppColors.appGreen)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      AppTextLabels.boldTextShort(
                                          label: "Receivable Amount",
                                          fontSize: 15),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AppTextLabels.regularShortText(
                                          label:
                                              "${UiHelper.formatUAECurrency(controller.unpaidAmount.value)}",
                                          color: AppColors.appGreen)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        UiHelper.dashedBoarder(),
                        SizedBox(height: 10,),
                        Flexible(
                          child: CustomListView(
                            items: controller.selectedTypeList ?? [],
                            itemBuilder: (context, item, index) => invoiceItem(index),
                            onRefresh: ()async{

                            },
                          )
                        )
                      ],
                    ),
                )),
          ],
        ),
      ),
    );
  }


  Widget invoiceItem(int index){
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
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextLabels.regularShortText(label: "Client Name", color: AppColors.appGreen),
                    AppTextLabels.boldTextShort(label: controller?.selectedTypeList?[index]?.user?.name ?? "", fontSize: 18),
                    SizedBox(height: 10,),
                    AppTextLabels.regularShortText(label: "Sales Man", color: AppColors.appGreen, fontSize: 12),
                    AppTextLabels.boldTextShort(label: controller?.selectedTypeList?[index]?.user?.name ?? "", fontSize: 18),
                    SizedBox(height: 10,)
                  ],
                ),
              ],
            ),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextLabels.regularShortText(label: "Invoice Id", color: AppColors.appGreen),
                    AppTextLabels.boldTextShort(label: controller?.selectedTypeList?[index]?.serviceInvoiceId ?? "", fontSize: 18)
                  ],
                ),
                Expanded(child: Container(child: Text(""),)),
                Container(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextLabels.regularShortText(label: "Issue Date", color: AppColors.appGreen),
                      AppTextLabels.boldTextShort(label: UiHelper.formatDate(controller?.selectedTypeList[index]?.issuedDate ?? "") , fontSize: 18)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextLabels.regularShortText(label: "Total Amount", color: AppColors.appGreen),
                    AppTextLabels.boldTextShort(label: controller?.selectedTypeList[index]?.totalAmt ?? "", fontSize: 18)
                  ],
                ),
                Expanded(child: Container(child: Text(""),)),
                Container(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextLabels.regularShortText(label: "Paid Amount", color: AppColors.appGreen),
                      AppTextLabels.boldTextShort(label: controller?.selectedTypeList[index]?.paidAmt ?? "" , fontSize: 18)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  onOptionChange(type, start, end) {
    if (end != null) {
      String startDate = DateFormat('yyyy-MM-dd').format(start);
      String endDate = DateFormat('yyyy-MM-dd').format(end);
      controller.fetchData(startDate: startDate, endDate: endDate);
    }
  }

  listTypeChanged(int type) {
    controller.setType(type);
  }
}
