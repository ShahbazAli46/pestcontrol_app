import 'dart:io';

import 'package:accurate/components/UpcomignJobs/JobDetails.dart';
import 'package:accurate/components/UpcomignJobs/UpcomingJobsController.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DashedSeparatorPainter.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UpComingJobs extends StatefulWidget {
  const UpComingJobs({Key? key}) : super(key: key);

  @override
  State<UpComingJobs> createState() => _UpComingJobsState();
}

class _UpComingJobsState extends State<UpComingJobs> {


  late UpcomingJobsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(UpcomingJobsController(), tag: "emp", permanent: false);
    controller.fetchJob();
  }

  @override
  void dispose() {
    Get.delete<UpcomingJobsController>(tag: "emp");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(
        child: AppTextLabels.boldTextShort(
            label: "Upcoming jobs", color: Colors.black, fontSize: 20),
      ),
      SizedBox(height: 20,),
      SelectableButtonGroup(titles: ["Upcoming", "Previous"], onSelect: onSelect),
      SizedBox(height: 20,),
      Obx(() => controller.fetchingData.value
          ? UiHelper.loader()
          : Expanded(
            child: CustomListView<CaptainJobs>(
              items: controller.captainJobs,
              itemBuilder: (context, job, index) => listItem(job, index),
              onRefresh: () async {
                controller.fetchJob();
              },
            ),
          ))
    ]);
  }


  onSelect(int type){
    controller.changeListType(type);
  }
  Widget listItem(CaptainJobs job, outerIndex) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8), // Add this line
          boxShadow: [
            // Add this line
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Text("")),
                Icon(
                  Icons.date_range,
                  color: AppColors.appGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                AppTextLabels.regularShortText(
                    label: "${UiHelper.formatDateTime(job.rescheduleDates?.last.jobDate ?? "")}",
                    color: AppColors.appBlack),
                SizedBox(
                  width: 10,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Text("Job Status")),

                SizedBox(
                  width: 10,
                ),
                AppTextLabels.regularShortText(
                    label: job.isCompleted == 1 ?"Completed" : job.isCompleted == 0 ? "Not Started" : "Started",
                    color: AppColors.appBlack),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                itemCount: job.jobServices?.length ?? 0,
                itemBuilder: (context, index) {
                  return AppTextLabels.boldTextShort(
                      label:
                          "${index + 1} ${job.jobServices?[index].service?.serviceTitle ?? ""}",
                      fontSize: 20,
                      color: AppColors.appGreen);
                }),
            SizedBox(
              height: 10,
            ),
            CustomPaint(
              painter: DashedSeparatorPainter(),
              child: Container(
                height: 1, // Set the height of the separator
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.appGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                AppTextLabels.underlinedText(
                    label: job.user?.client?.firmName ?? "",
                    color: AppColors.appBlack,
                    fontSize: 18)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                UiHelper.makePhoneCall(job.user?.client?.phoneNumber ?? "");
              },
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: AppColors.appGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.underlinedText(
                      label: job.user?.client?.phoneNumber ?? "",
                      color: AppColors.appBlack,
                      fontSize: 18)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: AppColors.appGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                AppTextLabels.underlinedText(
                    label: job.clientAddress?.address ?? "",
                    color: AppColors.appBlack,
                    fontSize: 13)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GreenButton(
              title: "View Details",
              sendingData: false.obs,
              onTap: () {
                UiHelper.navigateToNextScreenGetX(
                  JobDetails(
                    id: controller.captainJobs[outerIndex].id ?? 0,
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
