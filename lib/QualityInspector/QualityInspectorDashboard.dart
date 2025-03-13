import 'package:accurate/QualityInspector/AddInpespectionVisit.dart';
import 'package:accurate/QualityInspector/InspectorVisitsScreen.dart';
import 'package:accurate/QualityInspector/SingleClientJobsScreen.dart';
import 'package:accurate/components/ViewAllClients.dart';
import 'package:accurate/components/generic/Navbar.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/main.dart';
import 'package:accurate/user/UserProfile/UserProfileScreen.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/AppImages.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';

class QualityInspectorDashboard extends StatefulWidget {

  @override
  State<QualityInspectorDashboard> createState() => _QualityInspectorDashboardState();
}

class _QualityInspectorDashboardState extends State<QualityInspectorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
          children: [
            Navbar(),
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  AppTextLabels.regularShortText(label: "Welcome", color: AppColors.appBlack, fontSize: 20) ,
                  AppTextLabels.boldTextShort(label: userObj?.data?.name ?? "", fontSize: 20),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              child: GestureDetector(
                                onTap: (){
                                  UiHelper.navigateToNextScreen(context, ViewAllClients(type: ClientScreenViewTypes.forPayment,));
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.appGreen,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Image.asset(AppImages.payment, height: 50,),
                                      SizedBox(height: 10,),
                                      AppTextLabels.boldTextShort(label: "Receive Payment", color: AppColors.appGreen, fontSize: 15)
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                              child: GestureDetector(
                                onTap: (){
                                  UiHelper.navigateToNextScreen(context, AddInspectionVisit());
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.appGreen,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Image.asset(AppImages.inspection, height: 50,),
                                      SizedBox(height: 10,),
                                      AppTextLabels.boldTextShort(label: "Add Inspection Visit", color: AppColors.appGreen, fontSize: 15)
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              child: GestureDetector(
                                onTap: (){
                                  UiHelper.navigateToNextScreen(context, InspectorVisitsScreen());
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.appGreen,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Image.asset(AppImages.inspectionVisits, height: 50,),
                                      SizedBox(height: 10,),
                                      AppTextLabels.boldTextShort(label: "View Visits", color: AppColors.appGreen, fontSize: 15)
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                              child: GestureDetector(
                                onTap: (){
                                  UiHelper.navigateToNextScreen(context, SingleClientJobsScreen());
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.appGreen,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Image.asset(AppImages.jobs, height: 50,),
                                      SizedBox(height: 10,),
                                      AppTextLabels.boldTextShort(label: "View Client Jobs", color: AppColors.appGreen, fontSize: 15)
                                    ],
                                  ),
                                ),
                              )),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreen(context, UserProfileScreen());
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.appGreen,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Image.asset(AppImages.profile, height: 50,),
                                SizedBox(height: 10,),
                                AppTextLabels.boldTextShort(label: "View Profile", color: AppColors.appGreen, fontSize: 15)
                              ],
                            ),
                          ),
                        )),
                        SizedBox(width: 10,),
                        Expanded(child: GestureDetector(
                          onTap: (){
                            AlertService.showAlertWithCancelButton("Alert", "Are Sure you want to logout?", onOkPressed: (){
                              UiHelper.handleLogout();
                            });

                            // UiHelper.navigateToNextScreen(context, HistoryScreen());
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.appGreen,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Image.asset(AppImages.logout, height: 50,),
                                SizedBox(height: 10,),
                                AppTextLabels.boldTextShort(label: "Logout", color: AppColors.appGreen, fontSize: 15)
                              ],
                            ),
                          ),
                        )),

                      ],
                    ),
                  ),




                ],
              ),
            ))
          ],
        )));
  }
}
