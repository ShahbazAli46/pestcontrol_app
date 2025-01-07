import 'package:accurate/AccountantDashboard/Components/ViewOldInvoicesScreen.dart';
import 'package:accurate/AccountantDashboard/Controllers/OutstandingController.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Components/ViewAllInvoiceScreen.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutstadingScreen extends StatefulWidget {
  const OutstadingScreen({Key? key}) : super(key: key);

  @override
  State<OutstadingScreen> createState() => _OutstadingScreenState();
}

class _OutstadingScreenState extends State<OutstadingScreen> {

  OutstandingController controller = Get.put(OutstandingController());

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<OutstandingController>();
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
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Outstanding", fontSize: 20),
            SizedBox(height: 20,),
            Obx(()=>controller.fetchingData.value ? UiHelper.loader() : infoCard())
          ],
        ),
      ),
    );
  }
  Widget infoCard(){
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppTextLabels.regularShortText(label: "Tap any view more Details", color: AppColors.appGreen),
            SizedBox(height: 20,),
            GestureDetector(
                onTap: (){
                  // Calculate the first and last dates of the current month
                  DateTime now = DateTime.now();
                  String startDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-01";
                  String endDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${DateTime(now.year, now.month + 1, 0).day.toString().padLeft(2, '0')}";

                  // Navigate to the next screen with the calculated dates
                  UiHelper.navigateToNextScreen(
                    context,
                    ViewAllInvoicesScreen(stateDate: startDate, endDate: endDate),
                  );
                },
                child: UiHelper.buildRow('This Month.', "${UiHelper.formatUAECurrency(controller.thisMonthAmount)}")),
            GestureDetector(
                onTap: (){
                  DateTime now = DateTime.now();
                  DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
                  String startDate = "${lastMonth.year}-${lastMonth.month.toString().padLeft(2, '0')}-01";
                  String endDate = "${lastMonth.year}-${lastMonth.month.toString().padLeft(2, '0')}-${DateTime(lastMonth.year, lastMonth.month + 1, 0).day.toString().padLeft(2, '0')}";

                  // Navigate to the next screen with the calculated dates
                  UiHelper.navigateToNextScreen(
                    context,
                    ViewAllInvoicesScreen(
                      stateDate: startDate,
                      endDate: endDate,
                    ),
                  );
                },
                child: UiHelper.buildRow('Last Month.', "${UiHelper.formatUAECurrency(controller.lastMonthAmount)}")),
            GestureDetector(
                onTap: (){
                  DateTime now = DateTime.now();

                  // Calculate the first day of the third month prior
                  DateTime thirdMonth = DateTime(now.year, now.month - 2, 1);

                  // Format the start date
                  String startDate = "${thirdMonth.year}-${thirdMonth.month.toString().padLeft(2, '0')}-01";

                  // Calculate the last day of the third month prior
                  String endDate = "${thirdMonth.year}-${thirdMonth.month.toString().padLeft(2, '0')}-${DateTime(thirdMonth.year, thirdMonth.month + 1, 0).day.toString().padLeft(2, '0')}";

                  // Navigate to the next screen with the calculated dates
                  UiHelper.navigateToNextScreen(
                    context,
                    ViewAllInvoicesScreen(
                      stateDate: startDate,
                      endDate: endDate,
                    ),
                  );
                },
                child: UiHelper.buildRow('Third Month.', "${UiHelper.formatUAECurrency(controller.thirdMonthAmount)}")),
            GestureDetector(
              onTap: (){
                DateTime now = DateTime.now();

                // Fixed start date
                String startDate = "2023-01-01";

                // Calculate the fourth month prior
                DateTime fourthMonth = DateTime(now.year, now.month - 4, 1);

                // Calculate the last day of the fourth month prior
                String endDate = "${fourthMonth.year}-${fourthMonth.month.toString().padLeft(2, '0')}-${DateTime(fourthMonth.year, fourthMonth.month + 1, 0).day.toString().padLeft(2, '0')}";

                // Navigate to the next screen with the calculated dates
                UiHelper.navigateToNextScreen(
                  context,
                  ViewAllInvoicesScreen(
                    stateDate: startDate,
                    endDate: endDate,
                  ),
                );
              },
                child: UiHelper.buildRow('Old than three Months.', "${UiHelper.formatUAECurrency(controller.olderThanThreeMonth)}")),
          ],
        ),
      ),
    );
  }

}
