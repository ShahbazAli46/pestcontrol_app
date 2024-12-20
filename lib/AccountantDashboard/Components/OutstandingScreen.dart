import 'package:accurate/AccountantDashboard/Components/ViewOldInvoicesScreen.dart';
import 'package:accurate/AccountantDashboard/Controllers/OutstandingController.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
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
                  UiHelper.navigateToNextScreen(context, ViewOldInvoicesScreen(title: "This Month", oldDataArray: controller.thisMonthData,));
                },
                child: UiHelper.buildRow('This Month.', "${UiHelper.formatUAECurrency(controller.thisMonthAmount)}")),
            GestureDetector(
                onTap: (){
                  UiHelper.navigateToNextScreen(context, ViewOldInvoicesScreen(title: "Last Month", oldDataArray: controller.lastMonthData,));
                },
                child: UiHelper.buildRow('Last Month.', "${UiHelper.formatUAECurrency(controller.lastMonthAmount)}")),
            GestureDetector(
                onTap: (){
                  UiHelper.navigateToNextScreen(context, ViewOldInvoicesScreen(title: "Third Month", oldDataArray: controller.thirdMonthData,));
                },
                child: UiHelper.buildRow('Third Month.', "${UiHelper.formatUAECurrency(controller.thirdMonthAmount)}")),
            GestureDetector(
              onTap: (){
                UiHelper.navigateToNextScreen(context, ViewOldInvoicesScreen(title: "Older Than Three Month", oldDataArray: controller.olderThanMonthData,));
              },
                child: UiHelper.buildRow('Old than three Months.', "${UiHelper.formatUAECurrency(controller.olderThanThreeMonth)}")),
          ],
        ),
      ),
    );
  }

}
