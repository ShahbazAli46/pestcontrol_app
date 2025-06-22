import 'package:accurate/components/MultiSelectCheckbox.dart';
import 'package:accurate/jsonModels/AllJobsResponse.dart';
import 'package:accurate/jsonModels/TeamListResponse.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/APICall.dart';
import '../../utils/Constants.dart';

class AllUpComingJobsController extends GetxController {
  var fetchingData = false.obs;
  String? startDate;
  String? endDate;
  var api = APICall();

  List<String> captains = [];
  final RxList<CheckboxItem> teamMembers = <CheckboxItem>[].obs;
  final RxList<CheckboxItem> allTeamMembers = <CheckboxItem>[].obs;

  List<CaptainJobs>? data;
  List<CaptainJobs>? allData;
  late TeamListResponse list;
  int captainId = -1;

  final List<TeamIds> teamAssignments = [TeamIds()];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTodayData();
    getTeam();
  }

  Future<void> getData(start, end) async {
    fetchingData.value = true;
    String url = Urls.baseURL + "job/all?start_date=${start}&end_date=${end}";

    var response = await api.getDataWithToken(url);
    AllJobsResponse res = AllJobsResponse.fromJson(response);
    startDate = res.startDate;
    endDate = res.endDate;
    data = res?.data;
    allData = data;
    fetchingData.value = false;
  }

  void applyFilter(String value) {
    fetchingData.value = true;
    if (value.isEmpty) {
      data = allData;
      fetchingData.value = false;
      return;
    }
    String searchTerm = value.toLowerCase();
    data = allData?.where((job) {
      bool matchesName =
          job.user?.name?.toLowerCase().contains(searchTerm) ?? false;
      bool matchesTag = job.tag?.toLowerCase().contains(searchTerm) ?? false;
      return matchesName || matchesTag;
    }).toList();
    fetchingData.value = false;
  }

  void filterByType(int type) {
    fetchingData.value = true;
    if (type == 0) {
      data = allData;
    } else if (type == 1) {
      data = allData?.where((job) {
        bool matchesName = job.captainId != null;
        return matchesName;
      }).toList();
    } else {
      data = allData?.where((job) {
        bool matchesName = job.captainId == null;
        return matchesName;
      }).toList();
    }
    fetchingData.value = false;
  }

  void reset(){
    captainId =  -1;
    setTeamMembers();
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  void getTodayData() {
    String start = formatDate(DateTime.now());
    String end = formatDate(DateTime.now());
    getData(start, end);
  }

  void getTeam() async {
    String url = Urls.allOperationsTeams;
    var response = await api.getDataWithToken(url);
    list = TeamListResponse.fromJson(response);
    list.data?.forEach((item) {
      captains.add(item?.name ?? "");
    });
  }

  void getCaptainId (index){
    captainId = list?.data?[index]?.id ?? 0;
  }

  void setTeamMembers (){
    teamMembers.clear();
    List<CheckboxItem> team = [];
    list.data?.forEach((item) {
      if (item.id != captainId){
        team.add(
            CheckboxItem(id: "${item.id}", value: item.name ?? "")
        );
      }
    });
    allTeamMembers.assignAll(team);
    teamMembers.assignAll(team);
  }


  void getCaptainIdFromList(int selectionIndex, int listIndex) {
    if (listIndex >= 0 &&
        listIndex < teamAssignments.length &&
        selectionIndex >= 0 &&
        selectionIndex < (list?.data?.length ?? 0)) {

      // Get the selected captain's ID
      final selectedCaptainId = list?.data?[selectionIndex]?.id;

      // Set the ID in the specified team assignment
      teamAssignments[listIndex].captainId = selectedCaptainId?.toString();

      // Optional: Also store the captain name if needed
      teamAssignments[listIndex].captainName = list?.data?[selectionIndex]?.name;

      update(); // Notify listeners if using GetX
    }
  }
  void setTeamMembersFromList(List<String> selectedTeamIds, int listIndex) {
    if (listIndex >= 0 && listIndex < teamAssignments.length) {
      // Convert List<String> to List<int>
      List<int> intTeamIds = selectedTeamIds.map((id) => int.tryParse(id)).whereType<int>().toList();

      teamAssignments[listIndex].teamMemberIds = intTeamIds;
      update(); // Notify listeners if using GetX
    }
  }

  List<CheckboxItem> getAvailableMembers(int forAssignmentIndex) {
    // Get all currently assigned member IDs EXCEPT those in current assignment
    final assignedElsewhere = teamAssignments
        .asMap()
        .entries
        .where((entry) => entry.key != forAssignmentIndex)
        .expand((entry) => entry.value.teamMemberIds)
        .toSet();
    return allTeamMembers.where((member) =>
    !assignedElsewhere.contains(member.id)).toList();
  }


}


class TeamIds {
  String? captainId;
  String? captainName;
  List<int> teamMemberIds = [];
  String? instructions;
  TextEditingController instructionController =  TextEditingController();
}



