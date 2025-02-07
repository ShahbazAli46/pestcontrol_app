import 'dart:convert';

import 'package:accurate/components/MultiSelectCheckbox.dart';
import 'package:accurate/components/generic/SearchableDropdownWithID.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/WeeklyDayPicker.dart';
import 'package:accurate/jsonModels/ApproveQuoteRequest.dart';
import 'package:accurate/jsonModels/CilentsResponse.dart';
import 'package:accurate/jsonModels/EditQuoteResponse.dart';
import 'package:accurate/jsonModels/GeneralErrorResponse.dart';
import 'package:accurate/jsonModels/QuoteServices.dart';
import 'package:accurate/jsonModels/ServiceAgreementResponse.dart';
import 'package:accurate/jsonModels/TermAndConditionsResponse.dart';
import 'package:accurate/jsonModels/TreatmentMethodsResponse.dart';
import 'package:accurate/main.dart';
import 'package:accurate/superadmin/Components/AddServiceScreen.dart';
import 'package:accurate/superadmin/Components/EditQuote/EditServiceAgreementScreen.dart';
import 'package:accurate/superadmin/Components/ServiceAgreementScreen.dart';
import 'package:accurate/utils/APICall.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ApproveQuoteController extends GetxController {

  ApproveQuoteController({required this.quoteID});

  var fetchingData = false.obs;
  List<ClientsData>? allClients = [];
  List<ClientsData>? filteredClients = [];
  List<String> clientNames = [];

  List<DropdownItem> firmNames = [];
  List<DropdownItem> addresses = [];
  var refreshAddress = true.obs;
  var sendingData = false.obs;

  APICall api = APICall();
  var selectedClientID = 0;
  var selectedSelectedAddressID = 0;
  var selectedTermAndConditionID = 0;

  int quoteID = 0;
  var serviceTime = "";
  var foodWatch = "";


  TextEditingController trn = TextEditingController();
  TextEditingController license = TextEditingController();





  List<ServiceAgreementResponseData>? agreements = [];
  late RxList animalNames = [].obs;
  List<int> selectedAnimals = [];
  List<int> selectedDates = [];



  var refreshQuoteServices = false.obs;
  var refreshServiceView = false.obs;
  List<String> serviceNames = [];
  List<DropdownItem> allServices = [];
  late List<QuoteServices> quoteServices = [];
  int duration = 0;
  int maxDates = 0;
  int calendarType = 0;
  List<DaySelection> daywiseDates = [];
  int quoteServiceID = 0;




  @override
  void onInit() {
    super.onInit();
    getQuoteInfo();
    serviceTime = getFormattedTime();

  }


  void getQuoteInfo() async{
    fetchingData.value = true;
    String editQuoteUrl = Urls.baseURL + "quote/${quoteID}";
    var editRes = await api.getDataWithToken(editQuoteUrl);
    EditQuoteResponse editQuoteResponse =EditQuoteResponse.fromJson(editRes);
    duration = editQuoteResponse.data?.durationInMonths ?? 0;
    selectedClientID = editQuoteResponse.data?.userId ?? 0;
    selectedSelectedAddressID = editQuoteResponse.data?.clientAddressId ?? 0;
    List<int> intList = List<int>.from(jsonDecode(editQuoteResponse.data?.serviceIds ?? ""));
    quoteServiceID = editQuoteResponse.data?.quoteServices![0].id ?? 0;
     if (editQuoteResponse.data?.quoteServices![0].jobType == "monthly"){

       int numberOfJob = editQuoteResponse.data?.quoteServices![0].noOfServices ?? 0;
       maxDates = (numberOfJob / duration).ceil();
     }
     else{
       maxDates = 1;
     }

    selectedAnimals =  intList;
    fetchingData.value = false;
  }

  void setDateType(int index){
    fetchingData.value = true;
    selectedDates.clear();
    daywiseDates.clear();
    calendarType = index;
    fetchingData.value = false;
  }



  void submit() async{
    if (trn.text.isEmpty){
      AlertService.showAlert("Alert", "Please enter TRN number");
    } else if (license.text.isEmpty){
      AlertService.showAlert("Alert", "Please enter License number");
    } else if (foodWatch.isEmpty){
      AlertService.showAlert("Alert", "Please select Food Watch status");
    }
    else if (calendarType == 0 && selectedDates.length < maxDates){
      AlertService.showAlert("Alert", "Please select ${maxDates} dates for service");
    } else if (calendarType == 1 && daywiseDates.length < maxDates){
      AlertService.showAlert("Alert", "Please select ${maxDates} dates for service");
    } else {
      if (!sendingData.value) {
        sendingData.value = true;
        ApproveQuoteRequest request = ApproveQuoteRequest();
        String url = Urls.baseURL + "quote/move/contract/${quoteID}";
        request.trn = trn.text;
        request.licenseNo = license.text;
        request.isFoodWatchAccount = foodWatch == "Link" ? "1" : "0";
        List<ApproveQuoteRequestQuoteServices> list = [];
        ApproveQuoteRequestQuoteServices services = ApproveQuoteRequestQuoteServices(
            quoteServiceId: quoteServiceID,
            dates: calendarType == 0 ? generateFutureDates(
                duration, selectedDates) : generateWeekWiseDates(
                duration, daywiseDates)
        );
        list.add(services);
        request.quoteServices = list;
        var response = await api.postDataWithToken(url, request.toJson());
        GeneralErrorResponse errorResponse = GeneralErrorResponse.fromJson(
            response);
        if (errorResponse.status == "success") {
            AlertService.showAlertWithAction("Success", errorResponse.message ?? "", onOkPressed: (){
              var home = UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0);
              Get.offAll(()=>home);
            });
        }
        else {
          AlertService.showAlert("Alert", errorResponse.message ?? "");
        }
        sendingData.value = false;
      }
    }
  }

  List<String> generateFutureDates(int duration, List<int> referenceDays) {
    DateTime today = DateTime.now();
    List<String> futureDates = [];

    for (int i = 0; i < duration; i++) {
      for (int day in referenceDays) {
        DateTime futureDate = DateTime(today.year, today.month + i, day);
        String formattedDate = DateFormat('yyyy-MM-dd').format(futureDate);
        futureDates.add(formattedDate);
      }
    }

    return futureDates;
  }


  List<String> generateWeekWiseDates(int months, List<DaySelection> daySelections) {
    DateTime today = DateTime.now();
    List<String> futureDates = [];

    for (int i = 0; i < months; i++) {
      DateTime monthStart = DateTime(today.year, today.month + i, 1);

      for (DaySelection selection in daySelections) {
        DateTime targetDate = getExactNthWeekday(monthStart.year, monthStart.month, selection.weekNumber, selection.weekday);
        String formattedDate = DateFormat('yyyy-MM-dd').format(targetDate);
        futureDates.add(formattedDate);
      }
    }

    return futureDates;
  }

  /// Function to get the exact nth occurrence of a weekday in a given month
  DateTime getExactNthWeekday(int year, int month, int week, String weekday) {
    Map<String, int> weekdays = {
      'Mon': DateTime.monday,
      'Tue': DateTime.tuesday,
      'Wed': DateTime.wednesday,
      'Thu': DateTime.thursday,
      'Fri': DateTime.friday,
      'Sat': DateTime.saturday,
      'Sun': DateTime.sunday,
    };

    int targetWeekday = weekdays[weekday]!;
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int firstWeekdayOfMonth = firstDayOfMonth.weekday; // 1 (Mon) to 7 (Sun)

    // Find the first occurrence of the target weekday
    int daysToAdd = (targetWeekday - firstWeekdayOfMonth + 7) % 7;
    DateTime firstOccurrence = firstDayOfMonth.add(Duration(days: daysToAdd));

    // Calculate the nth occurrence of the target weekday
    DateTime nthWeekday = firstOccurrence.add(Duration(days: (week - 1) * 7));

    return nthWeekday;
  }

  String getFormattedTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('hh:mm a');
    String formattedTime = formatter.format(now);
    return formattedTime;
  }

}