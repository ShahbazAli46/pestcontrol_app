import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/Navbar.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/ApprovePaymentConroller.dart';

class ApprovePaymentScreen extends StatefulWidget {
  const ApprovePaymentScreen({Key? key}) : super(key: key);

  @override
  State<ApprovePaymentScreen> createState() => _ApprovePaymentScreenState();
}

class _ApprovePaymentScreenState extends State<ApprovePaymentScreen> {


  ApprovePaymentController controller = Get.put(ApprovePaymentController());            
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(height: 20,),
            AppTextLabels.boldTextShort(label: "Approve Payment", fontSize: 20),
            SizedBox(height: 20,),
            Obx(()=>controller.fetchingData.value ? UiHelper.loader() : Expanded(child: Column(
              children: [
                Expanded(child: CustomListView(
                  // proxy
                  //
                  items: controller.paymentsResponse.data ??  [],
                  itemBuilder: (context, item, index)=>paymentItem(index),
                  onRefresh: ()async{
                    controller.getData();
                  },
                ))
              ],
            )))
            
          ],
        ),
      ),
    );
  }

  Widget paymentItem( int index) {
    return GestureDetector(
      onTap: (){
        // UiHelper.navigateToNextScreen(context, SingleSupplierScreen(id: controller.list?[index].id ?? 0 ,companyName: controller.list?[index].companyName ?? "",));
      },
      child: Card(
        color: Colors.white, // Explicitly set the card color to white
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              UiHelper.buildRow('Sr.', "${index + 1}"),
              UiHelper.buildRow('Date', "${UiHelper.formatDateToMonthYear(controller.paymentsResponse.data?[index].createdAt ?? "")}"),
              UiHelper.buildRow('Client Name', "${controller.paymentsResponse.data?[index].clientUser?.name ?? ""}"),
              UiHelper.buildRow('Received By', "${controller.paymentsResponse.data?[index].employeeUser?.name ?? ""}"),
              UiHelper.buildRow('Amount', "${UiHelper.formatUAECurrency(double.parse(controller.paymentsResponse.data?[index].paidAmt ?? ""))}"),
              SizedBox(height: 10,),
              GreenButton(title: "Approve ", sendingData: (controller.approvingPayment.value && index == controller.approvingIndex).obs , onTap: (){
                controller.approvePayment(index, controller.paymentsResponse.data?[index].id ?? 0);
              })
            ],
          ),
        ),
      ),
    );
  }
}
