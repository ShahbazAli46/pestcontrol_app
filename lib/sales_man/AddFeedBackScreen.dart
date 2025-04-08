import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/main.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/AppImages.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/generic/AppMultilineInput.dart';
import '../components/generic/GreenButton.dart';
import 'controllers/FeedbackController.dart';

class AddFeedBackScreen extends StatefulWidget {
  String reportID;
  AddFeedBackScreen({required this.reportID});

  @override
  State<AddFeedBackScreen> createState() => _AddFeedBackScreenState();
}

class _AddFeedBackScreenState extends State<AddFeedBackScreen> {
  TextEditingController feedbackTextController = TextEditingController();
  FeedbackController feedbackController = Get.put(FeedbackController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 80, width: double.infinity,),
          Image.asset(
              height: 150,
              AppImages.success),
          SizedBox(height: 50,),
          AppTextLabels.boldTextShort(label: "Report Created", fontSize: 20),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                AppMultilineInput(
                  title: "Feedback (office use only) ",
                  controller: feedbackTextController,
                ),
                SizedBox(height: 100,),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 20, bottom: 20),
                    child: GreenButton(
                      title: "Submit Feedback",
                      sendingData: feedbackController.sendingData,
                      onTap: makeRequest,
                    )
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  makeRequest(){
      if (feedbackTextController.text.isEmpty){
       AlertService.showAlertWithCancelButton("Alert", "Are you sure, you want to submit empty feedback", onOkPressed: (){
         Get.offAll(UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0));
       });
      } else{
        feedbackController.reportId = widget.reportID;
        feedbackController.sendFeedback(feedbackTextController.text);
      }

  }
}
