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

  int? selectedMonth; // Store the selected month

  var foodWatch;
  final FocusNode trnFocusNode = FocusNode();
  final FocusNode licenseFocusNode = FocusNode();


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
                  AppInput(title: "TRN", controller: controller.trn,focusNode: controller.trnFocusNode,),
                  AppInput(title: "License Number", controller: controller.license, focusNode: controller.licenseFocusNode,),
                  AppRadioSelection(title: "Food Watch Active", options: ["Link", "Unlink"], onChanged: foodWatchChanged),


                  Column(
                    children: [
                      ...controller.quoteServices.asMap().entries.map((entry) {
                        final index = entry.key;
                        final service = entry.value;

                        // Get or create date selection for this service
                        final dateSelection = controller.serviceDateSelections.length > index
                            ? controller.serviceDateSelections[index]
                            : ServiceDateSelection(
                          jobType: controller.serviceDateSelections[index].jobType,
                          servieId: controller.serviceDateSelections[index].servieId,
                          serviceIndex: index,
                          maxSelections: service.jobType == "custom" ? 1
                              : (service.noOfServices! / controller.duration).ceil(),
                          month: DateTime.now().month,
                          dates: [],
                        );

                        final allSameTypeAndCount = controller.quoteServices.every(
                                (s) => s.jobType == controller.quoteServices.first.jobType &&
                                s.noOfServices == controller.quoteServices.first.noOfServices
                        );

                        return Column(
                          children: [
                            UiHelper.dashedBoarder(),
                            SizedBox(height: 10),
                            AppTextLabels.boldTextShort(
                              label: service.service?.serviceTitle ?? "",
                              fontSize: 15,
                            ),
                            SizedBox(height: 10),
                            UiHelper.dashedBoarder(),
                            SizedBox(height: 10),
                            IgnorePointer(
                              ignoring: controller.useSameDatesForAll && index > 0,
                              child: Opacity(
                                opacity: controller.useSameDatesForAll && index > 0 ? 0.5 : 1.0,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    AppTimePicker(title: "Service Time", onTimeSelected:  (value) {
                                        final time24hr = convertTo24HourFormat(value);
                                        controller.updateServiceTime(index, time24hr);
                                        controller.licenseFocusNode.unfocus();
                                        controller.trnFocusNode.unfocus();
                                        },),
                                    SizedBox(height: 10),
                                    controller.calendarType == 0
                                        ? CustomDatePicker(
                                      maxSelections: dateSelection.maxSelections,
                                      onDatesSelected: (List<int> dates) {
                                        controller.updateServiceDates(
                                            index,
                                            dates,
                                            dateSelection.month
                                        );
                                      },
                                      onMonthChanged: (month) {
                                        controller.updateServiceMonth(index, month);

                                      },
                                    )
                                        : WeeklyDayPicker(
                                      maxSelections: dateSelection.maxSelections,
                                      selectionType: SelectionType.monthly,
                                      onDaysSelected: (dates) {
                                        // controller.updateServiceDates(
                                        //     index,
                                        //     dates,
                                        //     dateSelection.month
                                        // );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (index == 0 && allSameTypeAndCount && controller.quoteServices.length > 1)
                              Column(
                                children: [
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: controller.useSameDatesForAll,
                                        onChanged: (value) {
                                          controller.toggleUseSameDatesForAll(value ?? false);
                                        },
                                      ),
                                      Text("Use same dates for all services"),
                                    ],
                                  ),
                                ],
                              ),
                            SizedBox(height: 20),
                          ],
                        );
                      }).toList(),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GreenButton(title: "Approve Contract", sendingData: controller.sendingData, onTap: (){
                      FocusScope.of(context).unfocus();
                      controller.trnFocusNode.unfocus();
                      controller.licenseFocusNode.unfocus();
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
    print(value);

  }

  String convertTo24HourFormat(String time12hr) {
    try {
      final timeParts = time12hr.split(' ');
      final time = timeParts[0];
      final period = timeParts[1];

      final hourMinute = time.split(':');
      var hour = int.parse(hourMinute[0]);
      final minute = hourMinute[1];

      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      return '${hour.toString().padLeft(2, '0')}:$minute';
    } catch (e) {
      return '00:00'; // fallback
    }
  }



}
