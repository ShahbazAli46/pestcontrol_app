import 'package:accurate/jsonModels/JobDetailsResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';


class JobDetailsController extends GetxController {
    var fetchingData = false.obs;
    var jobId = 0;
    JobDetailsController({required this.jobId});
    JobDetailsResponse? jobData;
    bool fetched = false;
    Captain? loggedInCaptain;
    List<Captain> allCaptain  = [];
    var allCompleted = 0;


    final apiCall = APICall();


    List<CaptainsList>jobCaptains = [];

    void fetchJobDetails() async {
      jobData = null;
      fetched = false;
      fetchingData.value = true;
      try {
        String url = Urls.singleJobDetails + "${jobId}";
        var response = await apiCall.getDataWithToken(url);
        jobData = JobDetailsResponse.fromJson(response);
        allCaptain.clear();
        jobCaptains.clear();
        jobData?.data?.captains.forEach((item){
          allCaptain.add(item);
          allCompleted = item.isCompleted ?? 0;
          if ((item.captainId ?? 0) == userObj?.data?.id){
            loggedInCaptain = item;
          }
          List<TeamMember> teamMember = [];
          item.teamMembers.forEach((team){
            teamMember.add(TeamMember(name: team.name ?? "", phone: team.employee?.phoneNumber ?? ""));
          });
          CaptainsList cap = CaptainsList(
            captainName: item.captain?.name ?? "",
            teamMembers: teamMember
          );
          jobCaptains.add(cap);
        });
        fetched = true;
      } catch (e, stackTrace) {
        print('Error fetching job details: $e');
        print('Stack trace: $stackTrace');

      } finally {
        fetchingData.value = false;
      }
    }
}



class CaptainsList {
  final String captainName;
  final List<TeamMember> teamMembers;

  CaptainsList({
    required this.captainName,
    required this.teamMembers,
  });
}

class TeamMember {
  final String name;
  final String phone;

  TeamMember({
    required this.name,
    required this.phone,
  });
}