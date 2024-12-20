import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/PurchaseOrderDetailsController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseOrderDetailsScreen extends StatefulWidget {
  int id;

  PurchaseOrderDetailsScreen({required this.id});

  @override
  State<PurchaseOrderDetailsScreen> createState() =>
      _PurchaseOrderDetailsScreenState();
}

class _PurchaseOrderDetailsScreenState
    extends State<PurchaseOrderDetailsScreen> {
  late PurchaseOrderDetailsController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(PurchaseOrderDetailsController(id: widget.id));
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
                  label: "Purchase Order Details", fontSize: 20),
              SizedBox(
                height: 20,
              ),
              Obx(() => controller.fetchingData.value
                  ? UiHelper.loader()
                  : Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  child: Center(child: AppTextLabels.regularShortText(label: "Sr", color: AppColors.appBlack),),
                                ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      AppTextLabels.regularShortText(label: "Product", color: AppColors.appBlack),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 70,
                                child: Row(
                                  children: [
                                    AppTextLabels.regularShortText(label: "Quantity", color: AppColors.appBlack),
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AppTextLabels.regularShortText(label: "Price", color: AppColors.appBlack),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: CustomListView(
                            items: controller.detailsResponse.data?.orderDetails ?? [],
                              itemBuilder: (context, item, index)=> purchaseItem(index),
                          )),
                        SizedBox(height: 10,),
                        UiHelper.dashedBoarder(),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppTextLabels.boldTextShort(label: "Sub Total", fontSize: 12, color: AppColors.appBlack),
                            AppTextLabels.boldTextShort(label: "${UiHelper.formatUAECurrency(double.parse(controller.detailsResponse.data?.subTotal ?? "0.0"))}", fontSize: 12, color: AppColors.appBlack),
                          ],
                        ),
                        SizedBox(height: 10,),
                        UiHelper.dashedBoarder(),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppTextLabels.boldTextShort(label: "Total VAT", fontSize: 12, color: AppColors.appBlack),
                            AppTextLabels.boldTextShort(label: "${UiHelper.formatUAECurrency(controller.totalVat)}", fontSize: 12, color: AppColors.appBlack),
                          ],
                        ),
                        SizedBox(height: 10,),


                        UiHelper.dashedBoarder(),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppTextLabels.boldTextShort(label: "Total", fontSize: 20, color: AppColors.appGreen),
                            AppTextLabels.boldTextShort(label: "${UiHelper.formatUAECurrency(double.parse(controller.detailsResponse.data?.grandTotal ?? "0.0"))}", fontSize: 20, color: AppColors.appGreen),
                          ],
                        ),
                        SizedBox(height: 10,),
                        UiHelper.dashedBoarder(),

                      ],
                    ),
                  ))
            ],
          ),
        ));
  }

  Widget purchaseItem(int index){
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: Center(child: AppTextLabels.regularShortText(label: "${index + 1}", color: AppColors.appBlack),),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: Row(
                children: [
                  AppTextLabels.regularShortText(label: "${controller.detailsResponse.data?.orderDetails?[index].product?.productName}", color: AppColors.appBlack),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: 70,
            child: Row(
              children: [
                AppTextLabels.regularShortText(label: "${controller.detailsResponse.data?.orderDetails?[index].quantity}", color: AppColors.appBlack),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppTextLabels.regularShortText(label: "${controller.detailsResponse.data?.orderDetails?[index].price}", color: AppColors.appBlack),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
