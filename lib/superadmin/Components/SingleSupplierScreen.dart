import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Components/AddSupplierBankScreen.dart';
import 'package:accurate/superadmin/Components/PurchaseOrderDetailsScreen.dart';
import 'package:accurate/superadmin/Controllers/SingleSupplierController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SingleSupplierScreen extends StatefulWidget {
  int id;
  String companyName;
  SingleSupplierScreen({ required  this.id, required this.companyName });

  @override
  State<SingleSupplierScreen> createState() => _SingleSupplierScreenState();
}

class _SingleSupplierScreenState extends State<SingleSupplierScreen> {


  late SingleSupplierController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SingleSupplierController(id: widget.id), tag: "suppliers");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<SingleSupplierController>(tag: "suppliers");
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
      children: [
        NavWithBack(),
        SizedBox(height: 20,),
        AppTextLabels.boldTextShort(label: "${widget.companyName}", fontSize: 20),
        SizedBox(height: 20,),
        SelectableButtonGroup(titles: ["Info", "Ledger"], onSelect: handleTypeChange),
        Obx(()=>controller.fetchingData.value ? UiHelper.loader() : Obx(()=> controller.type.value== 0 ? infoView():ledgerView()))


      ],
    )));
  }

  handleTypeChange(int index){
      controller.changeType(index);
  }
  Widget bankItem(int index){
    return Card(
      color: Colors.white, // Explicitly set the card color to white
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildRow('Bank Name', "${controller.infoResponse?.data?.bankInfos?[index].bankName}"),
            _buildRow('IBAN', "${controller.infoResponse?.data?.bankInfos?[index].iban}"),
            _buildRow('Account Number', "${controller.infoResponse?.data?.bankInfos?[index].accountNumber}"),
            _buildRow('Address', "${controller.infoResponse?.data?.bankInfos?[index].address}"),
          ],
        ),
      ),
    );;
  }

  Widget supplierItem() {
    return Card(
      color: Colors.white, // Explicitly set the card color to white
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Center(child: AppTextLabels.boldTextShort(label: "${controller.infoResponse?.data?.companyName ?? ""}", fontSize: 20, color: AppColors.appBlack),),
            ),
            _buildRow('Name', "${controller.infoResponse?.data?.supplierName}"),
            _buildRow('Email', "${controller.infoResponse?.data?.email}"),
            _buildRow('Balance', "${UiHelper.formatUAECurrency(double.parse(controller.infoResponse?.data?.balance ?? "0.0"))}"),
          ],
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
                        color: areaObject == "Purchase Order" ? AppColors.appGreen: AppColors.appBlack,
                        textAlign: TextAlign.center)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoView (){
    return Expanded(
      child: Column(
        children: [
          supplierItem(),
          SizedBox(height: 10,),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.appGreen,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: AppTextLabels.boldTextShort(label: "Banks", fontSize: 20, color: Colors.white)),
                GestureDetector(
                    onTap: (){
                      UiHelper.navigateToNextScreenGetX(AddSupplierBankScreen(supplierId: widget.id, supplierCompanyName: widget.companyName,));
                    },
                    child: Icon(Icons.add, color: Colors.white,))

              ],
            ),

          ),
          Expanded(child: CustomListView(items: controller.infoResponse.data?.bankInfos ?? [], itemBuilder: (context, item, index)=>bankItem(index)))
        ],
      ),
    );
  }

  Widget ledgerView(){
    return Expanded(child: CustomListView(
      items: controller.ledgers.data ?? [],
      itemBuilder: (context, item, index)=>ledgerItem(index),
    ));
  }

  Widget ledgerItem( int index) {
    return GestureDetector(
      onTap: (){
      if (controller.ledgers.data?[index].description == "Purchase Order"){
            UiHelper.navigateToNextScreenGetX(PurchaseOrderDetailsScreen(id: controller.ledgers.data?[index].purchaseOrder?.id ?? 0));
      }
      },
      child: Card(
        color: Colors.white, // Explicitly set the card color to white
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildRow('Date', "${UiHelper.formatDate(controller.ledgers.data?[index].createdAt ?? "")}"),
              _buildRow('Description', "${controller.ledgers.data?[index].description ?? ""}"),
              _buildRow('Credit', "${controller.ledgers.data?[index].crAmt ?? ""}"),
              _buildRow('Debit', "${controller.ledgers.data?[index].drAmt ?? ""}"),
              _buildRow('Balance', "${controller.ledgers.data?[index].cashBalance ?? ""}"),
            ],
          ),
        ),
      ),
    );
  }
}
