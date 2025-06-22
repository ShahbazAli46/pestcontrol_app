import 'package:accurate/components/UpcomignJobs/JobDetails.dart';
import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/sales_man/controllers/HistoryController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/UpcomignJobs/UpcomingJobsController.dart';
import '../components/generic/DashedSeparatorPainter.dart';
import '../components/generic/GreenButton.dart';
import '../jsonModels/HistoryResponse.dart';
import '../utils/TextStyle.dart';
import '../utils/appColors.dart';
import 'CreateServiceReport.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryController historyController = Get.put(HistoryController());

  late UpcomingJobsController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(UpcomingJobsController(), tag:"emp", permanent: false);
    controller.fetchJob();// Jobs api also fetches current logged in users stock that we need while creating service report
  }

  @override
  void dispose() {
    Get.delete<HistoryController>();
    super.dispose();
  }
  // 2024-10-31 00:00:00.000
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(
              height: 20,
            ),
            Center(
              child: AppTextLabels.boldTextShort(
                  label: "Job History", color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(child: Container(child: AppTextLabels.regularText(label: "Select Date", color: Colors.black54, fontSize: 14),)),
                  DateFilters(onOptionChange: onOptionChange)
                ],
              ),
            ),
            Obx(()=> historyController.fetchingData.value ? Center(child: CircularProgressIndicator(),) : Expanded(
              child: CustomListView(
                  onRefresh: ()async {
                    historyController.getTodayData();
                  },
                items: historyController.data ?? [],
                itemBuilder: (context, item, index)=> listItem(historyController?.data?[index],
              ))
            ))


          ],
        ),
      ),
    );
  }

  onOptionChange(type, start, end) {
    if (end != null) {
      historyController.getData(start, end);
    }
  }


  Widget listItem(HistoryData? job) {
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
                    label: UiHelper.formatDate(job?.jobDate ?? ""),
                    color: AppColors.appBlack),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

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
                    label: job?.user?.name ?? "",
                    color: AppColors.appBlack,
                    fontSize: 18)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                UiHelper.makePhoneCall(job?.user?.client?.phoneNumber ?? "");
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
                      label: job?.user?.client?.phoneNumber ?? "",
                      color: AppColors.appBlack,
                      fontSize: 18)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            GreenButton(
                title: job?.report == null ? "Create Report":"View Report",
                sendingData: false.obs,
                onTap: () {
                  if (job?.report == null){
                    UiHelper.navigateToNextScreenGetX(
                        CreateServiceReport(jobId: job?.id ?? 0, fromJob: false, jobCaptainId: 29,));
                  }
                  else{
                    _launchURL(job?.service_report_pdf ?? 0);
                  }
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }


  Future<void> _launchURL(id) async {
    final Uri url = Uri.parse(id);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
