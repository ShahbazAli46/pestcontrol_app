import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/AppTimePicker.dart';
import 'package:accurate/components/generic/CustomDatePicker.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/WeeklyDayPicker.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/controllers/generic/AppRadioSelection.dart';
import 'package:accurate/superadmin/Controllers/ApproveQuoteController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApproveQuoteScreen extends StatefulWidget {
  int qouteItd;
  ApproveQuoteScreen({required this.qouteItd});

  @override
  State<ApproveQuoteScreen> createState() => _ApproveQuoteScreenState();
}

class _ApproveQuoteScreenState extends State<ApproveQuoteScreen> {

  late ApproveQuoteController controller;

  var foodWatch;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ApproveQuoteController(quoteID: widget.qouteItd));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<ApproveQuoteController>();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            Obx(()=>controller.fetchingData.value ? UiHelper.loader() : Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  AppTextLabels.boldTextShort(label: "Approve Quote", fontSize: 20),
                  SizedBox(height: 20,),
                  AppInput(title: "TRN", controller: controller.trn),
                  AppInput(title: "License Number", controller: controller.license),
                  AppRadioSelection(title: "Food Watch Active", options: ["Link", "Unlink"], onChanged: foodWatchChanged),
                  AppTimePicker(title: "Service Time", onTimeSelected: onTimeSelected),
                  UiHelper.dashedBoarder(),
                  SizedBox(height: 10,),
                  AppTextLabels.boldTextShort(label: "Select Date", fontSize: 15),
                  SizedBox(height: 10,),
                  UiHelper.dashedBoarder(),
                  SizedBox(height: 10,),
                  SelectableButtonGroup(titles: ["Date","Daywise"], onSelect: (index){controller.setDateType(index);}),
                  controller.calendarType == 0 ? CustomDatePicker(
                    maxSelections: controller.maxDates,
                    onDatesSelected:  (List<int> dates) {
                      controller.selectedDates.clear();
                      controller.selectedDates = dates;
                      print(controller.selectedDates);
                    },) : WeeklyDayPicker(maxSelections: controller.maxDates, selectionType: SelectionType.monthly,onDaysSelected: (dates){
                      print(dates);
                      controller.daywiseDates = dates;
                  },),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GreenButton(title: "Approve Contract", sendingData: controller.sendingData, onTap: (){
                      FocusScope.of(context).unfocus();
                      controller.submit();
                    }),
                  )


                ],
              ),
            ))),

          ],
        ),
      ),
    );
  }

  foodWatchChanged(value, index){
    controller.foodWatch = value;
  }
  onTimeSelected(value){
    controller.serviceTime;
  }



}
