

import 'package:flutter/material.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/AllInvoicesController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/MakePaymentScreen.dart';
import '../../jsonModels/AllInvoicesResponse.dart';

class ViewOldInvoicesScreen extends StatefulWidget {
  List<InvoicesData> oldDataArray = [];
  String title = "";
  ViewOldInvoicesScreen({required this.oldDataArray, required this.title});

  @override
  State<ViewOldInvoicesScreen> createState() => _ViewOldInvoicesScreenState();
}

class _ViewOldInvoicesScreenState extends State<ViewOldInvoicesScreen> {



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
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  AppTextLabels.boldTextShort(
                      label: "${widget.title}", fontSize: 20),
                  Expanded(child: Container()),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 20,
            ),
            Flexible(
                child: CustomListView(
                  items: widget.oldDataArray ?? [],
                  itemBuilder: (context, item, index) => invoiceItem(index),
                  onRefresh: ()async{

                  },
                )
            )
          ],
        ),
      ),
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
                    AppTextLabels.regularShortText(label: "Client Name", color: AppColors.appGreen),
                    AppTextLabels.boldTextShort(label: widget.oldDataArray?[index]?.user?.name ?? "", fontSize: 18),
                    SizedBox(height: 10,),
                    AppTextLabels.regularShortText(label: "Sales Man", color: AppColors.appGreen, fontSize: 12),
                    AppTextLabels.boldTextShort(label: widget.oldDataArray?[index]?.user?.name ?? "", fontSize: 18),
                    SizedBox(height: 10,)
                  ],
                ),
              ],
            ),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextLabels.regularShortText(label: "Invoice Id", color: AppColors.appGreen),
                    AppTextLabels.boldTextShort(label: widget.oldDataArray?[index]?.serviceInvoiceId ?? "", fontSize: 18)
                  ],
                ),
                Expanded(child: Container(child: Text(""),)),
                Container(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextLabels.regularShortText(label: "Issue Date", color: AppColors.appGreen),
                      AppTextLabels.boldTextShort(label: UiHelper.formatDate(widget.oldDataArray?[index]?.issuedDate ?? "") , fontSize: 18)
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
                    AppTextLabels.boldTextShort(label: widget.oldDataArray?[index]?.totalAmt ?? "", fontSize: 18)
                  ],
                ),
                Expanded(child: Container(child: Text(""),)),
                Container(
                  width: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextLabels.regularShortText(label: "Paid Amount", color: AppColors.appGreen),
                      AppTextLabels.boldTextShort(label: widget.oldDataArray?[index]?.paidAmt ?? "" , fontSize: 18)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}









