import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Components/AddExpenseScreen.dart';
import 'package:accurate/superadmin/Components/AddVehicleExpenseScreen.dart';
import 'package:accurate/superadmin/Components/SingleExpenseDetailsScreen.dart';
import 'package:accurate/superadmin/Controllers/ExpensesController.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Components/SingleVehicleDetailsScreen.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  late ExpensesController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ExpensesController(), tag: Constants.expensesController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            NavWithBack(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
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
                            Row(
                              children: [
                                AppTextLabels.boldTextShort(
                                    label: "All Expenses", fontSize: 20),
                                Expanded(child: Container()),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DateFilters(onOptionChange: onOptionChange),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                AppTextLabels.boldTextShort(
                                    label: "Total Amount", fontSize: 15),
                                Expanded(child: Container()),
                                Obx(
                                  () => controller.fetchingTotalExpense.value
                                      ? CircularProgressIndicator()
                                      : Column(
                                          children: [
                                            AppTextLabels.boldTextShort(
                                                label:
                                                    "${UiHelper.formatUAECurrency(double.parse("${controller.expenses.data?.totalExpense}"))}",
                                                fontSize: 15),
                                          ],
                                        ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            UiHelper.dashedBoarder(),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    AppTextLabels.boldTextShort(
                                        label: "Vehicle Expense",
                                        fontSize: 15,
                                        color: AppColors.appGreen),
                                    Obx(
                                      () => controller.fetchingTotalExpense.value
                                          ? CircularProgressIndicator()
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                AppTextLabels.boldTextShort(
                                                    label:
                                                        "${UiHelper.formatUAECurrency(double.parse(controller.expenses.data?.vehicleExpense?.total ?? ""))}",
                                                    fontSize: 15),
                                              ],
                                            ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    AppTextLabels.boldTextShort(
                                        label: "Other Expense",
                                        fontSize: 15,
                                        color: AppColors.appGreen),
                                    Obx(
                                      () => controller.fetchingTotalExpense.value
                                          ? CircularProgressIndicator()
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                AppTextLabels.boldTextShort(
                                                    label:
                                                        "${UiHelper.formatUAECurrency(double.parse(controller.expenses.data?.normalExpense?.total ?? ""))}",
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
                        height: 20,
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
                                      () => controller.fetchingTotalExpense.value
                                          ? CircularProgressIndicator()
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                AppTextLabels.boldTextShort(
                                                    label:
                                                        "${UiHelper.formatDateToMonthYear(controller.expenses.startDate ?? "")}",
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
                                      () => controller.fetchingTotalExpense.value
                                          ? CircularProgressIndicator()
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                AppTextLabels.boldTextShort(
                                                    label:
                                                        "${UiHelper.formatDateToMonthYear(controller.expenses.endDate ?? "")}",
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
                        height: 20,
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Add this
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: AppColors.appGreen
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: AppTextLabels.boldTextShort(
                                              label: "Expenses",
                                              color: Colors.white,
                                              fontSize: 20
                                          )
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          UiHelper.navigateToNextScreen(context, AddExpenseScreen());
                                        },
                                        child: Obx(()=> controller.fetchingTotalExpense.value ? Container() : Container(
                                            color: AppColors.appGreen,
                                            width: 50,
                                            margin: EdgeInsets.only(left: 10),
                                            child: AppTextLabels.boldTextShort(
                                                label: "+",
                                                color: Colors.white,
                                                fontSize: 20
                                            )
                                        )) ,
                                      ),

                                    ],
                                  ),
                                ),
                                Obx(() => controller.fetchingTotalExpense.value
                                    ? CircularProgressIndicator()
                                    : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: Center(
                                            child: AppTextLabels.regularShortText(
                                                label: "Sr",
                                                color: AppColors.appBlack
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            child: Row(
                                              children: [
                                                AppTextLabels.regularShortText(
                                                    label: "Expense Category",
                                                    color: AppColors.appBlack
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 100,
                                          child: Center(
                                            child: AppTextLabels.regularShortText(
                                                label: "Amount",
                                                color: AppColors.appBlack
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 30,)
                                      ],
                                    ),
                                    UiHelper.dashedBoarder(),
                                    CustomListView(
                                        shrinkWrap: true,
                                        isPrimary: false,
                                        physics: NeverScrollableScrollPhysics(),
                                        items: controller.listResponse.data ?? [],
                                        itemBuilder: (contxt, item, index) => expenseItem(index)
                                    ),
                                  ],
                                )
                                ),
                                SizedBox(height: 20,)
                              ],
                            ),
                          )
                      ),
                      SizedBox(
                        height: 20,
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Add this
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: AppColors.appGreen
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: AppTextLabels.boldTextShort(
                                              label: "Vehicle Expenses",
                                              color: Colors.white,
                                              fontSize: 20
                                          )
                                      ),
                                      Expanded(child: Container()),
                                      GestureDetector(
                                        onTap: (){
                                          UiHelper.navigateToNextScreen(context, AddVehicleExpenseScreen());
                                        },
                                        child: Obx(()=> controller.fetchingTotalExpense.value ? Container() : Container(
                                            color: AppColors.appGreen,
                                            width: 50,
                                            margin: EdgeInsets.only(left: 10),
                                            child: AppTextLabels.boldTextShort(
                                                label: "+",
                                                color: Colors.white,
                                                fontSize: 20
                                            )
                                        )) ,
                                      ),

                                    ],
                                  ),
                                ),
                                Obx(() => controller.fetchingTotalExpense.value
                                    ? CircularProgressIndicator()
                                    : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: Center(
                                            child: AppTextLabels.regularShortText(
                                                label: "Sr",
                                                color: AppColors.appBlack
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            child: Row(
                                              children: [
                                                AppTextLabels.regularShortText(
                                                    label: "Expense Category",
                                                    color: AppColors.appBlack
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 100,
                                          child: Center(
                                            child: AppTextLabels.regularShortText(
                                                label: "Amount",
                                                color: AppColors.appBlack
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 30,)
                                      ],
                                    ),
                                    UiHelper.dashedBoarder(),
                                    CustomListView(
                                        shrinkWrap: true,
                                        isPrimary: false,
                                        physics: NeverScrollableScrollPhysics(),
                                        items: controller.vehicleExpenseListResponse.data ?? [],
                                        itemBuilder: (contxt, item, index) => vehExpenseItem(index)
                                    ),
                                  ],
                                )
                                ),
                                SizedBox(height: 20,)
                              ],
                            ),
                          )
                      ),

                    ],
                  ),
                ),
              ),
            )
          ],
        )));
  }

  Widget expenseItem(int index) {
    return GestureDetector(
      onTap: (){
        UiHelper.navigateToNextScreen(context, SingleExpenseDetailsScreen(expenseId: controller.listResponse.data?[index].id ?? 0, categoryName: controller.listResponse.data?[index].expenseCategory ?? "",));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [

            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Center(child: AppTextLabels.regularShortText(label: "${index + 1}", color: AppColors.appBlack),),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    child: Row(
                      children: [
                        AppTextLabels.regularShortText(label: "${controller.listResponse.data?[index].expenseCategory ?? ""}", color: AppColors.appBlack),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      child: Center(child: AppTextLabels.regularShortText(label: "${UiHelper.formatUAECurrency(double.parse(controller.listResponse.data?[index].totalAmount ?? ""))}", color: AppColors.appBlack),),
                    ),
                    Icon(Icons.chevron_right_sharp, size: 20, color: AppColors.appGreen,),
                    SizedBox(width: 10,)
                  ],
                ),
              ],
            ),
            UiHelper.dashedBoarder(),

          ],
        )
      ),
    );
  }

  Widget vehExpenseItem(int index) {
    return GestureDetector(
      onTap: () {
        UiHelper.navigateToNextScreen(context, SingleVehicleDetailsScreen(vehicleId:controller.vehicleExpenseListResponse.data?[index].id ?? 0 ,));
      },
      child: Container(
        color: Colors.white,
          child: Column(
            children: [

              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Center(child: AppTextLabels.regularShortText(label: "${index + 1}", color: AppColors.appBlack),),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          AppTextLabels.regularText(label: "${controller.vehicleExpenseListResponse.data?[index].modalName ?? ""} - ${controller.vehicleExpenseListResponse.data?[index].vehicleNumber }", color: AppColors.appBlack),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 100,
                        child: Center(child: AppTextLabels.regularShortText(label: "${UiHelper.formatUAECurrency(double.parse(controller.vehicleExpenseListResponse.data?[index].totalAmount ?? ""))}", color: AppColors.appBlack),),
                      ),
                      Icon(Icons.chevron_right_sharp, size: 20, color: AppColors.appGreen,),
                      SizedBox(width: 10,)
                    ],
                  ),
                ],
              ),
              UiHelper.dashedBoarder(),

            ],
          )
      ),
    );
  }

  onOptionChange(type, start, end) {
    if (end != null) {
      String startDate = DateFormat('yyyy-MM-dd').format(start);
      String endDate = DateFormat('yyyy-MM-dd').format(end);
      controller.getTotalExpense(startDate, endDate);
    }
  }
}
