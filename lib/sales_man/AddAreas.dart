import 'package:accurate/components/UpcomignJobs/Controllers/JobDetailsController.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/BlueButton.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/sales_man/PestFoundScreen.dart';
import 'package:accurate/sales_man/controllers/AddInspectedAreasController.dart';
import 'package:accurate/sales_man/controllers/JobReportController.dart';
import 'package:accurate/sales_man/controllers/VisitController.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAreas extends StatefulWidget {
  int captainJobId;
  bool fromJob;
  int jobId;
  AddAreas({required this.captainJobId, required this.fromJob, required this.jobId});
  @override
  State<AddAreas> createState() => _AddAreasState();
}

class _AddAreasState extends State<AddAreas> {
  late AddInspectedAreasController inspectedAreasController;

  late VisitController visitController;

  late JobReportController serviceReportController;

  JobDetailsController? jobController;

  @override
  void initState() {
    super.initState();

    visitController =
        Get.put(VisitController(), tag: Constants.visitsTypeController);


    if (widget.fromJob){
      jobController = Get.put(JobDetailsController(jobId: widget.jobId), tag: Constants.jobController);
      jobController?.fetchJobDetails();
    }
  }




  @override
  Widget build(BuildContext context) {
    inspectedAreasController = Get.put(AddInspectedAreasController(),
        tag: Constants.inspectedAreaController);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 10),
            AppTextLabels.boldTextShort(
                label: "Add Areas", fontSize: 20),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppTextLabels.boldTextShort(
                            label: "Areas",
                            color: AppColors.appBlack,
                            fontSize: 15),
                        Spacer(),
                        Container(
                          width: 100,
                          child: GreenButton(
                            title: "+ Add",
                            sendingData: false.obs,
                            onTap: () {
                              showCustomDialog(
                                  context, inspectedAreasController);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Obx(() => ListView.builder(
                            itemCount:
                                inspectedAreasController.inspectedAreas.length,
                            itemBuilder: (context, index) {
                              return addItem(
                                  inspectedAreasController
                                      .inspectedAreas[index],
                                  index);
                            },
                          )),
                    ),
                    SizedBox(height: 20),
                    GreenButton(
                        title: "Next",
                        sendingData: false.obs,
                        onTap: () {
                          UiHelper.navigateToNextScreenGetX(PestFoundScreen(captainJobId: widget.captainJobId,));
                        }),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addItem(InspectedArea item, int index) {
    return Card(
      color: Colors.white, // Explicitly set the card color to white
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                _buildRow('Sr.', "${index + 1}"),
                Row(
                  children: [
                    Expanded(child: Container()),
                    GestureDetector(
                        onTap: () {
                          inspectedAreasController.removeAddressAt(index);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ],
            ),
            _buildRow('Inspected Areas', item.areaName),
            _buildRow('Pests Found', item.pestFound),
            _buildRow('Infestation Level', item.manifestationLevel),
            _buildRow('Main infested Areas', item.manifestedArea),
            _buildRow('Report And Follow Up Detail', item.followUp),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String areaObject) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Color(0xffF9FAFB)),
              child: Center(
                  child: AppTextLabels.regularShortText(
                      label: label,
                      color: AppColors.appBlack,
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 50,
              decoration: BoxDecoration(),
              child: Center(
                  child: AppTextLabels.regularShortText(
                      label: areaObject,
                      color: AppColors.appBlack,
                      textAlign: TextAlign.center)),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomDialog(BuildContext context, inspectedAreasController) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
          ),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                AppTextLabels.boldTextShort(label: "Add Area", fontSize: 18),
                AppInput(
                    title: "Treatment Area",
                    controller: inspectedAreasController.areaName),
                AppInput(
                    title: "Pest Found",
                    controller: inspectedAreasController.pestFound),
                AppDropdown(
                    title: "Infestation level",
                    options: ["High", "Medium", "Low"],
                    onChanged: levelDropDownChanged),
                AppInput(
                    title: "Main infected area",
                    controller: inspectedAreasController.manifestiedArea),
                AppInput(
                    title: "Report and Follow Up details",
                    controller: inspectedAreasController.followUp),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Bluebutton(
                      title: "Cancel",
                      sendingData: false.obs,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: GreenButton(
                      title: "Save",
                      sendingData: false.obs,
                      onTap: () {
                        inspectedAreasController.addAres(() {
                          Navigator.pop(context);
                        });
                      },
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  levelDropDownChanged(value, index) {
    inspectedAreasController.level = value;
  }
}
