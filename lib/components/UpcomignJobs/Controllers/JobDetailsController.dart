import 'package:accurate/jsonModels/JobDetailsResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';


class JobDetailsController extends GetxController {
    var fetchingData = false.obs;
    var jobId = 0;
    JobDetailsController({required this.jobId});
    JobDetailsResponse? jobData;
    bool fetched = false;
    List<TeamMembers> members = [];
    final apiCall = APICall();

    void fetchJobDetails() async {
      jobData = null;
      fetched = false;
      fetchingData.value = true;
      try {
        String url = Urls.singleJobDetails + "${jobId}";
        var response = await apiCall.getDataWithToken(url);
        jobData = JobDetailsResponse.fromJson(response);
        members.clear();
        members.addIf(true, jobData!.data!.captain!);
        members.addAllIf(true, jobData!.data!.teamMembers ?? []);
        fetched = true;
      } catch (e) {
        print('Error fetching job details: $e');
      } finally {
        fetchingData.value = false;
      }
    }

}