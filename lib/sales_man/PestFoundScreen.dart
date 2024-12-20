import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/sales_man/TreatmentMethodsScreen.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/sales_man/controllers/PestFoundController.dart';
import '../utils/TextStyle.dart';
import '../utils/appColors.dart';

class PestFoundScreen extends StatefulWidget {
  @override
  State<PestFoundScreen> createState() => _PestFoundScreenState();
}

class _PestFoundScreenState extends State<PestFoundScreen> {

  @override
  void dispose() {
    Get.delete<PestFoundController>(force: true);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final PestFoundController controller = Get.put(PestFoundController(), tag: Constants.pestController);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20),
            AppTextLabels.boldTextShort(label: "Create Service Report", fontSize: 20),
            SizedBox(height: 20),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: AppColors.appGreen
              ),
              child: Center(child: AppTextLabels.regularShortText(label: "Pest Found", color: Colors.white),),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: pestFoundList(controller),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GreenButton(title: "Next", sendingData: false.obs, onTap: (){
                      UiHelper.navigateToNextScreen(context, TreatmentMethodScreen());
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pestFoundList(controller) {
    return Obx(() => controller.fetchingData.value ? UiHelper.loader():GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 7 ,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: controller.pests.length,
      itemBuilder: (context, index) {
        final pest = controller.pests[index];
        return GestureDetector(
          onTap: () => controller.updateSelection(index),
          child: Obx(() => Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.appGreen),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Icon(
                  pest.isSelected.value ? Icons.check_box : Icons.check_box_outline_blank,
                  color: AppColors.appGreen,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: AppTextLabels.regularShortText(
                    label: pest.pestName,
                    color: AppColors.appBlack,
                  ),
                ),
              ],
            ),
          )),
        );
      },
    ));
  }
}