import 'dart:io';
import 'dart:typed_data';

import 'package:accurate/components/SignaturePad.dart';
import 'package:accurate/components/UpcomignJobs/Controllers/JobDetailsController.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/JobDetailsResponse.dart';
import 'package:accurate/jsonModels/SubmitReportRequest.dart';
import 'package:accurate/main.dart';
import 'package:accurate/sales_man/AddFeedBackScreen.dart';
import 'package:accurate/sales_man/controllers/CompleteJobController.dart';
import 'package:accurate/sales_man/controllers/VisitController.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../components/generic/UIHelper.dart';
import '../jsonModels/CreateReportResponse.dart';
import '../utils/Constants.dart';

class CompleteJobScreen extends StatefulWidget {
  int jobId;
  CompleteJobScreen({required this.jobId});

  @override
  State<CompleteJobScreen> createState() => _CompleteJobScreenState();
}

class _CompleteJobScreenState extends State<CompleteJobScreen> {

  late JobDetailsController jobController;
  late CompleteJobController completeJobController;
  late VisitController visitController;

  TextEditingController recomendations = TextEditingController();

  var apiCall = APICall();

  var completingRequest = false.obs;

  @override
  void dispose() {
    Get.delete<JobDetailsController>(force: true);
    Get.delete<CompleteJobController>(force: true);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    visitController =
        Get.put(VisitController(), tag: Constants.visitsTypeController);
    completeJobController = Get.put(CompleteJobController(jobID: widget.jobId), tag: Constants.completeJob);
    if (Get.isRegistered<JobDetailsController>(tag: Constants.jobController)) {
      Get.delete<JobDetailsController>(tag: Constants.jobController);
    }
    jobController = Get.put(
      JobDetailsController(jobId: widget.jobId ?? 0),
      tag: Constants.jobController,
    );
    jobController.fetchJobDetails();
  }
  final signatureKey = GlobalKey<SignaturePadState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          NavWithBack(),
          SizedBox(height: 10),
          Center(
              child: AppTextLabels.boldTextShort(
                  label: "Service Report", fontSize: 20)),

