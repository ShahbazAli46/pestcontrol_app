import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/GreenButtonBordered.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Components/AddServiceScreen.dart';
import 'package:accurate/superadmin/Components/BillingMethodScreen.dart';
import 'package:accurate/superadmin/Controllers/CreateQuoteController.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesSelectionScreen extends StatefulWidget {
  const ServicesSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ServicesSelectionScreen> createState() => _ServicesSelectionScreenState();
}

class _ServicesSelectionScreenState extends State<ServicesSelectionScreen> {
  late CreateQuoteController controller;

  int grandTotal = 0;
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
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Select Services", fontSize: 20),
            SizedBox(height: 20,),
            Container(
                margin: EdgeInsets.only(left: 100, right: 100),
                child: GreenButtonBordered(title: "Add Service", sendingData: false.obs, onTap: (){
                  UiHelper.navigateToNextScreen(context, AddServicesScreen(addServiceInArray: (value){
                    controller.addServiceInArray(value);
                  }));
                })),
            SizedBox(height: 20,),

            Obx(()=>!controller.refreshQuoteServices.value ? Expanded(child: Column(
              children: [
                Expanded(child: CustomListView(items: controller.quoteServices, itemBuilder: (context, item, index)=>serviceItem(index),)),
                SizedBox(height: 20,),

              ],
            ),) : Container(child: Text(""),)),
            SizedBox(height: 10,),
            Obx(()=>!controller.refreshQuoteServices.value ?
            UiHelper.buildRow("Total", "${controller.grandTotal}")
                : Container(child: Text(""),)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GreenButton(title: "Next", sendingData: false.obs, onTap: (){
                if (controller.quoteServices.isEmpty){
                  AlertService.showAlert("Alert", "Please add Services");
                }
                else{
                  UiHelper.navigateToNextScreen(context, BillingMethodScreen());
                }

              }),
            ),

          ],
        ),
      ),
    );
  }

  serviceItem(index){
    return Stack(
      children: [
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
          child: Column(
            children: [
              UiHelper.buildRow("Sr", "${index + 1}"),
              UiHelper.buildRow("Service Name", "${controller.quoteServices[index].serviceName}"),
              UiHelper.buildRow("Duration", "${controller.quoteServices[index].jobDuration}"),
              UiHelper.buildRow("Job Type", "${controller.quoteServices[index].serviceType}"),
              UiHelper.buildRow("Jobs Count", "${controller.quoteServices[index].jobsCount}"),
              UiHelper.buildRow("Price", "${controller.quoteServices[index].detail?[0].rate}"),
              UiHelper.buildRow("Sub Total", "${ int.parse(controller.quoteServices[index].jobsCount) * int.parse("${controller.quoteServices[index].detail?[0].rate}")}"),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(child: Container()),
            GestureDetector(
              onTap: (){
                controller.refreshQuoteServices.value = true;
                controller.quoteServices.removeAt(index);
                controller.resetGrandTotal();
                controller.refreshQuoteServices.value = false;
              },
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Icon(Icons.delete, color: Colors.red,)),
            ),
            SizedBox(width: 20,),
          ],
        ),
      ],
    );
  }

}
