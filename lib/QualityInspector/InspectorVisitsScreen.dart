import 'package:accurate/QualityInspector/Controllers/InspectorVisitsController.dart';
import 'package:accurate/components/ImageViewerDialog.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InspectorVisitsScreen extends StatefulWidget {
  const InspectorVisitsScreen({Key? key}) : super(key: key);

  @override
  State<InspectorVisitsScreen> createState() => _InspectorVisitsScreenState();
}

class _InspectorVisitsScreenState extends State<InspectorVisitsScreen> {

  late InspectorVisitsController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(InspectorVisitsController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.deleteAll(force: true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
      children: [
        NavWithBack(),
        SizedBox(height: 20,),
        AppTextLabels.boldTextShort(label: "Visits", fontSize: 20),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: AppTextLabels.boldTextShort(
                          label: "Select Date", fontSize: 15)),
                  DateFilters(onOptionChange: onOptionChange),
                ],
              ),


            ],
          ),
        ),
        Obx(()=> controller.fetchingData.value ? UiHelper.loader() : Expanded(child: CustomListView(
          items: controller.data ?? [],
          itemBuilder: (context, item, index)=>_item(index),
        )))
      ],
    )));
  }
  onOptionChange(option, start, end) {
    controller.getData(UiHelper.formatDateForServer(start), UiHelper.formatDateForServer(end));
  }

  _item(index){
    return UiHelper.commonContainer(Column(
      children: [
        UiHelper.buildRow("sr", "${index + 1}"),
        UiHelper.buildRow("Client", "${controller.data?[index].userClient?.name}"),
        UiHelper.buildRow("Client Remarks", "${controller.data?[index].clientRemarks}"),
        UiHelper.buildRow("Comments for Operations", "${controller.data?[index].recommendationForOperation}"),
        UiHelper.buildRow("General Comments", "${controller.data?[index].generalComment}"),
        UiHelper.buildRow("Nesting Area", "${controller.data?[index].nestingArea}"),
        TextButton(onPressed: (){
          showImageViewer(context, controller.data?[index].pictures ?? []);
        }, child: AppTextLabels.regularShortText(label: "View Attachments", color: AppColors.appGreen))

      ],
    ));
  }
}
