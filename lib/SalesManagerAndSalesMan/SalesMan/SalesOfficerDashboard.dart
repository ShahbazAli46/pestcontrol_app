import 'package:accurate/SalesManagerAndSalesMan/SalesMan/AddSalesOfficeVisitScreen.dart';
import 'package:accurate/SalesManagerAndSalesMan/SalesMan/Controlers/SalesOfficerDashboardController.dart';
import 'package:accurate/SalesManagerAndSalesMan/SalesMan/SalesManJobsScreen.dart';
import 'package:accurate/SalesManagerAndSalesMan/SalesMan/SalesmanIncomeScreen.dart';
import 'package:accurate/SalesManagerAndSalesMan/SalesMan/ViewFollowupsScreen.dart';
import 'package:accurate/SalesManagerAndSalesMan/SalesMan/ViewVisitsScreen.dart';
import 'package:accurate/components/ViewAllClients.dart';
import 'package:accurate/components/generic/MonthPicker.dart';
import 'package:accurate/components/generic/Navbar.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/superadmin/Components/AddClientScreen.dart';
import 'package:accurate/superadmin/Components/CreateQuoteScreen.dart';
import 'package:accurate/superadmin/Components/QuotesScreen.dart';
import 'package:accurate/user/UserProfile/UserProfileScreen.dart';
import 'package:accurate/user/login.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/AppImages.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../utils/TextStyle.dart';

class SalesOfficerDashboard extends StatefulWidget {


  @override
  State<SalesOfficerDashboard> createState() => _SalesOfficerDashboardState();
}

class _SalesOfficerDashboardState extends State<SalesOfficerDashboard> {


  late SalesOfficerDashboardController controller;



