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
  // Create focus nodes
  final trnFocusNode = FocusNode();
  final licenseFocusNode = FocusNode();


  var fetchingData = false.obs;
  List<ClientsData>? allClients = [];
  List<ClientsData>? filteredClients = [];
  List<String> clientNames = [];
  bool useSameDatesForAll = false;
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
  late List<EditQuoteResponseQuoteServices> quoteServices = [];
  int duration = 0;
  int maxDates = 0;
  int calendarType = 0;
  List<DaySelection> daywiseDates = [];
  int quoteServiceID = 0;

  final List<ServiceDateSelection> serviceDateSelections = [];





  @override
  void onInit() {
    super.onInit();
    getQuoteInfo();
    serviceTime = getFormattedTime();

  }

  @override
  void onClose() {
    trnFocusNode.dispose();
    licenseFocusNode.dispose();
    trn.dispose();
    license.dispose();
    super.onClose();
  }




  void getQuoteInfo() async{
    fetchingData.value = true;
    String editQuoteUrl = Urls.baseURL + "quote/${quoteID}";
    var editRes = await api.getDataWithToken(editQuoteUrl);
    EditQuoteResponse editQuoteResponse =EditQuoteResponse.fromJson(editRes);
    quoteServices = editQuoteResponse.data?.quoteServices ?? [];

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
    initializeDateSelections(quoteServices);

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


    if (trn.text.isEmpty) {
      AlertService.showAlert("Alert", "Please enter TRN number");
      return;
    }
    if (license.text.isEmpty) {
      AlertService.showAlert("Alert", "Please enter License number");
      return;
    }
    if (foodWatch.isEmpty) {
      AlertService.showAlert("Alert", "Please select Food Watch status");
      return;
    }


    if (serviceDateSelections.isNotEmpty) {
      if (useSameDatesForAll) {
        // Validate first service
        final firstSelection = serviceDateSelections.first;
        if (firstSelection.dates.length < firstSelection.maxSelections) {
          final serviceName = quoteServices[firstSelection.serviceIndex].service?.serviceTitle ??
              "Service ${firstSelection.serviceIndex + 1}";
          AlertService.showAlert(
              "Incomplete Selection",
              "Please select all required dates for $serviceName\n"
                  "(Selected: ${firstSelection.dates.length}/${firstSelection.maxSelections})"
          );
          return;
        }

        // If validation passes, copy dates/time from first to all other services
        final firstDates = firstSelection.dates;
        final firstTime = firstSelection.serviceTime;

        for (int i = 1; i < serviceDateSelections.length; i++) {
          serviceDateSelections[i].dates = List.from(firstDates);
          serviceDateSelections[i].serviceTime = firstTime;
          serviceDateSelections[i].month = firstSelection.month;
        }
      } else {
        // Validate all services individually (existing code)
        for (final selection in serviceDateSelections) {
          if (selection.dates.length < selection.maxSelections) {
            final serviceName = quoteServices[selection.serviceIndex].service?.serviceTitle ??
                "Service ${selection.serviceIndex + 1}";
            AlertService.showAlert(
                "Incomplete Selection",
                "Please select all required dates for $serviceName\n"
                    "(Selected: ${selection.dates.length}/${selection.maxSelections})"
            );
            return;
          }
        }
      }
    }





      if (!sendingData.value) {
        sendingData.value = true;
        ApproveQuoteRequest request = ApproveQuoteRequest();
        String url = Urls.baseURL + "quote/move/contract/${quoteID}";
        request.trn = trn.text;
        request.licenseNo = license.text;
        request.isFoodWatchAccount = foodWatch == "Link" ? "1" : "0";

        List<ApproveQuoteRequestQuoteServices> list = [];

        for (final selection in serviceDateSelections) {
          // Get the corresponding quote service ID
          final quoteServiceId = quoteServices[selection.serviceIndex].id;

          // Generate dates with time for this service
          final dates = generateFutureDatesWithTime(
              duration,
              selection,
              selection.jobType ?? ""

          );

          list.add(ApproveQuoteRequestQuoteServices(
            quoteServiceId: quoteServiceId,
            dates: dates,
          ));
        }

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

  List<String> generateFutureDates(int duration, List<int> referenceDays) {
    DateTime today = DateTime.now();
    List<String> futureDates = [];

    for (int i = 0; i < duration; i++) {
      for (int day in referenceDays) {

        int targetYear = today.year;
        int targetMonth = today.month + i;

        while (targetMonth > 12) {
          targetMonth -= 12;
          targetYear += 1;
        }

        // Get the last day of the target month
        int lastDayOfMonth = DateTime(targetYear, targetMonth + 1, 0).day;

        // Use the requested day or the last day of month if requested day is invalid
        int adjustedDay = day <= lastDayOfMonth ? day : lastDayOfMonth;

        DateTime futureDate = DateTime(targetYear, targetMonth, adjustedDay);
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

  void toggleUseSameDatesForAll(bool value) {
    fetchingData.value= true;
    useSameDatesForAll = value;
    fetchingData.value= false;
  }

  void initializeDateSelections(List<EditQuoteResponseQuoteServices> quoteServices) {
    serviceDateSelections.clear();

    for (int i = 0; i < quoteServices.length; i++) {
      final service = quoteServices[i];

      // Calculate maxSelections
      int maxSelections;
      if (service.jobType == "custom") {
        maxSelections = 1;
      } else if (service.jobType == "monthly") {
        maxSelections = (service.noOfServices! / duration).ceil();
      } else {
        maxSelections = maxDates;
      }

      serviceDateSelections.add(ServiceDateSelection(
        serviceIndex: i,
        servieId: service.id ?? 0,
        maxSelections: maxSelections,
        month: DateTime.now().month,
        jobType: service.jobType,
        dates: [],
      ));
    }
  }

  void updateServiceDates(int serviceIndex, List<int> dates, int month) {
    if (useSameDatesForAll) {
      // Apply to all services
      for (var selection in serviceDateSelections) {
        selection.dates.clear();
        selection.dates.addAll(dates);
        selection.month = month;
      }
    } else {
      // Update only the specified service
      final selection = serviceDateSelections.firstWhere(
              (s) => s.serviceIndex == serviceIndex
      );
      selection.dates.clear();
      selection.dates.addAll(dates);
      selection.month = month;
    }
    update();
  }

  void updateServiceMonth(int serviceIndex, int month) {
    if (useSameDatesForAll) {
      // Update month and clear dates for all services
      for (var selection in serviceDateSelections) {
        selection.month = month;
        selection.dates.clear();
      }
    } else {
      // Update only the specified service
      final selection = serviceDateSelections.firstWhere(
              (s) => s.serviceIndex == serviceIndex
      );
      selection.month = month;
      selection.dates.clear();
    }
    update();
  }

  void updateServiceTime(int serviceIndex, String time) {
    if (useSameDatesForAll) {
      // Update time for all services
      for (var selection in serviceDateSelections) {
        selection.serviceTime = time;
      }
    } else {
      // Update time for just this service
      final selection = serviceDateSelections.firstWhere(
              (s) => s.serviceIndex == serviceIndex
      );
      selection.serviceTime = time;
    }
    update();
  }

  List<String> generateFutureDatesWithTime(int duration, ServiceDateSelection selection, String jobType) {
    // Parse the time or use default (09:00)
    final timeString = selection.serviceTime?.isNotEmpty == true
        ? selection.serviceTime!
        : "09:00";
    final timeParts = timeString.split(':');
    final hour = int.tryParse(timeParts[0]) ?? 9;
    final minute = int.tryParse(timeParts.length > 1 ? timeParts[1] : '0') ?? 0;

    List<String> futureDates = [];
    DateTime baseDate = DateTime.now();

    // If month is specified in selection, use that as starting point
    if (selection.month != null) {
      baseDate = DateTime(baseDate.year, selection.month!, 1);
    }

    if (jobType == "monthly") {
      // Monthly logic - generate dates for each month
      for (int i = 0; i < duration; i++) {
        for (int day in selection.dates) {
          // Calculate target month/year with overflow handling
          int targetYear = baseDate.year;
          int targetMonth = baseDate.month + i;

          while (targetMonth > 12) {
            targetMonth -= 12;
            targetYear += 1;
          }

          int lastDay = DateTime(targetYear, targetMonth + 1, 0).day;
          int adjustedDay = day <= lastDay ? day : lastDay;

          DateTime dateWithTime = DateTime(
            targetYear,
            targetMonth,
            adjustedDay,
            hour,
            minute,
          );

          futureDates.add(DateFormat('yyyy-MM-dd HH:mm:ss').format(dateWithTime));
        }
      }
    }
    else if (jobType == "custom") {
      // Quarterly logic - generate dates every 3 months
      for (int i = 0; i < duration; i += 3) {  // Increment by 3 months
        for (int day in selection.dates) {
          int targetYear = baseDate.year;
          int targetMonth = baseDate.month + i;

          while (targetMonth > 12) {
            targetMonth -= 12;
            targetYear += 1;
          }

          int lastDay = DateTime(targetYear, targetMonth + 1, 0).day;
          int adjustedDay = day <= lastDay ? day : lastDay;

          DateTime dateWithTime = DateTime(
            targetYear,
            targetMonth,
            adjustedDay,
            hour,
            minute,
          );

          futureDates.add(DateFormat('yyyy-MM-dd HH:mm:ss').format(dateWithTime));
        }
      }
    }

    return futureDates;
  }


}

class ServiceDateSelection {
  int serviceIndex;
  int maxSelections;
  int month;
  int servieId = 0;
  List<int> dates;
  String? jobType;
  String serviceTime;  // Changed to non-nullable with default value

  ServiceDateSelection({
    required this.serviceIndex,
    required this.maxSelections,
    required this.month,
    required this.dates,
    required this.servieId,
    required this.jobType,
    String? serviceTime,  // Optional parameter
  }) : serviceTime = serviceTime ?? _getCurrentTimeString(); // Set default

  // Convert to JSON
  Map<String, dynamic> toJson() => {
    'serviceIndex': serviceIndex,
    'maxSelections': maxSelections,
    'month': month,
    'dates': dates,
    'serviceTime': serviceTime,
  };


  // Helper method to get current time in 24-hour format
  static String _getCurrentTimeString() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}