import 'package:accurate/components/generic/AppDatePicker.dart';
import 'package:accurate/components/generic/CustomListView.dart';
import 'package:accurate/components/generic/DateFilters.dart';
import 'package:accurate/components/generic/GreenButton.dart';
import 'package:accurate/components/generic/SelectableButtonGroup.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/components/generic/navWithBack.dart';
import 'package:accurate/superadmin/Controllers/QuotesController.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/appColors.dart';

class QuoteScreen extends StatefulWidget {
  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late QuotesController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(QuotesController());
  }

  @override
  void dispose() {
    Get.delete<QuotesController>();
    super.dispose();
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
            AppTextLabels.boldTextShort(label: "Sent Quotes", fontSize: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    child: AppTextLabels.regularText(
                        label: "Select Date",
                        color: Colors.black54,
                        fontSize: 14),
                  )),
                  DateFilters(onOptionChange: onOptionChange)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SelectableButtonGroup(titles: ["Approved", "Pending"], onSelect: buttonTypeChanged),
            Container(
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Center(child: AppTextLabels.regularShortText(label: "Sr", color: AppColors.appBlack),),
                  ),
                  Expanded(child: Container(
                    height: 50,
                    child: Center(child: AppTextLabels.regularShortText(label: "Client Name", color: AppColors.appBlack),),
                  )),
                  Expanded(child: Container(
                    height: 50,
                    child: Center(child: AppTextLabels.regularShortText(label: "Amount", color: AppColors.appBlack),),
                  )),

                  Expanded(child: Container(
                    height: 50,
                    child: Center(child: AppTextLabels.regularShortText(label: "Reference", color: AppColors.appBlack),),
                  )),
                  Container(
                    height: 50,
                    width: 50,
                    child: Center(child: AppTextLabels.regularShortText(label: "Status", color: AppColors.appBlack),),
                  ),

                  Container(
                    height: 50,
                    width: 30,
                    child: Center(child: AppTextLabels.regularShortText(label: "", color: AppColors.appGreen, fontSize: 10)),
                  ),

                  SizedBox(width: 10,)
                ],
              ),
            ),

            Obx(() => controller.fetchingData.value
                ? UiHelper.loader()
                : Expanded(
                    child: CustomListView(
                      items: controller.list ?? [],
                      itemBuilder: (context, item, index)=> dataItem(index),
                      ),
                    ))
          ],
        )));
  }

  onOptionChange(type, start, end) {
    if (end != null) {
      String startDate = DateFormat('yyyy-MM-dd').format(start);
      String endDate = DateFormat('yyyy-MM-dd').format(end);
      controller.fetchQuotes(startDate: startDate, endDate: endDate);
    }
  }


  buttonTypeChanged(index){
    controller.changeType(index);
  }

  Widget dataItem(index) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(

                width: 50,
                child: Center(child: AppTextLabels.regularShortText(label: "${index + 1}", color: AppColors.appBlack),),
              ),
              Expanded(child: Container(
                child: Row(
                  children: [
                    AppTextLabels.regularText(label: "${controller.list?[index].user?.name}", color: AppColors.appBlack),
                  ],
                ),
              )),


              Expanded(child: Container(

                child: Center(child: AppTextLabels.regularShortText(label: "${controller.list?[index].subTotal}", color: AppColors.appBlack),),
              )),

              Expanded(child: Container(

                child: Center(child: AppTextLabels.regularShortText(label: "${controller.list?[index].user?.client?.referencable?.name }", color: AppColors.appBlack),),
              )),
              Container(
                height: 50,
                width: 50,
                child: Center(child: AppTextLabels.regularShortText(label: "${controller.list?[index].isContracted == 0 ? "Pending":"Approved"}", color: controller.list?[index].isContracted == 0 ? AppColors.appBlack: AppColors.appGreen, fontSize: 10),),
              ),
              GestureDetector(
                onTap: () async {
                  final url = 'http://pestcontrol.worldcitizenconsultants.com/quotePdf/?id=58';
                  if (await canLaunch(url)) {
                  await launch(
                  url, forceSafariVC: false, forceWebView: false,
                  );
                  } else {
                  throw 'Could not launch $url';
                  }
                },
                child: Container(
                  height: 50,
                  width: 30,
                  child: Center(child: AppTextLabels.regularShortText(label: "View", color: AppColors.appGreen, fontSize: 10)),
                ),
              ),
              SizedBox(width: 10,)
            ],
          ),
          UiHelper.dashedBoarder()
        ],
      ),
    );
  }
}
