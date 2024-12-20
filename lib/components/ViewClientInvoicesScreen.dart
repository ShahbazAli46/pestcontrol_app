import 'package:accurate/components/Conrollers/InvoicesController.dart';
import 'package:accurate/components/Conrollers/ViewAllClientsController.dart';
import 'package:accurate/components/MakePaymentScreen.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/utils/Constants.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewClientInvoicesScreen extends StatefulWidget {
  const ViewClientInvoicesScreen({Key? key}) : super(key: key);

  @override
  State<ViewClientInvoicesScreen> createState() => _ViewClientInvoicesScreenState();
}

class _ViewClientInvoicesScreenState extends State<ViewClientInvoicesScreen> {
  ViewAllClientsController? clientsController;
  late InvoicesController invoicesController;


  @override
  Widget build(BuildContext context) {
    clientsController = Get.find(tag: Constants.allClients);
    int clientId = clientsController?.selectedClient?.id ?? 0;
    invoicesController = Get.put(InvoicesController());
    invoicesController.clientId = clientId;
    invoicesController.getInvoices();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            NavWithBack(),
            SizedBox(width: double.infinity, height: 20,),
            AppTextLabels.boldTextShort(label: "All Invoices ", fontSize: 20),
            SizedBox(width: double.infinity, height: 10,),
            clientCard(),
            SizedBox(width: double.infinity, height: 20,),
            AppTextLabels.boldTextShort(label: "Select Invoice", fontSize: 20),
            SizedBox(width: double.infinity, height: 10,),
            Obx(()=> invoicesController.fetchingData.value ? UiHelper.loader() : Expanded(
              child: CustomListView(
                items: invoicesController.unpaidInvoices ?? [],
                itemBuilder: (context, item, index) => invoiceItem(index),
              )
            ))
          ],
        ),
      ),
    );
  }
  Widget clientCard() {
    return GestureDetector(
      onTap: () {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              AppTextLabels.regularShortText(
                  label: "Client Name", color: AppColors.appGreen),
              AppTextLabels.boldText(
                  label: clientsController?.selectedClient?.name ?? "",
                  color: AppColors.appBlack,
                  fontSize: 20),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 20,
                    color: AppColors.appBlack,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.regularText(
                      label: clientsController?.selectedClient?.email ??
                          "",
                      color: AppColors.appBlack)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 20,
                    color: AppColors.appBlack,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.regularText(
                      label: clientsController
                          ?.selectedClient?.client?.phoneNumber ??
                          "",
                      color: AppColors.appBlack)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 20,
                    color: AppColors.appBlack,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.regularText(
                      label: "Reference By",
                      color: AppColors.appBlack,
                      fontSize: 10)
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  AppTextLabels.regularText(
                      label: clientsController?.selectedClient?.client
                          ?.referencable?.name ??
                          "",
                      color: AppColors.appBlack,
                      fontSize: 14)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 20,
                    color: AppColors.appBlack,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AppTextLabels.regularText(
                      label: "Balance: ",
                      color: AppColors.appBlack,
                      fontSize: 10)
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  AppTextLabels.regularText(
                      label: clientsController
                          ?.selectedClient?.current_balance ??
                          "",
                      color: AppColors.appBlack,
                      fontSize: 14)
                ],
              ),
            ],
          )),
    );
  }
  Widget invoiceItem(int index){
    return Container(
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
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextLabels.regularShortText(label: "Invoice Id", color: AppColors.appGreen),
                    AppTextLabels.boldTextShort(label: invoicesController?.unpaidInvoices?[index]?.serviceInvoiceId ?? "", fontSize: 18)
                  ],
                ),
                Expanded(child: Container(child: Text(""),)),
                Container(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextLabels.regularShortText(label: "Issue Date", color: AppColors.appGreen),
                      AppTextLabels.boldTextShort(label: UiHelper.formatDate(invoicesController?.unpaidInvoices?[index]?.issuedDate ?? "") , fontSize: 18)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextLabels.regularShortText(label: "Total Amount", color: AppColors.appGreen),
                    AppTextLabels.boldTextShort(label: invoicesController?.unpaidInvoices?[index]?.totalAmt ?? "", fontSize: 18)
                  ],
                ),
                Expanded(child: Container(child: Text(""),)),
                Container(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextLabels.regularShortText(label: "Paid Amount", color: AppColors.appGreen),
                      AppTextLabels.boldTextShort(label: invoicesController?.unpaidInvoices?[index]?.paidAmt ?? "" , fontSize: 18)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            GreenButton(title: "Receive Amount", sendingData: false.obs, onTap: (){
              UiHelper.navigateToNextScreen(context, MakePaymentScreen(item: invoicesController.unpaidInvoices![index]));
            })
          ],
        ),
      ),
    );
  }
}
