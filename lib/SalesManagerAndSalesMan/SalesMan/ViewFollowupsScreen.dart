import 'package:accurate/SalesManagerAndSalesMan/SalesMan/Controlers/FollowUpsController.dart';
import 'package:accurate/components/MapLauncher.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewFollowupsScreen extends StatefulWidget {
  const ViewFollowupsScreen({super.key});

  @override
  State<ViewFollowupsScreen> createState() => _ViewFollowupsScreenState();
}

class _ViewFollowupsScreenState extends State<ViewFollowupsScreen> {

  late FollowupsController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(FollowupsController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<FollowupsController>();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Follow Ups", fontSize: 20),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Container(child: AppTextLabels.regularShortText(label: "Select Date", color: AppColors.lightTextColor),)),
                  DateFilters(onOptionChange: onOptionChange),
                ],
              ),
            ),
            Obx(()=> controller.fetchingData.value ? UiHelper.loader() :  Expanded(child: CustomListView(items: controller.visits ?? [], itemBuilder: (context, item, index)=>visitItem(index))))

          ],
        )));
  }

  onOptionChange (name, start, end){
    String startDate = UiHelper.formatDateForServer(start);
    String endDate = UiHelper.formatDateForServer(end);
    controller.getData(startDate, endDate);

  }


  Widget visitItem(int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
        child: Column(
          children: [
            UiHelper.buildRow("Sr", "${index + 1}"),
            UiHelper.buildRow("Firm", controller.visits?[index].userClient?.client?.firmName ?? ""),
            UiHelper.buildRow("Follow Up Date", UiHelper.formatDate(controller.visits?[index].followUpDate ?? "")),
            UiHelper.buildRow("Remarks", controller.visits?[index].description ?? ""),
            GreenButton(title: "Open Location", sendingData: false.obs, onTap: (){
              openMaps(double.parse(controller.visits?[index].clientAddress?.lat ?? ""), double.parse(controller.visits?[index].clientAddress?.lang ?? ""));
            })
          ],
        ),
      ),
    );
  }
  Future<void> openMaps(double lat, double long) async {
    MyMapLauncher.openMapsWithLocation(latitude: lat, longitude: long);
  }

}
