import 'package:accurate/components/MultiSelectCheckbox.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Components/SevicesSelectionScreen.dart';
import 'package:accurate/superadmin/Controllers/CreateQuoteController.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceAgreementScreen extends StatefulWidget {
  const ServiceAgreementScreen({Key? key}) : super(key: key);

  @override
  State<ServiceAgreementScreen> createState() => _ServiceAgreementScreenState();
}

class _ServiceAgreementScreenState extends State<ServiceAgreementScreen> {
  late CreateQuoteController controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find(tag: Constants.createQuote);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Service Agreements", fontSize: 20, color: AppColors.appBlack),
            SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MultiSelectCheckbox(items: controller.animalNames, onSelectionChanged: animalSelected),
                    SizedBox(height: 20,),
                    UiHelper.dashedBoarder(),
                    SizedBox(height: 10,),
                    AppTextLabels.boldTextShort(label: "Treatment Methods", fontSize: 20, color: AppColors.appBlack),
                    MultiSelectCheckbox(items: controller.treatmentMethods, onSelectionChanged: treatmentMethodChanged),
                    SizedBox(height: 20,),
                    UiHelper.dashedBoarder(),
                    SizedBox(height: 20,),
                    AppDropdown(title: "Select Term and Condition", options: controller.termNames, onChanged: (value, index){controller.setTermID(index ?? 0);}),
                    SizedBox(height: 20,),
                    UiHelper.dashedBoarder(),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GreenButton(title: "Next", sendingData: false.obs, onTap: (){
                        print(controller.selectedAnimals.length);
                        if (controller.selectedAnimals.isEmpty){
                          AlertService.showAlert("Alert", "Please select Service Agreement");
                        } else if (controller.selectedTreatmentMethods.isEmpty){
                          AlertService.showAlert("Alert", "Please select Treatment methods");
                        } else if (controller.selectedTermAndConditionID == 0){
                          AlertService.showAlert("Alert", "Please select Term and Condition");
                        }
                        else{
                          UiHelper.navigateToNextScreen(context, ServicesSelectionScreen());
                        }

                      }),
                    )


                  ],
                ),
              ),
            )

          ],
        )));
  }

  animalSelected(List<String> value){
    List<int> intList = value.map((str) => int.tryParse(str) ?? 0).toList();
    controller.selectedAnimals  = intList;
  }
  treatmentMethodChanged(List<String> value){
    List<int> intList = value.map((str) => int.tryParse(str) ?? 0).toList();
    controller.selectedTreatmentMethods = intList;
  }
}
