import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Components/StockUsageScreen.dart';
import 'package:accurate/superadmin/Controllers/InventoryController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {

  late InventoryController controller;

  TextEditingController filterController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(InventoryController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<InventoryController>();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Inventory", fontSize: 20),
            SizedBox(height: 20,),
            AppInput(title: "Filter By Product Name", controller: filterController, onChange: (value){
              controller.filter(value);
            },),
            Obx(()=>controller.fetchingData.value ? UiHelper.loader() :
            Expanded(child: CustomListView(
              items: controller.data ?? [],
              itemBuilder: (context, item, index)=> inventoryItem(index),
              onItemTap: (context, item, index){
                UiHelper.navigateToNextScreen(context, StockUsageScreen( item: item, productId: controller.data?[index].id ?? 0));
              },
              onRefresh: ()async{
                controller.getInventory();
              },
            )
            ))
          ],
        ),
      ),
    );
  }


  Widget inventoryItem(int index){
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(child: Column(
          children: [
            SizedBox(height: 10,),
            UiHelper.loadNetworkImage(imageUrl: controller?.data?[index].productPicture ?? "", height: 200),
            SizedBox(height: 10,),
            AppTextLabels.boldTextShort(label: controller.data?[index].productName ?? "", fontSize: 20),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        AppTextLabels.boldTextShort(label: "Total Stock", fontSize: 15),
                        controller?.data?[index]?.stocks?.isNotEmpty == true
                            ? Text(
                          "${controller?.data?[index]?.stocks?[0].totalQty} item(s)",
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
                        AppTextLabels.boldTextShort(label: "In Stock", fontSize: 15),
                        controller?.data?[index]?.stocks?.isNotEmpty == true
                            ? Text(
                          "${controller?.data?[index]?.stocks?[0].remainingQty} item(s)",
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
}
