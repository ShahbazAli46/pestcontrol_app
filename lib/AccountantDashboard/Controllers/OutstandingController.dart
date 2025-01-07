import 'package:accurate/jsonModels/AllInvoicesResponse.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OutstandingController extends GetxController {
  var fetchingData = false.obs;

  late AllInvoicesResponse invoicesResponse;
  late double thisMonthAmount = 0.0;
  late double lastMonthAmount = 0.0;
  late double thirdMonthAmount = 0.0;
  late double olderThanThreeMonth = 0.0;


  List<InvoicesData> thisMonthData = [];
  List<InvoicesData> lastMonthData = [];
  List<InvoicesData> thirdMonthData = [];
  List<InvoicesData> olderThanMonthData = [];



  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    fetchingData.value = true;
    String url = "${Urls.baseURL}outstandings";
    var api = APICall();
    var response = await api.getDataWithToken(url);
    OutstandingResponse outstandingResponse = OutstandingResponse.fromJson(response);

    outstandingResponse.data?.forEach((item){
        if (item.title == "This Month"){
          thisMonthAmount = double.parse(item.totalAmt ?? "");
        } else if (item.title == "Last Month"){
          lastMonthAmount = double.parse(item.totalAmt ?? "");
        } else if (item.title == "Last 3 Months"){
          thirdMonthAmount = double.parse(item.totalAmt ?? "");
        } else if (item.title == "Older Than 3 Months"){
          olderThanThreeMonth = double.parse(item.totalAmt ?? "");
        }

    });



    fetchingData.value = false;
  }

}





class OutstandingResponse {
  List<Data>? data;

  OutstandingResponse({this.data});

  OutstandingResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? title;
  String? count;
  String? totalAmt;

  Data({this.title, this.count, this.totalAmt});

  Data.fromJson(Map<String, dynamic> json) {
    title = "${json['title']}";
    count = "${json['count']}";
    totalAmt = "${json['total_amt']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['count'] = this.count;
    data['total_amt'] = this.totalAmt;
    return data;
  }
}