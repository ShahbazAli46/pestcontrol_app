import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/sales_man/AddChemicalScreen.dart';
import 'package:accurate/sales_man/controllers/TreamentMethodController.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/sales_man/controllers/PestFoundController.dart';
import '../utils/TextStyle.dart';
import '../utils/appColors.dart';

class TreatmentMethodScreen extends StatefulWidget {
  int captainJobId;
  TreatmentMethodScreen({required this.captainJobId});
  @override
  State<TreatmentMethodScreen> createState() => _TreatmentMethodScreenState();
}

class _TreatmentMethodScreenState extends State<TreatmentMethodScreen> {

  late TreatmentMethosController controller;
  @override
  void dispose() {
    Get.delete<TreatmentMethosController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(
        TreatmentMethosController(),
        tag: Constants.treatmentmethodController);
    controller.getServices();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20),
            AppTextLabels.boldTextShort(
                label: "Create Service Report", fontSize: 20),
            SizedBox(height: 20),
            Container(
              height: 60,
              decoration: BoxDecoration(color: AppColors.appGreen),
              child: Center(
                child: AppTextLabels.regularShortText(
                    label: "Treatment Methods", color: Colors.white),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: pestFoundList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GreenButton(
                        title: "Next", sendingData: false.obs, onTap: () {
                      UiHelper.navigateToNextScreen(context, AddChemicalsScreen(captainJobId: widget.captainJobId,));
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

  Widget pestFoundList() {
    return Obx(() => controller.fetchingData.value
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 7 ,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: controller.methods.length,
            itemBuilder: (context, index) {
              final pest = controller.methods[index];
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
                            pest.isSelected.value
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: AppColors.appGreen,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: AppTextLabels.regularShortText(
                              label: pest.methodName,
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
