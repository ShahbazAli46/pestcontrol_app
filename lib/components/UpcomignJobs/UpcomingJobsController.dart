import 'package:accurate/UserRepository.dart';
import 'package:accurate/jsonModels/UserDetails.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpcomingJobsController extends GetxController {
  var fetchingData = false.obs;
  late List<CaptainJobs> captainJobs;
  late UserDetails details = UserDetails();
  var  currentUnit = "".obs;
  var remainingStock = "".obs;

  List<String> stocksList = <String>[];
  List<Stocks>? stocks;

  List<CaptainJobs> upcomingJobs = [];
  List<CaptainJobs> previousJobs = [];
  var currentStock = 0.0.obs;
  List<AssignedInvoices>? assignedInvoices = [];



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  void fetchJob() async {
    fetchingData.value = true;
    int userID = userObj?.data?.id ?? 0;
    String url = "${Urls.upcomingJobs}$userID";
    var response = await APICall().getDataWithToken(url);
    details = UserDetails.fromJson(response);
    assignedInvoices = details.data?.assignedInvoices ?? [];
    List<String> items = [];
    stocks = details.data?.stocks;
    details.data?.stocks?.forEach((item) {
      items.add(item.product?.productName ?? "");
    });
    stocksList = items.map((e) => e as String).toList();
    if (details.data?.captainJobs != null) {
      captainJobs = details.data!.captainJobs!;

      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);

      for (var job in captainJobs) {
        if (job.jobDate == null) continue;
        DateTime? jobDateTime;
        try {
          jobDateTime = DateTime.parse(job.jobDate!);
        } catch (e) {
          print('Error parsing date: ${job.jobDate}');
          continue;
        }
        if (jobDateTime.isAfter(today) || jobDateTime.isAtSameMomentAs(today)) {
          upcomingJobs.add(job);
        } else {
          previousJobs.add(job);
        }
      }
    }
    else{
      captainJobs = [];
    }

    captainJobs = upcomingJobs;

    fetchingData.value = false;
  }

  void changeListType(int type){
    // type 0 == upcoming || type == 1 previuos
    fetchingData.value = true;
    if (type == 0){
      captainJobs = upcomingJobs;
      print(captainJobs.length);
    }
    else{
      captainJobs = previousJobs;

      print(captainJobs.length);
    }
    fetchingData.value = false;
  }

  void setChemicalsUnit(int index){
    currentUnit.value =  "${details.data?.stocks?[index].product?.unit}" ;
    remainingStock.value = "Current Stock ${double.parse(details.data?.stocks?[index].remainingQty ?? "") * double.parse(details.data?.stocks?[index].product?.per_item_qty ?? "" )} ${currentUnit.value}" ;
    currentStock.value = double.parse(details.data?.stocks?[index].remainingQty ?? "0.0") * double.parse(details.data?.stocks?[index].product?.per_item_qty ?? "" );
  }

  int getProductId(int index) {
    setChemicalsUnit(index);
    return details.data?.stocks?[index].product?.id ?? 0;
  }

  void getTodayData() {
    String start = formatDate(DateTime.now());
    String end = formatDate(DateTime.now());
    getData(start, end);
  }

  void getData(start, end) async {
    fetchingData.value = true;
    int userID = userObj?.data?.id ?? 0;
    String url = "${Urls.upcomingJobs}$userID" + "?start_date=${start}&end_date=${end}";
    var response = await APICall().getDataWithToken(url);
    details = UserDetails.fromJson(response);
    assignedInvoices = details.data?.assignedInvoices ?? [];
    List<String> items = [];
    stocks = details.data?.stocks;
    details.data?.stocks?.forEach((item) {
      items.add(item.product?.productName ?? "");
    });
    stocksList = items.map((e) => e as String).toList();
    if (details.data?.captainJobs != null) {
      captainJobs = details.data!.captainJobs!;

      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);

      for (var job in captainJobs) {
        if (job.jobDate == null) continue;
        DateTime? jobDateTime;
        try {
          jobDateTime = DateTime.parse(job.jobDate!);
        } catch (e) {
          print('Error parsing date: ${job.jobDate}');
          continue;
        }
        if (jobDateTime.isAfter(today) || jobDateTime.isAtSameMomentAs(today)) {
          upcomingJobs.add(job);
        } else {
          previousJobs.add(job);
        }
      }
    }
    else{
      captainJobs = [];
    }

    captainJobs = upcomingJobs;

    fetchingData.value = false;
  }


  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }


}

class SharedStringController extends GetxController {
  var sharedString = 'Shahbaz'.obs;

  void updateString(String newString) {
    sharedString.value = newString;
  }

}
