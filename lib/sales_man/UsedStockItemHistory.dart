
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/generic/CustomListView.dart';
import '../utils/appColors.dart';
import 'controllers/UsedItemHistoryController.dart';


class UsedStockItemHistory extends StatefulWidget {
    int productId;
    UsedStockItemHistory({ required this.productId });
  @override
  State<UsedStockItemHistory> createState() => _UsedStockItemHistoryState();
}

class _UsedStockItemHistoryState extends State<UsedStockItemHistory> {

  UsedItemHistoryController? controller = Get.put(UsedItemHistoryController());


  @override
  Widget build(BuildContext context) {
    controller?.stockItemId = widget.productId;
    controller?.getHistory();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Used Stock ", color: AppColors.appBlack, fontSize: 20),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Center(child: AppTextLabels.regularShortText(label: "Sr", color: AppColors.appBlack),),
                ),
                Expanded(child: Container(
                  height: 50,
                  child: Center(child: AppTextLabels.regularShortText(label: "Date", color: AppColors.appBlack)),
                )),

                Expanded(
                  child: Container(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft, // Left alignment
                      child: AppTextLabels.regularShortText(
                        label:  "Client Name",
                        color: AppColors.appBlack,
                      ),
                    ),
                  ),
                ),


                Expanded(child: Container(
                  height: 50,
                  child: Center(child: AppTextLabels.regularShortText(label: "Quantity", color: AppColors.appBlack)),
                )),
              ],
            ),
            UiHelper.dashedBoarder(),
            Obx(()=>controller?.fetchingData?.value ?? false ? UiHelper.loader() :
            Expanded(
              child: CustomListView(
                items: controller?.usedStock ?? [],
                itemBuilder: (context, client, index) => listItem(index),  // Updated to pass both client and index
              ),
            ),)
          ],
        )));
  }

  Widget listItem (index){
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: Center(child: AppTextLabels.regularShortText(label: "${index + 1}", color: AppColors.appBlack),),
            ),
            Expanded(child: Container(
              height: 50,
              child: Center(child: AppTextLabels.regularShortText(label: UiHelper.formatDate(controller?.usedStock?[index].job?.jobDate ?? ""), color: AppColors.appBlack)),
            )),

            Expanded(
              child: Container(
                height: 50,
                child: Align(
                  alignment: Alignment.centerLeft, // Left alignment
                  child: AppTextLabels.regularShortText(
                    label: controller?.usedStock?[index]?.job?.user?.client?.firmName ?? "",
                    color: AppColors.appBlack,
                  ),
                ),
              ),
            ),

            Expanded(child: Container(
              height: 50,
              child: Center(child: AppTextLabels.regularShortText(label: "${controller?.usedStock?[index]?.qty}", color: AppColors.appBlack)),
            )),
          ],
        ),
        UiHelper.dashedBoarder()
      ],
    );
  }
}