          Obx(
                () => jobController.fetchingData!.value
                ? UiHelper.loader()
                : basicInfo(jobController),
          ),




        ],


      )),
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
                  buildInfoRow("Firm  Name",
                      jobController?.jobData?.data?.user?.client?.firmName ?? ""),
                  SizedBox(height: 20),
                  buildInfoRow(
                      "Date",
                      UiHelper.formatDate(
                          jobController?.jobData?.data?.jobDate ?? "")),
                  SizedBox(height: 20),

                  buildInfoRow(
                      "Service Name",
                      getServiceTitles(jobController?.jobData?.data?.jobServices) ?? ""),
                  typesOfServices(),

                  SizedBox(height: 10,),
                  UiHelper.dashedBoarder(),
                  SizedBox(height: 10,),
                  Obx(()=> completeJobController.fetchingData.value ? Text('Loading Info') : Column(
                    children: [
                      AppTextLabels.boldTextShort(label: "Inspected Areas", fontSize: 20),
                      CustomListView(
                        physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          isPrimary: false,
                          items: completeJobController.completeJobResponse.data?.overallCaptainAreas ?? [], itemBuilder: (context, item, index)=>areaItem(index)),
                      SizedBox(height: 10,),
                      UiHelper.dashedBoarder(),
                      SizedBox(height: 10,),
                      AppTextLabels.boldTextShort(label: "Pest Found", fontSize: 20),
                      CustomListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          isPrimary: false,
                          items: completeJobController.completeJobResponse.data?.overallPestFoundServices ?? [], itemBuilder: (context, item, index)=>pestItem(index)),

                      SizedBox(height: 10,),
                      UiHelper.dashedBoarder(),
                      SizedBox(height: 10,),
                      AppTextLabels.boldTextShort(label: "Treatment Methods", fontSize: 20),
                      CustomListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          isPrimary: false,
                          items: completeJobController.completeJobResponse.data?.overallTreatmentMethods ?? [], itemBuilder: (context, item, index)=>methodItem(index)),

                      SizedBox(height: 10,),
                      UiHelper.dashedBoarder(),
                      SizedBox(height: 10,),
                      AppTextLabels.boldTextShort(label: "Chemical Used", fontSize: 20),
                      CustomListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          isPrimary: false,
                          items: completeJobController.completeJobResponse.data?.overallCaptainProducts ?? [], itemBuilder: (context, item, index)=>productItem(index)),


                      SizedBox(height: 20,),

                      SizedBox(height: 20,),
                      UiHelper.dashedBoarder(),
                      SizedBox(height: 20,),
                      AppTextLabels.boldTextShort(label: "Client Signature", fontSize: 20),
                      SizedBox(height: 10,),

                      SignaturePad(
                        key: signatureKey,
                        strokeColor: AppColors.appGreen,
                        strokeWidth: 1.0,
                      ),
                      SizedBox(height: 30,),
                      GreenButton(title: "Submit", sendingData: completingRequest, onTap: (){
                        completeServiceRequest();
                      })
                    ],
                  )),

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

  String? getServiceTitles(List<JobService>? jobServices) {
    return jobServices
        ?.map((jobService) => jobService?.service?.serviceTitle)
        .where((title) => title != null)
        .join(',');
  }


  areaItem(int index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("Sr", "${index + 1}"),
        UiHelper.buildRow("Area", "${completeJobController.completeJobResponse.data?.overallCaptainAreas?[index].inspectedAreas}"),
        UiHelper.buildRow("Main infested area", "${completeJobController.completeJobResponse.data?.overallCaptainAreas?[index].manifestedAreas}"),
        UiHelper.buildRow("Pest Found", "${completeJobController.completeJobResponse.data?.overallCaptainAreas?[index].pestFound}"),
        UiHelper.buildRow("Infestation Level", "${completeJobController.completeJobResponse.data?.overallCaptainAreas?[index].infestationLevel}"),
        UiHelper.buildRow("Follow Up Details", "${completeJobController.completeJobResponse.data?.overallCaptainAreas?[index].reportAndFollowUpDetail}"),
      ],
    ));
  }


  pestItem(int index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("Sr", "${index + 1}"),
        UiHelper.buildRow("Pest Name", "${completeJobController.completeJobResponse.data?.overallPestFoundServices?[index].pestName}"),

      ],
    ));
  }

  methodItem(int index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("Sr", "${index + 1}"),
        UiHelper.buildRow("Pest Name", "${completeJobController.completeJobResponse.data?.overallTreatmentMethods?[index].name}"),

      ],
    ));
  }

  productItem(int index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("Sr", "${index + 1}"),
        UiHelper.buildRow("Product", "${completeJobController.completeJobResponse.data?.overallCaptainProducts?[index].productName}"),
        UiHelper.buildRow("Quantity", "${completeJobController.completeJobResponse.data?.overallCaptainProducts?[index].qty}"),
        UiHelper.buildRow("Unit", "${completeJobController.completeJobResponse.data?.overallCaptainProducts?[index].unit}"),

      ],
    ));
  }


  void completeServiceRequest() async {



    if (signatureKey.currentState != null &&
        signatureKey.currentState!.hasSignature()) {

    if (!completingRequest.value) {
      try {
        final signatureBytes = await signatureKey.currentState!
            .captureSignature();

        if (signatureBytes != null) {
          File signatureFile = await uint8ListToFile(signatureBytes);

          SubmitReportRequest request = SubmitReportRequest(
            jobId: "${widget.jobId}",
            typeOfVisit: visitController.selected.visitTitle,
            recommendationsAndRemarks: "recomendations.text",
            forOfficeUse: "yourOfficeUse",

          );
          completingRequest.value = true;
          var url = Urls.baseURL + "job/service_report/create";
          var response = await apiCall.postDataWithTokenWithImage(
              url, request.toJson(), signatureFile, "signature_img");

          CreateReportResponse errorResponse = CreateReportResponse.fromJson(response);

          if (errorResponse.status == "success"){

            var jobCompletion = Urls.baseURL + "job/move/complete/${widget.jobId}";
            var compRes = await apiCall.getDataWithToken(jobCompletion);

            CreateReportResponse completeResponse = CreateReportResponse.fromJson(compRes);
            print("Rataiinnnlakjflkdsjflaksjflkadsjflaksjdflkadsjf");
            print(completeResponse.data?.id);
            if (completeResponse.status == "success") {
              AlertService.showAlertWithAction("Alert", completeResponse.message ?? "",
                  onOkPressed: () {
                    Get.offAll(AddFeedBackScreen(reportID: errorResponse.data?.id ?? "0",));
                  });
            } else {
              AlertService.showAlert("Alert", completeResponse.message ?? "");
            }


            // AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
            //   Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0)),
            //         (Route<dynamic> route) => false, // This removes all previous routes
            //   );
            // });
          }
          else{
            AlertService.showAlert("Alert", errorResponse.message ?? "Please try later");
          }


          completingRequest.value = false;
          await signatureFile.delete();
        } else {
          print("Failed to capture signature");
        }
      } catch (e) {
        print("Error processing signature: $e");
      }
    }

    } else {

      AlertService.showAlert("Alert", "Please Add Signatures");

    }
  }


  Future<File> uint8ListToFile(Uint8List uint8list) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(uint8list);
    return file;
  }
}
