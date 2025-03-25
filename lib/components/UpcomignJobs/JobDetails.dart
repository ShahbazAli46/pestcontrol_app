import 'dart:async';

import 'package:accurate/components/ImageViewerDialog.dart';
import 'package:accurate/components/MapLauncher.dart';
import 'package:accurate/components/UpcomignJobs/Controllers/JobDetailsController.dart';
import 'package:accurate/components/UpcomignJobs/UpcomingJobsController.dart';
import 'package:accurate/components/generic/BlueButton.dart';
import 'package:accurate/components/generic/DashedSeparatorPainter.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:accurate/sales_man/AddImagesForIPMReportScreen.dart';
import 'package:accurate/sales_man/CreateServiceReport.dart';
import 'package:accurate/sales_man/ReschduleJob.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetails extends StatefulWidget {
  int id;

  JobDetails({required this.id});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  var makingRequestForStartJob = false.obs;

  late JobDetailsController jobController;

  var apiCall = APICall();

  @override
  void dispose() {
    Get.delete<JobDetailsController>(force: true);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<JobDetailsController>(tag: Constants.jobController)) {
      Get.delete<JobDetailsController>(tag: Constants.jobController);
    }
    jobController = Get.put(
      JobDetailsController(jobId: widget.id ?? 0),
      tag: Constants.jobController,
    );
    jobController.fetchJobDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() => jobController.fetchingData.value
            ? UiHelper.loader()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),
                  NavWithBack(),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: AppTextLabels.boldTextShort(
                          label: "Job Details", fontSize: 20)),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            detailRow(
                                "Date : ",
                                UiHelper.formatDate(
                                    jobController?.jobData?.data?.jobDate ??
                                        "")),
                            SizedBox(
                              height: 15,
                            ),
                            detailRow("Client Name : ",
                                jobController?.jobData?.data?.user?.name ?? ""),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                                onTap: () {
                                  UiHelper.makePhoneCall(jobController?.jobData
                                          ?.data?.user?.client?.phoneNumber ??
                                      "");
                                },
                                child: detailRow(
                                    "Contact Number : ",
                                    jobController?.jobData?.data?.user?.client
                                            ?.phoneNumber ??
                                        "")),
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                                onTap: () {
                                  UiHelper.sendEmail(jobController
                                          ?.jobData?.data?.user?.email ??
                                      "");
                                },
                                child: detailRow(
                                    "Email : ",
                                    jobController?.jobData?.data?.user?.email ??
                                        "")),
                            SizedBox(
                              height: 15,
                            ),
                            detailRow(
                                "State : ",
                                jobController?.jobData?.data?.clientAddress
                                        ?.address ??
                                    ""),
                            SizedBox(
                              height: 35,
                            ),
                            reschdulesList(),
                            SizedBox(
                              height: 35,
                            ),
                            _teamMembers(),
                            jobMap(),
                            SizedBox(
                              height: 20,
                            ),
                            jobController.jobData?.data?.captainId == null
                                ? Container(
                                    child: Text(""),
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                          child: Bluebutton(
                                              title: jobController?.jobData
                                                          ?.data?.isCompleted ==
                                                      0
                                                  ? "Start Job"
                                                  : jobController?.jobData?.data
                                                              ?.isCompleted ==
                                                          1
                                                      ? "Create Report"
                                                      : jobController
                                                                  ?.jobData
                                                                  ?.data
                                                                  ?.isCompleted ==
                                                              2
                                                          ? "Complete Job"
                                                          : "${jobController?.jobData?.data?.isCompleted}",
                                              sendingData:
                                                  makingRequestForStartJob,
                                              onTap: () {
                                                if (jobController?.jobData?.data
                                                        ?.isCompleted ==
                                                    0) {
                                                  requestToStartJob();
                                                } else if (jobController
                                                        ?.jobData
                                                        ?.data
                                                        ?.isCompleted ==
                                                    1) {
                                                  UiHelper
                                                      .navigateToNextScreenGetX(
                                                          CreateServiceReport(
                                                    jobId: jobController
                                                            ?.jobData
                                                            ?.data
                                                            ?.id ??
                                                        0,
                                                    fromJob: true,
                                                  ));
                                                } else {
                                                  completeJobRequest();
                                                }
                                              })),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      jobController?.jobData?.data
                                                  ?.isCompleted ==
                                              0
                                          ? Expanded(
                                              child: Bluebutton(
                                                  title: "Reschedule Job",
                                                  sendingData: false.obs,
                                                  onTap: () {
                                                    UiHelper.navigateToNextScreen(
                                                        context,
                                                        ReschduleJob(
                                                            jobId: jobController
                                                                    ?.jobData
                                                                    ?.data
                                                                    ?.id ??
                                                                0));
                                                  }))
                                          : Container(),

                                      Expanded(child: jobController?.jobData?.data?.isCompleted == 2
                                          ? Container(child: Bluebutton(title: "Add IPM Images", sendingData: false.obs, onTap: (){
                                            UiHelper.navigateToNextScreen(context, AddImagesForIPMReportScreen(serviceID: widget.id, clinetID: jobController.jobData?.data?.userId ?? 0,));
                                      },))
                                          : Container())


                                    ],
                                  ),

                          ],
                        ),
                      ),
                    ),
                  ))
                ],
              )),
      ),
    );
  }

  Future<void> makeCall(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        print('Could not launch phone call');
      }
    } catch (e) {
      print('Error making phone call: $e');
    }
  }

  Widget detailRow(String label, String text) {
    return Row(
      children: [
        AppTextLabels.regularShortText(label: label, color: AppColors.appBlack),
        AppTextLabels.regularText(label: text, color: AppColors.lightTextColor)
      ],
    );
  }

  Widget _teamMembers() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(color: AppColors.appGreen),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.boldTextShort(
                      label: "Team Members", fontSize: 18, color: Colors.white)
                ],
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(color: Color(0xffFCFCFD)),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: 40,
                      child: AppTextLabels.boldTextShort(
                          label: "Sr", fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: AppTextLabels.boldTextShort(
                          label: "Name", fontSize: 15)),
                  Expanded(
                      child: AppTextLabels.boldTextShort(
                          label: "Contact", fontSize: 15)),
                  UiHelper.dashedBoarder()
                ],
              ),
            ),
            ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: jobController?.members.length ?? 0,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 60,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: 40,
                                      child: AppTextLabels.regularShortText(
                                          label: "${index + 1}",
                                          fontSize: 15,
                                          color: AppColors.appBlack)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: AppTextLabels.regularShortText(
                                          label: jobController
                                                  ?.members?[index]?.name ??
                                              "",
                                          fontSize: 15,
                                          color: AppColors.appBlack)),
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            makeCall(jobController
                                                    ?.members?[index]
                                                    ?.employee
                                                    ?.phoneNumber ??
                                                "");
                                          },
                                          child: AppTextLabels.regularShortText(
                                              label: jobController
                                                      ?.members?[index]
                                                      ?.employee
                                                      ?.phoneNumber ??
                                                  "",
                                              fontSize: 15,
                                              color: AppColors.appBlack))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      UiHelper.dashedBoarder()
                    ],
                  );
                }),
            SizedBox(height: 20,),
            AppTextLabels.boldText(label: "Job Instructions", fontSize: 15, color: AppColors.appBlack),
            SizedBox(height: 10,),
            AppTextLabels.regularShortText(label: jobController.jobData?.data?.jobInstructions ?? "", color: AppColors.appBlack),
            jobController.jobData?.data?.user?.clientInspectionReports != null &&
                (jobController.jobData?.data?.user?.clientInspectionReports ?? []).isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextLabels.boldTextShort(label: "Inspector Recommendations", fontSize: 18),
                SizedBox(height: 15,),
                UiHelper.commonContainer(
                    Column(
                      children: [
                        UiHelper.buildRow("Client Remarks", "${jobController.jobData?.data?.user?.clientInspectionReports![0].clientRemarks}"),
                        UiHelper.buildRow("Recommendation For Operation Team", "${jobController.jobData?.data?.user?.clientInspectionReports![0].recommendationForOperation}"),
                        UiHelper.buildRow("General Comments", "${jobController.jobData?.data?.user?.clientInspectionReports![0].generalComment}"),
                        UiHelper.buildRow("Nesting Areas", "${jobController.jobData?.data?.user?.clientInspectionReports![0].nestingArea}"),
                        SizedBox(height: 5,),
                        Center(
                          child: TextButton(onPressed: (){
                            showImageViewer(context, jobController.jobData?.data?.user?.clientInspectionReports![0].pictures ?? []);
                          }, child: AppTextLabels.regularShortText(label: "View Attachments", color: AppColors.appGreen)),
                        )
                      ],
                    )),
              ],
            ): Container()
          ],
        ),
      ),
    );
  }

  Widget reschdulesList(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(color: AppColors.appGreen),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.boldTextShort(
                      label: "Reschedules", fontSize: 18, color: Colors.white)
                ],
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(color: Color(0xffFCFCFD)),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: 40,
                      child: AppTextLabels.boldTextShort(
                          label: "Sr", fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: AppTextLabels.boldTextShort(
                          label: "Date", fontSize: 15)),
                  Expanded(
                      child: AppTextLabels.boldTextShort(
                          label: "Reason", fontSize: 15)),
                  UiHelper.dashedBoarder()
                ],
              ),
            ),
            ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: jobController?.jobData?.data?.rescheduleDates?.length ?? 0,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 60,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      width: 40,
                                      child: AppTextLabels.regularShortText(
                                          label: "${index + 1}",
                                          fontSize: 15,
                                          color: AppColors.appBlack)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: AppTextLabels.regularShortText(
                                          label: jobController?.jobData?.data?.rescheduleDates?[index].jobDate ?? "",
                                          fontSize: 15,
                                          color: AppColors.appBlack)),
                                  Expanded(
                                      child: AppTextLabels.regularShortText(
                                          label: jobController?.jobData?.data?.rescheduleDates?[index].reason ?? "",
                                          fontSize: 15,
                                          color: AppColors.appBlack)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      UiHelper.dashedBoarder()
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget jobMap() {
    double lat =
        double.parse(jobController?.jobData?.data?.clientAddress?.lat ?? "0.0");
    double long = double.parse(
        jobController?.jobData?.data?.clientAddress?.lang ?? "0.0");

    LatLng _center = LatLng(lat, long);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(color: AppColors.appGreen),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      AppTextLabels.boldTextShort(
                          label: "Job Location",
                          fontSize: 18,
                          color: Colors.white)
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 10.0,
                    ),
                    markers: _markers,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GreenButton(
            title: "Tap here to open location in Maps",
            sendingData: false.obs,
            onTap: () {
              double lat = double.parse(
                  jobController?.jobData?.data?.clientAddress?.lat ?? "0.0");
              double long = double.parse(
                  jobController?.jobData?.data?.clientAddress?.lang ?? "0.0");
              _openGoogleMaps(lat, long);
            })
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    double lat =
        double.parse(jobController?.jobData?.data?.clientAddress?.lat ?? "0.0");
    double long = double.parse(
        jobController?.jobData?.data?.clientAddress?.lang ?? "0.0");

    LatLng _center = LatLng(lat, long);

    _controller.complete(controller);
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('job_location'),
          position: _center,
          infoWindow: InfoWindow(title: 'Job Location'),
        ),
      );
    });
  }

  Future<void> _openGoogleMaps(double lat, double long) async {
    MyMapLauncher.openMapsWithLocation(latitude: lat, longitude: long);
  }

  void requestToStartJob() async {
    makingRequestForStartJob.value = true;
    final url = Urls.startJob + "${jobController?.jobData?.data?.id}";
    var response = await apiCall.getDataWithToken(url);
    GeneralErrorResponse errorResponse =
        GeneralErrorResponse.fromJson(response);
    AlertService.showAlertWithAction(
        "Alert", errorResponse.message ?? "Please try later", onOkPressed: () {
      jobController.fetchJobDetails();
    });
    makingRequestForStartJob.value = false;
  }

  void completeJobRequest() async {
    makingRequestForStartJob.value = true;
    final url = Urls.completeJob + "${widget.id}";
    var response = await apiCall.getDataWithToken(url);
    GeneralErrorResponse errorResponse =
        GeneralErrorResponse.fromJson(response);
    AlertService.showAlertWithAction(
        "Alert", errorResponse.message ?? "Please try later", onOkPressed: () {
      Future.delayed(Duration(milliseconds: 100), () {
        UiHelper.navigateToNextScreen(
            context,
            CreateServiceReport(
              jobId: widget.id ?? 0,
              fromJob: true,
            ));
      });
    });
    makingRequestForStartJob.value = false;
  }
}
