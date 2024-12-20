import 'package:accurate/AccountantDashboard/Components/AddPaymenttoSupplierScreen.dart';
import 'package:accurate/AccountantDashboard/Components/AddPurchaseOrderScreen.dart';
import 'package:accurate/components/generic/AppInput.dart';
import 'package:accurate/components/generic/AppSearchInput.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/AllSupplierController.dart';
import 'package:accurate/superadmin/Components/SingleSupplierScreen.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';


class ViewAllSuppliers extends StatefulWidget {
  const ViewAllSuppliers({Key? key}) : super(key: key);

  @override
  State<ViewAllSuppliers> createState() => _ViewAllSuppliersState();
}

class _ViewAllSuppliersState extends State<ViewAllSuppliers> {

  AllSupplierController controller = Get.put(AllSupplierController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<AllSupplierController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
      children: [
        NavWithBack(),
        SizedBox(height: 20,),
        AppSearchInput(title: "Search", controller: controller.filterTextController, onChanged: controller.onChangeInFilter,),
        AppTextLabels.boldTextShort(label: "Suppliers", fontSize: 20),
        SizedBox(height: 10,),
        AppTextLabels.regularShortText(label: "Tap to View More details", color: AppColors.appGreen, fontSize: 8),
        SizedBox(height: 20,),
        Obx(()=>controller.fetchingData.value ? UiHelper.loader() : Expanded(
          child: Column(
            children: [
              Expanded(child: CustomListView(items: controller.list ?? [],
                  onRefresh: ()async{
                    controller.getData();
                  },
                  itemBuilder: (context, ite, index)=>supplierItem(index)))
            ],
          ),
        ))
      ],
    )));
  }

  Widget supplierItem( int index) {
    return GestureDetector(
      onTap: (){
        UiHelper.navigateToNextScreen(context, SingleSupplierScreen(id: controller.list?[index].id ?? 0 ,companyName: controller.list?[index].companyName ?? "",));
      },
      child: Card(
        color: Colors.white, // Explicitly set the card color to white
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.appGreen,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(child: AppTextLabels.boldTextShort(label: "${controller.list?[index].companyName}", fontSize: 20, color: Colors.white),),

              ),
              _buildRow('Sr.', "${index + 1}"),
              _buildRow('Name', "${controller.list?[index].supplierName}"),

              _buildRow('Email', "${controller.list?[index].email}"),
              _buildRow('Tag', "${controller.list?[index].tag}"),
              _buildRow('Balance', "${UiHelper.formatUAECurrency(double.parse(controller.list?[index]?.balance ?? "0.0"))}"),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, AddPaymentToSupplierScreen(supplierID: controller.list?[index]?.id ?? 0, supplierName: "${controller.list?[index].companyName}", refreshData  : refreshData));
                      },
                      child: Container(

                        child: AppTextLabels.underlinedTextShort(label: "Add Payment", color: AppColors.appGreen),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, AddPurchaseOrderScreen(supplierID: controller.list?[index]?.id ?? 0, supplierName: "${controller.list?[index].companyName}", refreshData  : refreshData));
                      },
                      child: Container(
                        child: AppTextLabels.underlinedTextShort(label: "Add Purchase", color: AppColors.appGreen),
                      ),
                    )
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
  Widget _buildRow(String label, String areaObject) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Color(0xffF9FAFB)),
              child: Center(
                  child: AppTextLabels.regularShortText(
                      label: label,
                      color: AppColors.appBlack,
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: areaObject));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Copied to clipboard')),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(),
                child: Center(
                    child: AppTextLabels.regularShortText(
                        label: areaObject,
                        color: AppColors.appBlack,
                        textAlign: TextAlign.center)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  refreshData(){
      controller.getData();
  }
}
