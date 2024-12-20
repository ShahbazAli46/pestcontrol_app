import 'package:accurate/components/MultiSelectCheckbox.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/AppTimePicker.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/superadmin/Controllers/AllUpcomingJobsController.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignTeamScreen extends StatefulWidget {
  int jobid = -1;
  Function reset;
  AssignTeamScreen({required this.jobid, required this.reset});

  @override
  State<AssignTeamScreen> createState() => _AssignTeamScreenState();
}

class _AssignTeamScreenState extends State<AssignTeamScreen> {
  AllUpComingJobsController controller = Get.find(tag: Constants.allJobs);
  List<String> teamIds = [];

  TextEditingController textEditingController = TextEditingController();

  var sendingData = false.obs;

  @override
  void initState() {
    super.initState();
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Expanded(
                child: Column(
                          children: [
                NavWithBack(),
                const SizedBox(
                  height: 20,
                ),
                AppTextLabels.boldTextShort(label: "Assign Team", fontSize: 20),
                SizedBox(
                  height: 20,
                ),
                AppDropdown(
                    title: "Please Select Captain",
                    options: controller.captains,
                    onChanged: onChanged),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: MultiSelectCheckbox(
                      items: controller.teamMembers,
                      onSelectionChanged: onSelectionChanged),
                ),
                SizedBox(
                  height: 20,
                ),
                            AppTimePicker(title: "Job Time", onTimeSelected: onTimeSelected),
                            SizedBox(
                              height: 20,
                            ),
                AppMultilineInput(title: "Jb Instructions", controller: textEditingController),
                Container(
                  margin: EdgeInsets.all(10),
                  child: GreenButton(
                      title: "Assign Team",
                      sendingData: sendingData,
                      onTap: () {
                        sendData();
                      }),
                )
                          ],
                        ),
              ),
            )));
  }

  onChanged(value, index) {
    controller.getCaptainId(index);
    controller.setTeamMembers();
  }

  onSelectionChanged(List<String> value) {
    teamIds = value;
  }

  onTimeSelected(time){
    print(time);
  }

  sendData() async {
    if (controller.captainId == -1) {
      AlertService.showAlert("Error", "Please select Captain");
    } else if (teamIds.isEmpty) {
      AlertService.showAlert("Error", "Please select Team Members");
    } else if (textEditingController.text.isEmpty){
      AlertService.showAlert("Error", "Please enter job instructions");
    } else {
      sendingData.value = true;
      final commaSeparatedString = teamIds.join(',');
      AssignJobRequest request = AssignJobRequest(jobId: "${widget.jobid}", teamMemberIds: commaSeparatedString,jobInstructions: textEditingController.text, captainId:"${controller.captainId}");
      var api = APICall();
      var response = await api.postDataWithToken(Urls.assignJob, request.toJson());
      GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(response);
      print(errorResponse.status);
      if (errorResponse.status == "error"){
        AlertService.showAlert("Alert", errorResponse.message ?? "");
      }
      else{
        AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
          widget.reset();
          Get.back();
        });
      }
      sendingData.value = false;

    }
  }
}





class AssignJobRequest {
  String? jobId;
  String? captainId;
  String? teamMemberIds;
  String? jobInstructions;

  AssignJobRequest(
      {this.jobId, this.captainId, this.teamMemberIds, this.jobInstructions});

  AssignJobRequest.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    captainId = json['captain_id'];
    teamMemberIds = json['team_member_ids'];
    jobInstructions = json['job_instructions'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['job_id'] = this.jobId!;
    data['captain_id'] = this.captainId ?? "";
    data['team_member_ids'] = this.teamMemberIds ?? "";
    data['job_instructions'] = this.jobInstructions ?? "";
    return data;
  }
}
