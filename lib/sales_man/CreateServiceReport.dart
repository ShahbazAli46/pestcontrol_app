import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/sales_man/AddAreas.dart';
import 'package:accurate/sales_man/controllers/JobReportController.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/UpcomignJobs/Controllers/JobDetailsController.dart';
import '../components/generic/UIHelper.dart';
import '../jsonModels/JobDetailsResponse.dart';
import 'controllers/VisitController.dart';

class CreateServiceReport extends StatefulWidget {
  late int jobId = 0;
  bool fromJob;

  CreateServiceReport({required this.jobId, required  this.fromJob});

  @override
  State<CreateServiceReport> createState() => _CreateservicereportState();
}

class _CreateservicereportState extends State<CreateServiceReport> {
  late VisitController visitController;

  late JobReportController serviceReportController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    visitController =
        Get.put(VisitController(), tag: Constants.visitsTypeController);

    JobDetailsController jobController;
    if (!widget.fromJob){
      jobController = Get.put(JobDetailsController(jobId: widget.jobId), tag: Constants.jobController);
      jobController.fetchJobDetails();
    }
    else{
      jobController = Get.find( tag: Constants.jobController);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavWithBack(),
            SizedBox(height: 10),
            Center(
                child: AppTextLabels.boldTextShort(
                    label: "Create Service Report", fontSize: 20)),
            Obx(
              () => jobController.fetchingData!.value
                  ? UiHelper.loader()
                  : basicInfo(jobController),
            )
          ],
        ),
      ),
    );
  }

  Widget basicInfo(JobDetailsController jobController) {
    return Expanded(
      child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow("Client Name",
                      jobController?.jobData?.data?.user?.name ?? ""),
                  SizedBox(height: 20),
                  buildInfoRow(
                      "Date",
                      UiHelper.formatDate(
                          jobController?.jobData?.data?.jobDate ?? "")),
                  SizedBox(height: 20),
                  buildInfoRow(
                      "Contact",
                      jobController?.jobData?.data?.user?.client?.phoneNumber ??
                          ""),
                  SizedBox(height: 20),
                  buildInfoRow(
                      "Service Name",
                      getServiceTitles(jobController?.jobData?.data?.jobServices) ??
                          ""),
                  typesOfServices(),
                  // buildInfoRow("Time In", "12 : 40 PM"),
                  // buildInfoRow("Time Out", "12 : 40 PM"),
                  SizedBox(height: 40),
                  GreenButton(
                      title: "Next",
                      sendingData: false.obs,
                      onTap: () {
                        UiHelper.navigateToNextScreen(context, AddAreas());
                      }),
                  SizedBox(height: 10),
                ],
              ))),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextLabels.regularShortText(label: label, color: AppColors.appBlack),
        SizedBox(width: 20),
        Expanded(
            child: AppTextLabels.underlinedText(
                label: value, color: AppColors.appBlack))
      ],
    );
  }

  Widget typesOfServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        AppTextLabels.boldTextShort(label: "Type of Visit", fontSize: 20),
        Obx(() => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              itemCount: visitController.visits.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    visitController.selectVisit(index);
                  },
                  child: ListTile(
                    title: AppTextLabels.regularShortText(
                      label: visitController.visits[index].visitTitle,
                      color: AppColors.appBlack,
                    ),
                    leading: Checkbox(
                      value: visitController.visits[index].isSelect,
                      onChanged: (value) {
                        // visitController.selectVisit(index);
                      },
                      activeColor: AppColors.appGreen,
                    ),
                  ),
                );
              },
            ))
      ],
    );
  }

  String? getServiceTitles(List<JobServices>? jobServices) {
    return jobServices
        ?.map((jobService) => jobService?.service?.serviceTitle)
        .where((title) => title != null)
        .join(',');
  }
}
