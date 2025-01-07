import 'package:accurate/components/generic/MonthPicker.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/FinancialReportController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FinancialReportScreen extends StatefulWidget {
  const FinancialReportScreen({Key? key}) : super(key: key);

  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> {


  late FinancialReportController controller;


  @override
  void initState() {
    super.initState();
    controller = Get.put(FinancialReportController(), tag: 'financialReport');
  }

  @override
  void dispose() {
    Get.deleteAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            Container(
              margin: EdgeInsets.all(20),
                child: MonthPicker(onMonthChanged: onMonthChanged)),
            Obx(()=> controller.fetchingData.value ? UiHelper.loader() : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    closingReport(),
                    cashReport()


                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  onMonthChanged(month){
    List<DateTime> dates = UiHelper.getFirstAndLastDateOfMonth(month);
    String startDate = DateFormat('yyyy-MM-dd').format(dates[0]); // prints: 2024-12-01
    String endDate = DateFormat('yyyy-MM-dd').format(dates[1]); // prints: 2024-12-31
    controller.getData(startDate, endDate);
  }


  Widget closingReport(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.2,
            blurRadius: 5,
            offset: Offset(0, 0.2),
          ),
        ],
      ),
      child: Column(
        children: [
          AppTextLabels.boldTextShort(label: "Closing Report", color: AppColors.appBlack, fontSize: 20),
          SizedBox(height: 20,),
          UiHelper.buildRow("Supplier Amount", "${UiHelper.formatUAECurrency(double.parse(controller.financialReportResponse.data?.supplierBalance ?? ""))}"),
          SizedBox(height: 5,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 5,),
          UiHelper.buildRow("Purchases of the month", "${UiHelper.formatUAECurrency(double.parse(controller.financialReportResponse.data?.purchaseOrder ?? ""))}"),
          SizedBox(height: 5,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 5,),
          UiHelper.buildRow("Salaries", "${UiHelper.formatUAECurrency(double.parse(controller.financialReportResponse.data?.paidEmployeeSalary ?? ""))}"),
          SizedBox(height: 5,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 5,),
          UiHelper.buildRow("Commission", "${UiHelper.formatUAECurrency(double.parse(controller.financialReportResponse.data?.paidEmployeeComm ?? ""))}"),
          SizedBox(height: 5,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 5,),
          UiHelper.buildRow("Vehicle Expenses", "${UiHelper.formatUAECurrency(controller.totalVehAmount)}"),
          SizedBox(height: 5,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 5,),
          UiHelper.buildRow("Other Expenses", "${UiHelper.formatUAECurrency(controller.totalGeneralExpAmount)}"),
          SizedBox(height: 20,),
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: AppColors.appGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppTextLabels.boldTextShort(label: "Total", color: AppColors.appGreen, fontSize: 18),
                AppTextLabels.boldTextShort(label: "${UiHelper.formatUAECurrency(controller.overAllTotalExpense)}", color: AppColors.appGreen, fontSize: 18),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget cashReport(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.2,
            blurRadius: 5,
            offset: Offset(0, 0.2),
          ),
        ],
      ),
      child: Column(
        children: [
          AppTextLabels.boldTextShort(label: "Cash Reports", color: AppColors.appBlack, fontSize: 20),
          SizedBox(height: 20,),
          SizedBox(height: 5,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 5,),
          UiHelper.buildRow("Cash ", "${UiHelper.formatUAECurrency(double.parse(controller.cashReceviedResponse.data?.totalCash ?? ""))}"),
          SizedBox(height: 5,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 5,),
          UiHelper.buildRow("Bank ", "${UiHelper.formatUAECurrency(double.parse(controller.bankCollectionResponse.data?.totalChequeTransfer ?? ""))}"),
          SizedBox(height: 5,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 5,),
          UiHelper.buildRow("POS ", "${UiHelper.formatUAECurrency(double.parse(controller.posCollectionResponse?.data?.totalPos ?? ""))}"),
          SizedBox(height: 5,),
          UiHelper.dashedBoarder(),
          SizedBox(height: 5,),
          UiHelper.buildRow("Pending Payments ", "${UiHelper.formatUAECurrency(controller.totalPendingPayment)}"),
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: AppColors.appGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppTextLabels.boldTextShort(label: "Total", color: AppColors.appGreen, fontSize: 18),
                AppTextLabels.boldTextShort(label: "${UiHelper.formatUAECurrency(controller.overAllRecevied)}", color: AppColors.appGreen, fontSize: 18),
              ],
            ),
          )
        ],
      ),
    );
  }
}
