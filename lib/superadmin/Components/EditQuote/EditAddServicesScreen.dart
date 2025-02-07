import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/GreenButtonBordered.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Components/EditQuote/EditQuoteController.dart';
import 'package:accurate/superadmin/Controllers/CreateQuoteController.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../jsonModels/QuoteServices.dart';

class EditAddServicesScreen extends StatefulWidget {
  final Function addServiceInArray;
  EditAddServicesScreen({required this.addServiceInArray});

  @override
  State<EditAddServicesScreen> createState() => _EditAddServicesScreenState();
}

class _EditAddServicesScreenState extends State<EditAddServicesScreen> {


  late EditQuoteController controller;


  int numberOfJobs = 0;
  int selectedServiceId = 0;
  String jobType = Constants.monthly;
  TextEditingController numberOfJobController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String serviceName = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find(tag: Constants.editQuote);
    numberOfJobController.text = "";
    priceController.text = "";

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
            AppTextLabels.boldTextShort(label: "Add Services", fontSize: 20),
            SizedBox(height: 20,),
            Expanded(child: SingleChildScrollView(
              child: Column(children: [
                Obx(()=>!controller.refreshServiceView.value ? renderView() : Container())
              ],),
            ))


          ],
        ),
      ),
    );
  }


  Widget renderView (){
    return Column(
      children: [
        UiHelper.dashedBoarder(),

        AppDropdown(title: "Select Service", options: controller.serviceNames, onChanged: (value, index){
          selectedServiceId =  controller.allServices[index ?? 0].id;
          serviceName = value ?? "";
        }),
        SelectableButtonGroup(titles: [Constants.monthly,Constants.quarterly], onSelect: (typeIndex){
          controller.refreshServiceView.value = true;
          controller.refreshServiceView.value = false;
          jobType = typeIndex == 0 ?Constants.monthly :Constants.quarterly;
        }),

        jobType == Constants.monthly ?  monthlyView() : quarterlyView(),
        UiHelper.dashedBoarder(),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 100, right: 100),
          child: GreenButtonBordered(title: "Add Service In List", sendingData: false.obs, onTap: (){

            if (selectedServiceId == 0){
              AlertService.showAlert("Alert", "Please select service");
            } else if (jobType == Constants.monthly && numberOfJobController.text == ""){
              AlertService.showAlert("Alert", "Please enter number of jobs");
            } else if (priceController.text == ""){
              AlertService.showAlert("Alert", "Please enter price");
            }
            else{
              QuoteServices service  = QuoteServices();
              controller.refreshQuoteServices.value = true;

              if (jobType == Constants.monthly){
                service.serviceId = selectedServiceId;
                service.serviceName = serviceName;
                service.jobDuration = "${controller.duration.text}";
                service.serviceType = jobType;
                service.jobsCount = "${int.parse(numberOfJobController.text) * int.parse(controller.duration.text)}";
                QuoteServicesDetail item = QuoteServicesDetail(jobType: "monthly", noOfJobs: int.parse(numberOfJobController.text) * int.parse(controller.duration.text), rate: int.tryParse(priceController.text ?? ""));
                List<QuoteServicesDetail> list= [];
                list.add(item);
                service.detail = list;
                widget.addServiceInArray(service);
              } else {
                service.serviceId = selectedServiceId;
                service.serviceName = serviceName;
                service.serviceType = jobType;
                service.jobDuration = "${controller.duration.text} ";
                int durationInt = int.parse(controller.duration.text ?? "0");
                int jobs = calculateJobNumber(durationInt);
                service.jobsCount = "${jobs}";
                QuoteServicesDetail item = QuoteServicesDetail(jobType: "custom", noOfJobs: jobs, rate: int.tryParse(priceController.text ?? ""));
                List<QuoteServicesDetail> list= [];
                list.add(item);

                service.detail = list;
                widget.addServiceInArray(service);
              }

              controller.refreshQuoteServices.value = false;
              Navigator.of(context).pop();


            }

          }),
        )
      ],
    );
  }

  monthlyView(){
    return Column(
      children: [
        AppInput(title: "Number of Job Per month", controller: numberOfJobController, inputType: TextInputType.number, onChange: (numberOfJob){
          controller.refreshServiceView.value = true;
          controller.refreshServiceView.value = false;
          numberOfJobs = int.parse(numberOfJob);
        },),
        SizedBox(height: 5,),
        AppInput(title: "Enter Unit Service Price", controller: priceController, inputType: TextInputType.number, onChange: (amount){
          controller.refreshServiceView.value = true;
          controller.refreshServiceView.value = false;
        },),
        Row(
          children: [
            Expanded(child: Column(
              children: [
                AppTextLabels.boldTextShort(label: "Duration in Months", fontSize: 15, color: AppColors.appGreen),
                AppTextLabels.boldTextShort(label: "${controller.duration.text}", fontSize: 18),

              ],
            )),
            Expanded(child: Column(
              children: [
                AppTextLabels.boldTextShort(label: "Total Number of Jobs", fontSize: 15, color: AppColors.appGreen),
                AppTextLabels.boldTextShort(label: "${int.parse(controller.duration.text == "" ? "0" : controller.duration.text) * numberOfJobs}", fontSize: 18),

              ],
            ))
          ],
        ),

        Column(
          children: [
            AppTextLabels.boldTextShort(label: "Sub Total", fontSize: 15, color: AppColors.appGreen),
            AppTextLabels.boldTextShort(label: "${int.parse(controller.duration.text == "" ? "0" : controller.duration.text) * numberOfJobs * int.parse(priceController.text == "" ? "0" : priceController.text)}", fontSize: 18),

          ],
        ),
      ],
    );
  }

  quarterlyView(){
    return Column(
      children: [
        SizedBox(height: 5,),
        AppInput(title: "Enter Unit Service Price", controller: priceController, inputType: TextInputType.number, onChange: (amount){
          controller.refreshServiceView.value = true;
          controller.refreshServiceView.value = false;
        },),
        Row(
          children: [
            Expanded(child: Column(
              children: [
                AppTextLabels.boldTextShort(label: "Duration in Months", fontSize: 15, color: AppColors.appGreen),
                AppTextLabels.boldTextShort(label: "${controller.duration.text}", fontSize: 18),

              ],
            )),
            Expanded(child: Column(
              children: [
                AppTextLabels.boldTextShort(label: "Total Number of Jobs", fontSize: 15, color: AppColors.appGreen),
                AppTextLabels.boldTextShort(
                  label: "${(int.parse(controller.duration.text) / 3).floor()}",
                  fontSize: 18,
                ),
              ],
            )),

          ],
        ),
        Column(
          children: [
            AppTextLabels.boldTextShort(label: "Sub Total", fontSize: 15, color: AppColors.appGreen),
            AppTextLabels.boldTextShort(label: "${(int.parse(controller.duration.text) / 3).floor()  * int.parse(priceController.text == "" ? "0":priceController.text)} ", fontSize: 18),
          ],
        ),
      ],
    );
  }
  int calculateJobNumber(int duration) {
    return (duration / 3).floor();
  }
}
