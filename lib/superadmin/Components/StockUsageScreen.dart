import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/jsonModels/InventoryResponse.dart';
import 'package:accurate/superadmin/Controllers/StockUseHistoryController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockUsageScreen extends StatefulWidget {
  int productId = 0;
  InventoryResponseData item;

  StockUsageScreen({required this.productId, required this.item});

  @override
  State<StockUsageScreen> createState() => _StockUsageScreenState();
}

class _StockUsageScreenState extends State<StockUsageScreen> {
  late StockUseHistoryController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        Get.put(StockUseHistoryController(productID: widget.productId));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<StockUseHistoryController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          children: [
            NavWithBack(),
            SizedBox(
              height: 20,
            ),
            AppTextLabels.boldTextShort(
                label: "Stock Use History", fontSize: 20),
            SizedBox(
              height: 20,
            ),
            Container(),
            inventoryItem(),
            SizedBox(
              height: 10,
            ),
            // SelectableButtonGroup(titles: ["Assigned", "Stock In"], onSelect: handletypeChange),
            SizedBox(
              height: 10,
            ),

            Obx(() => controller.fetchingData.value
                ? UiHelper.loader()
                : Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // Your container properties
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Center(child: AppTextLabels.regularShortText(label: "Sr", color: AppColors.appBlack),),

                          ),
                        Container(
                          height: 50,
                          width: 100,
                          child: Center(child: AppTextLabels.regularShortText(label: "Date", color: AppColors.appBlack),),

                        ),
                        Expanded(child: Container(
                          height: 50,

                          child: Center(child: AppTextLabels.regularShortText(label: "Emp Name", color: AppColors.appBlack),),

                        )),
                        Expanded(child: Container(
                          height: 50,

                          child: Center(child: AppTextLabels.regularShortText(label: "Assigned Qty", color: AppColors.appBlack),),

                        ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.assignedStockHistory?.length,
                      itemBuilder: (context, index) {
                        return purchasedItem(index);
                      },
                    ),
                  ),
                ],
              ),
            ))
          ],
        )));
  }

  Widget inventoryItem() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            UiHelper.loadNetworkImage(
                imageUrl: widget.item.productPicture ?? "", height: 100),
            SizedBox(
              height: 10,
            ),
            AppTextLabels.boldTextShort(
                label: widget.item.productName ?? "", fontSize: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        AppTextLabels.boldTextShort(
                            label: "Total Stock", fontSize: 15),
                        widget.item.stocks?.isNotEmpty == true
                            ? Text(
                                "${widget.item?.stocks?[0].totalQty} item(s)",
                                style: TextStyle(color: AppColors.appGreen),
                              )
                            : Text(
                                "No items in stock",
                                style: TextStyle(color: AppColors.appBlack),
                              ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        AppTextLabels.boldTextShort(
                            label: "In Stock", fontSize: 15),
                        widget.item.stocks?.isNotEmpty == true
                            ? Text(
                                "${widget.item?.stocks?[0].remainingQty} item(s)",
                                style: TextStyle(color: AppColors.appGreen),
                              )
                            : Text(
                                "No items in stock",
                                style: TextStyle(color: AppColors.appBlack),
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }

  Widget purchasedItem(int index){
    return Container(
      // Your container properties
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: Center(child: AppTextLabels.regularShortText(label: "${index + 1}", color: AppColors.appBlack),),

          ),
          Container(
            height: 50,
            width: 100,
            child: Center(child: AppTextLabels.regularShortText(label: UiHelper.formatDate(controller.assignedStockHistory?[index].createdAt ?? ""), color: AppColors.appBlack),),

          ),
          Expanded(child: Container(
            height: 50,

            child: Container(
                margin: EdgeInsets.only(left: 10),
                child: AppTextLabels.regularShortText(label: "${controller.assignedStockHistory?[index].person?.name}", color: AppColors.appBlack)),

          )),
          Expanded(child: Container(
            height: 50,
            child: Center(child: AppTextLabels.regularShortText(label: "${controller.assignedStockHistory?[index].totalQty}", color: AppColors.appBlack),),

          ))
        ],
      ),
    );
  }


  handletypeChange (int index){

  }

}
