import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/SingleExpenseDetailsController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleExpenseDetailsScreen extends StatefulWidget {
  int expenseId = 0;
  String categoryName = "";

  SingleExpenseDetailsScreen(
      {required this.expenseId, required this.categoryName});

  @override
  State<SingleExpenseDetailsScreen> createState() =>
      _SingleExpenseDetailsScreenState();
}

class _SingleExpenseDetailsScreenState
    extends State<SingleExpenseDetailsScreen> {
  late SingleExpenseDetailsController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        Get.put(SingleExpenseDetailsController(expesnseId: widget.expenseId));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SingleExpenseDetailsController>();
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
                      label: "${widget.categoryName}", fontSize: 20),
                  Expanded(child: Container()),
                  DateFilters(onOptionChange: onOptionChange)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          AppTextLabels.boldTextShort(
                              label: "Start Date",
                              fontSize: 15,
                              color: AppColors.appGreen),
                          Obx(
                            () => controller.fetchingData.value
                                ? CircularProgressIndicator()
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AppTextLabels.boldTextShort(
                                          label:
                                              "${UiHelper.formatDate(controller.startDate.value)}",
                                          fontSize: 15),
                                    ],
                                  ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          AppTextLabels.boldTextShort(
                              label: "End Date",
                              fontSize: 15,
                              color: AppColors.appGreen),
                          Obx(
                            () => controller.fetchingData.value
                                ? CircularProgressIndicator()
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AppTextLabels.boldTextShort(
                                          label:
                                              "${UiHelper.formatDate(controller.endDate.value)}",
                                          fontSize: 15),
                                    ],
                                  ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
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
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: AppTextLabels.regularShortText(
                          label: "Sr", color: AppColors.appBlack),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    child: Row(
                      children: [
                        AppTextLabels.regularShortText(
                            label: "Date", color: AppColors.appBlack),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          AppTextLabels.regularShortText(
                              label: "Name", color: AppColors.appBlack),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          AppTextLabels.regularShortText(
                              label: "Amount", color: AppColors.appBlack),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: AppTextLabels.regularShortText(
                          label: "Receipt",
                          color: AppColors.appBlack,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => controller.fetchingData.value
                ? UiHelper.loader()
                : Expanded(
                    child: CustomListView(
                        items: controller
                                .singleExpenseDetailsResponse.data?.expenses ??
                            [],
                        itemBuilder: (context, item, index) =>
                            expnesItem(index)))),
            Obx(()=> controller.fetchingData.value ? CircularProgressIndicator() :  Container(
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
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppTextLabels.boldTextShort(label: "Total", color: AppColors.appBlack, fontSize: 17),
                    AppTextLabels.boldTextShort(label: "${UiHelper.formatUAECurrency(controller.total)}", color: AppColors.appGreen, fontSize: 17),
                  ],
                ),
              ),
            ) )
          ],
        ),
      ),
    );
  }

  Widget expnesItem(int index) {
    return Container(
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
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: Center(
              child: AppTextLabels.regularShortText(
                  label: "${index + 1}", color: AppColors.appBlack),
            ),
          ),
          Container(
            height: 50,
            width: 100,
            child: Row(
              children: [
                AppTextLabels.regularText(
                    label:
                        "${UiHelper.formatDate(controller.singleExpenseDetailsResponse.data?.expenses?[index].expenseDate ?? "")}",
                    color: AppColors.appBlack),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: Row(
                children: [
                  AppTextLabels.regularText(
                      label:
                          "${controller.singleExpenseDetailsResponse.data?.expenses?[index].expenseName ?? ""}",
                      color: AppColors.appBlack),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: Row(
                children: [
                  AppTextLabels.regularShortText(
                      label:
                          "${UiHelper.formatUAECurrency(double.parse(controller.singleExpenseDetailsResponse.data?.expenses?[index].amount ?? ""))}",
                      color: AppColors.appBlack),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              String url = controller.singleExpenseDetailsResponse.data
                      ?.expenses?[index].expenseFile ??
                  "";
              if (url.isNotEmpty) {
                Uri uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  // Handle the error, e.g., show a dialog or a message to the user.
                  print("Could not launch $url");
                }
              }
            },
            child: Container(
              height: 50,
              color: Colors.white,
              width: 50,
              child: Center(
                child: AppTextLabels.regularShortText(
                  label: "Receipt",
                  color: AppColors.appGreen,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onOptionChange(type, start, end) {
    if (end != null) {
      String startDate = DateFormat('yyyy-MM-dd').format(start);
      String endDate = DateFormat('yyyy-MM-dd').format(end);
      controller.getDetails(startDate, endDate);
    }
  }
}
