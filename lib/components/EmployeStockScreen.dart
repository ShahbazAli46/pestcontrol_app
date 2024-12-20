import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DashedSeparatorPainter.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/sales_man/UsedStockItemHistory.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UpcomignJobs/UpcomingJobsController.dart';

class EmployeeStockScreen extends StatefulWidget {
  const EmployeeStockScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeStockScreen> createState() => _EmployeeStockScreenState();
}

class _EmployeeStockScreenState extends State<EmployeeStockScreen> {
  UpcomingJobsController? controller;
  @override
  void dispose() {
    Get.delete<UpcomingJobsController>();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    controller = Get.put(UpcomingJobsController(), tag:"emp", permanent: false);
    controller?.fetchJob();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Stock", color: AppColors.appBlack, fontSize: 20),
            SizedBox(height: 20,),
            Obx(()=> controller?.fetchingData.value ?? false ? UiHelper.loader() : Expanded(
              child: CustomListView(
                items: controller?.stocks ?? [],
                itemBuilder: (context, item, index)=> listItem(index),
                onRefresh: () async {
                  controller?.fetchJob();
                },
              )
            ))
          ],
        ),
      ),
    );
  }
  Widget listItem (index) {
    return GestureDetector(
      onTap: (){
        UiHelper.navigateToNextScreenGetX(UsedStockItemHistory(productId: controller?.stocks?[index].productId ?? 0,));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
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
        child: Row(
          children: [
            SizedBox(width: 10,),
            Container(
                height: 100,
                width: 100,
                child: UiHelper.loadNetworkImage(imageUrl: controller?.stocks?[index].product?.productPicture ?? "", height: 100, width: 100)),
            SizedBox(width: 20,),
            Expanded( // Wrap Row with Expanded
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextLabels.regularShortText(label: "Product Name", color: AppColors.appGreen,fontSize: 12),
                  AppTextLabels.boldTextShort(label: controller?.stocks?[index].product?.productName ?? "", fontSize: 18),
                  SizedBox(height: 5,),
                  UiHelper.dashedBoarder(),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Column(
                        children: [
                          AppTextLabels.regularShortText(label: "Total Stock", color: AppColors.appGreen,fontSize: 12),
                          AppTextLabels.boldTextShort(label: controller?.stocks?[index].totalQty ?? "", fontSize: 18),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          AppTextLabels.regularShortText(label: "Stock In ${controller?.stocks?[index].product?.unit ?? 0 }'s", color: AppColors.appGreen,fontSize: 12),
                          AppTextLabels.boldTextShort(label: "${double.parse( controller?.stocks?[index].remainingQty ?? "0.0" ) * double.parse( controller?.stocks?[index].product?.per_item_qty ?? "0.0" )} ${controller?.stocks?[index].product?.unit ?? 0 }" ,  fontSize: 18),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AppTextLabels.regularShortText(label: "Stock in Bottles", color: AppColors.appGreen,fontSize: 12),
                      AppTextLabels.boldTextShort(label: "${double.parse( controller?.stocks?[index].remainingQty ?? "0.0" )}",  fontSize: 18),
                    ],
                  ),
                ],
              ),
            ),
            Align( // Use Align to position icon at right center
              alignment: Alignment.centerRight,
              child: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