  @override
  void initState() {
    super.initState();
    controller = Get.put(SalesOfficerDashboardController());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: Column(
      children: [
        Container(),
        Navbar(),
        SizedBox(height: 10,),
        AppTextLabels.regularShortText(label: "Welcome", color: AppColors.appBlack, fontSize: 20) ,
        AppTextLabels.boldTextShort(label: userObj?.data?.name ?? "", fontSize: 20),
        SizedBox(height: 20,),
        MonthPicker(onMonthChanged: controller.onMonthChanged),
        Expanded(
          child: SingleChildScrollView(child: Column(
            children: [

              Obx(()=> controller.fetchingData.value ? Column(
                children: [
                  SizedBox(height: 20,),
                  CircularProgressIndicator(),
                  SizedBox(height: 20,),
                ],
              ) : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: Container(
                          padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          child: Column(
                            children: [
                              AppTextLabels.boldTextShort(label: "Target", fontSize: 20, color: AppColors.appGreen),
                              AppTextLabels.regularShortText(label: controller.targets.contractTarget ?? "", color: AppColors.appBlack, fontSize: 20)
                            ],
                          ),
                        )),
                        SizedBox(width: 8,),
                        Expanded(child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              AppTextLabels.boldTextShort(label: "Achieved", fontSize: 20, color: AppColors.appGreen),
                              AppTextLabels.regularShortText(label: controller.targets.achievedTarget ?? "", color: AppColors.appBlack, fontSize: 20)
                            ],
                          ),
                        )),
                        SizedBox(width: 8,),
                        Expanded(child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              AppTextLabels.boldTextShort(label: "%age", fontSize: 20, color: AppColors.appGreen),
                              AppTextLabels.regularShortText(
                                label: "${(double.parse(controller.targets.achievedTarget ?? '') / double.parse(controller.targets.contractTarget ?? '') * 100).toStringAsFixed(2)}",
                                color: AppColors.appBlack,
                                fontSize: 20,
                              )
                            ],
                          ),
                        )),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  AppTextLabels.boldTextShort(label: "Sales Target", fontSize: 13, color: AppColors.appGreen),
                                  AppTextLabels.regularShortText(label: controller.commissions.target ?? "", color: AppColors.appBlack, fontSize: 20)
                                ],
                              ),
                            )),
                            SizedBox(width: 8,),
                            Expanded(child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  AppTextLabels.boldTextShort(label: "Sales", fontSize: 13, color: AppColors.appGreen),
                                  AppTextLabels.regularShortText(label: controller.commissions.sale ?? "", color: AppColors.appBlack, fontSize: 20)
                                ],
                              ),
                            )),
                            SizedBox(width: 8,),
                            Expanded(child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  AppTextLabels.boldTextShort(label: "MTD Sales", fontSize: 13, color: AppColors.appGreen),
                                  AppTextLabels.regularShortText(label: "${controller.completedAmount }"?? "", color: AppColors.appBlack, fontSize: 20)
                                ],
                              ),
                            )),


                          ],
                        ),

                      ],
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   margin: EdgeInsets.only(left: 10, right: 10),
                  //   padding: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(8),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.2),
                  //         spreadRadius: 1,
                  //         blurRadius: 2,
                  //         offset: const Offset(0, 1),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       AppTextLabels.boldTextShort(label: "Commission", fontSize: 20, color: AppColors.appGreen),
                  //       AppTextLabels.regularShortText(label: controller.commissions.paidAmt ?? "", color: AppColors.appBlack, fontSize: 20)
                  //     ],
                  //   ),
                  // ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, AddSalesOfficeVisitScreen());
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
                            Image.asset(AppImages.visitor, height: 50,),
                            SizedBox(height: 10,),
                            AppTextLabels.boldTextShort(label: "Add Visit", color: AppColors.appGreen, fontSize: 15)
                          ],
                        ),
                      ),
                    )),

                    SizedBox(width: 10,),
                    Expanded(child: GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, AddClientScreen());
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
                            Image.asset(AppImages.clients, height: 50,),
                            SizedBox(height: 10,),
                            AppTextLabels.boldTextShort(label: "Add Client", color: AppColors.appGreen, fontSize: 15)
                          ],
                        ),
                      ),
                    )),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    Expanded(child: GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, ViewFollowupsScreen());
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
                            Image.asset(AppImages.meeting, height: 50,),
                            SizedBox(height: 10,),
                            AppTextLabels.boldTextShort(label: "Follow Ups", color: AppColors.appGreen, fontSize: 15)
                          ],
                        ),
                      ),
                    )),
                    SizedBox(width: 10,),
                    Expanded(child: GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, ViewVisitsScreen());
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
                            Image.asset(AppImages.visitor, height: 50,),
                            SizedBox(height: 10,),
                            AppTextLabels.boldTextShort(label: "View Visit", color: AppColors.appGreen, fontSize: 15)
                          ],
                        ),
                      ),
                    )),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, CreateQuoteScreen());
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
                            Image.asset(AppImages.quotes, height: 50,),
                            SizedBox(height: 10,),
                            AppTextLabels.boldTextShort(label: "Create Quote", color: AppColors.appGreen, fontSize: 15)
                          ],
                        ),
                      ),
                    )),
                    SizedBox(width: 10,),
                    Expanded(child: GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, QuoteScreen());
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
                            Image.asset(AppImages.quotes, height: 50,),
                            SizedBox(height: 10,),
                            AppTextLabels.boldTextShort(label: "View Quotes", color: AppColors.appGreen, fontSize: 15)
                          ],
                        ),
                      ),
                    )),




                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, SalesmanJobsScreen());
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
                            AppTextLabels.boldTextShort(label: "My Client Jobs", color: AppColors.appGreen, fontSize: 15)
                          ],
                        ),
                      ),
                    )),
                    SizedBox(width: 10,),
                    Expanded(child: GestureDetector(
                      onTap: (){
                        UiHelper.navigateToNextScreen(context, SalesmanIncomeScreen());
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
                            AppTextLabels.boldTextShort(label: "Received Amount", color: AppColors.appGreen, fontSize: 15)
                          ],
                        ),
                      ),
                    )),




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
                          handleLogout();
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
          ),),
        )
      ],
    )));
  }

  void handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This will remove all data from SharedPreferences
    Get.offAll(()=>Login());
  }
}
