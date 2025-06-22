import 'package:accurate/components/MultiSelectCheckbox.dart';
import 'package:accurate/components/UpcomignJobs/JobDetails.dart';
import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/AssignTeamScreen.dart';
import '../../components/generic/DateFilters.dart';
import '../Controllers/AllUpcomingJobsController.dart';

class AllUpComingJobs extends StatefulWidget {
  const AllUpComingJobs({Key? key}) : super(key: key);

  @override
  State<AllUpComingJobs> createState() => _AllUpComingJobsState();
}

class _AllUpComingJobsState extends State<AllUpComingJobs> {

  TextEditingController filterController = TextEditingController();
  final buttonGroupKey = GlobalKey<SelectableButtonGroupState>();
  late AllUpComingJobsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
        AllUpComingJobsController(),
        permanent: false,
        tag: Constants.allJobs
    );
  }

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
    Get.delete<AllUpComingJobsController>(tag: Constants.allJobs, force: true);
  }

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
            AppTextLabels.boldTextShort(label: "Jobs", fontSize: 20),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    child: AppTextLabels.regularText(
                        label: "Select Date",
                        color: Colors.black54,
                        fontSize: 14),
                  )),
                  DateFilters(onOptionChange: onOptionChange)
                ],
              ),
            ),
            AppInput(
              title: "Filter By Name, or Tag",
              controller: filterController,
              onChange: filterByNameChanged,
            ),
            SelectableButtonGroup(
                key: buttonGroupKey,
                titles: ["All", "Assigned", "Not Assigned"],
                onSelect: onSelect),
            Obx(() => controller.fetchingData.value
                ? UiHelper.loader()
                : Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // This centers the children horizontally
                          children: [
                            AppTextLabels.regularShortText(
                                label: UiHelper.formatDateToMonthYear(
                                    controller?.startDate ?? ""),
                                color: AppColors.appBlack),
                            Text("   -   "),
                            AppTextLabels.regularShortText(
                                label: UiHelper.formatDateToMonthYear(
                                    (controller?.endDate ?? "")),
                                color: AppColors.appBlack),
                            Text("   -   "),
                            AppTextLabels.regularShortText(
                                label: "Jobs  : ${controller.data?.length} ",
                                color: AppColors.appBlack)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: CustomListView(
                                items: controller.data ?? [],
                                itemBuilder: (context, item, index) =>
                                    jobItem(index)))
                      ],
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  onSelect(type) {
    controller.filterByType(type);
  }

  filterByNameChanged(value) {
    controller.applyFilter(value);
  }

  Widget jobItem(int index) {
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
                    Expanded(
                        child: Container(
                      child: Text(""),
                    )),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ],
            ),
            _buildRow('Job ID.', "${controller?.data?[index].id}"),
            Container(
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
                              label: "Customer",
                              color: AppColors.appBlack,
                              textAlign: TextAlign.center)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextLabels.boldTextShort(
                              label: controller.data?[index]?.user?.name ?? "",
                              color: AppColors.appBlack,
                              textAlign: TextAlign.center,
                              fontSize: 15),
                          AppTextLabels.regularShortText(
                              label: controller.data?[index]?.user?.email ?? "",
                              color: AppColors.appBlack,
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                              label: "Address",
                              color: AppColors.appBlack,
                              textAlign: TextAlign.center)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(),
                        child: AppTextLabels.regularShortText(
                            label:
                                controller.data?[index].clientAddress?.address ??
                                    "",
                            color: AppColors.appBlack)),
                  ),
                ],
              ),
            ),
            _buildRow(
                'Status',
                controller.data?[index].isCompleted == 0
                    ? "Pending"
                    : controller.data?[index].isCompleted == 1
                        ? "Completed"
                        : controller.data?[index].isCompleted == 2
                            ? "Started"
                            : ""),
            _buildRow('Priority', controller.data?[index]?.tag ?? ""),
            Container(
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
                              label: "Assign Job",
                              color: AppColors.appBlack,
                              textAlign: TextAlign.center)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.data?[index].captainId == null
                              ? GreenButton(
                                  title: "Assign Job",
                                  sendingData: false.obs,
                                  onTap: () {
                                    assignTeam(controller.data?[index].id ?? 0);
                                  })
                              : AppTextLabels.regularShortText(
                                  label:
                                      controller.data?[index]?.captain?.name ??
                                          "",
                                  color: AppColors.appBlack)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GreenButton(
                title: "View Job Details",
                sendingData: false.obs,
                onTap: () {
                  UiHelper.navigateToNextScreen(
                      context, JobDetails(id: controller.data?[index].id ?? 0));
                })
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
              child: AppTextLabels.regularShortText(
                  label: areaObject,
                  color: AppColors.appBlack,
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }

  onOptionChange(type, start, end) async {
    if (end != null) {
      await controller?.getData(start, end);
      buttonGroupKey.currentState?.reset();
    }
  }
  reset(){
    buttonGroupKey.currentState?.reset();
    controller.getTodayData();
  }
  void assignTeam(int id) {
    UiHelper.navigateToNextScreen(context, AssignTeamScreen(jobid: id, reset: reset,));
  }

  onChanged(value, index) {
    controller.getCaptainId(index);
    controller.setTeamMembers();
  }

  onSelectionChanged(value) {
    // controller.id
  }
}
