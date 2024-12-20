import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/MonthPicker.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/SalesReportController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({Key? key}) : super(key: key);

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  SalesReportController controller = Get.put(SalesReportController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              NavWithBack(),
              SizedBox(height: 20,),
              AppTextLabels.boldTextShort(label: "Sales Report", fontSize: 20, color: AppColors.appGreen),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MonthPicker(onMonthChanged: onMonthChanged),
              ),
              SizedBox(height: 10,),
              Obx(() => controller.fetchingData.value
                  ? Container(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                    children: [
                      Row(
                        children: [
                         Container(
                           height: 50,
                           width: 50,
                           child: Center(
                             child: AppTextLabels.boldTextShort(label: "Sr", color: AppColors.appBlack, fontSize: 15),
                           ),
                         ),
                          Expanded(child: Container(
                            height: 50,
                            child: Center(
                              child: AppTextLabels.boldTextShort(label: "Name", color: AppColors.appBlack, fontSize: 15),
                            ),
                          )),
                          Expanded(child: Container(
                            height: 50,
                            child: Center(
                              child: AppTextLabels.boldTextShort(label: "Target", color: AppColors.appBlack, fontSize: 15),
                            ),
                          )),
                          Expanded(child: Container(
                            height: 50,
                            child: Center(
                              child: AppTextLabels.boldTextShort(label: "Sales", color: AppColors.appBlack, fontSize: 15),
                            ),
                          ))
                        ],
                      ),
                      UiHelper.dashedBoarder(),
                      Container(
                        height: 400,
                        child: CustomListView(
                          physics: NeverScrollableScrollPhysics(),
                          items: controller.data ?? [],
                          itemBuilder: (context, item, index)=> salesItem(index),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  onMonthChanged(month) {
    controller.getData(month);
  }

  Widget salesItem (index){
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                child: Center(
                  child: AppTextLabels.regularShortText(label: "${index + 1}", color: AppColors.appBlack),
                ),
              ),
              Expanded(child: Container(
                height: 50,
                child: Center(
                  child: AppTextLabels.regularShortText(label: controller.data?[index].referencable?.name ?? "", color: AppColors.appBlack),
                ),
              )),
              Expanded(child: Container(
                height: 50,
                child: Center(
                  child: AppTextLabels.regularShortText(label: controller.data?[index].target ?? "", color: AppColors.appBlack),
                ),
              )),
              Expanded(child: Column(
                children: [
                  Container(
                    child: Center(
                      child: AppTextLabels.regularShortText(label: controller.data?[index].sale ?? "", color: AppColors.appBlack),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: AppTextLabels.regularShortText(label: "${double.parse(controller.data?[index].sale ?? "") / double.parse(controller.data?[index].target ?? "") * 100 } %", color: AppColors.appBlack),
                    ),
                  ),
                ],
              ))
            ],
          ),
          UiHelper.dashedBoarder(),
        ],
      ),
    );

  }
}
