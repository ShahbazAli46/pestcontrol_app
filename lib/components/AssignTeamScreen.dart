import 'package:accurate/components/MultiSelectCheckbox.dart';
import 'package:accurate/components/generic/AppDropdown.dart';
import 'package:accurate/components/generic/AppMultilineInput.dart';
import 'package:accurate/components/generic/AppTimePicker.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
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
                            AppTimePicker(title: "Job Time", onTimeSelected: onTimeSelected),
                            ..._buildAssignmentSections(),
                            _buildAddButton(),
                            SizedBox(
                              height: 20,
                            ),

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

  List<Widget> _buildAssignmentSections() {
    return controller.teamAssignments.asMap().entries.map((entry) {
      final listIndex = entry.key;
      final index = entry.key;
      final assignment = entry.value;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Section Title
            if (index > 0) Column(
              children: [
                SizedBox(height: 10),
                UiHelper.dashedBoarder(),
                SizedBox(height: 10),
              ],
            ),
            Row(
              children: [
                AppTextLabels.boldTextShort(label: "Team ${index + 1}", fontSize: 15),
                Spacer(),
                if (controller.teamAssignments.length > 1) // Show delete only if more than one
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeAssignment(index),
                  ),
              ],
            ),
            SizedBox(height: 10),

            // The repeatable section
            AppDropdown(
              title: "Please Select Captain",
              options: controller.captains,
              selectedOption: controller.captains.contains(controller.teamAssignments[listIndex].captainName)
                  ? controller.teamAssignments[listIndex].captainName
                  : null,
              onChanged: (value, index) => controller.getCaptainIdFromList(index ?? 0, listIndex),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() {
                final availableMembers = controller.getAvailableMembers(listIndex).obs; // Convert to RxList
                return MultiSelectCheckbox(
                  items: availableMembers,

                  onSelectionChanged: (selected) {
                    final selectedIds = selected.map((item) => item).toList();
                    controller.setTeamMembersFromList(selectedIds, listIndex);
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            AppMultilineInput(
              title: "Instructions",
              controller: controller.teamAssignments[listIndex].instructionController,
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildAddButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: OutlinedButton.icon(
        icon: Icon(Icons.add),
        label: Text("Add Another Team"),
        onPressed: _addAssignment,
      ),
    );
  }

  void _addAssignment() => setState(() => controller.teamAssignments.add(TeamIds()));

  void _removeAssignment(int index) {
    if (controller.teamAssignments.length > 1) {
      setState(() => controller.teamAssignments.removeAt(index));
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

class TeamAssignment {
  String? captainId;
  List<String> teamIds = [];
  TextEditingController instructionsController = TextEditingController();
  TimeOfDay? jobTime;

  TeamAssignment();
}
