import 'package:accurate/RecoveryOfficeDashboard/views/AssignedInvocesScreen.dart';
import 'package:accurate/components/generic/Navbar.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/user/login.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/AppImages.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/generic/DateRangePicker.dart';
import '../main.dart';
import '../utils/appColors.dart';

class RecoverOfficerDashboard extends StatefulWidget {


  @override
  State<RecoverOfficerDashboard> createState() => _RecoverOfficerDashboardState();
}

class _RecoverOfficerDashboardState extends State<RecoverOfficerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Navbar(),
            SizedBox(height: 10,),
            SizedBox(height: 50,),
            UiHelper.loadNetworkImage(imageUrl: userObj?.data?.employee?.profileImage ?? "", height: 150),
            SizedBox(height: 20,),
            AppTextLabels.regularShortText(label: "Welcome", color: AppColors.appBlack, fontSize: 20) ,
            AppTextLabels.boldTextShort(label: userObj?.data?.name ?? "", fontSize: 20),
            SizedBox(height: 20,),
            Expanded(child: SingleChildScrollView(child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: GestureDetector(
                        onTap: (){
                          UiHelper.navigateToNextScreen(context, AssignedInvoicesScreen());
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
                              Image.asset(AppImages.oustanding, height: 50,),
                              SizedBox(height: 10,),
                              AppTextLabels.boldTextShort(label: "Assigned Invoices", color: AppColors.appGreen, fontSize: 15)
                            ],
                          ),
                        ),
                      )),
                      SizedBox(width: 10,),
                      // Expanded(child: GestureDetector(
                      //   onTap: (){
                      //     // UiHelper.navigateToNextScreenGetX(FinancialReportScreen());
                      //   },
                      //   child: Container(
                      //     height: 100,
                      //     decoration: BoxDecoration(
                      //         border: Border.all(
                      //             color: AppColors.appGreen,
                      //             width: 2
                      //         ),
                      //         borderRadius: BorderRadius.circular(10)
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         SizedBox(height: 10,),
                      //         Image.asset(AppImages.report, height: 50,),
                      //         SizedBox(height: 10,),
                      //         AppTextLabels.boldTextShort(label: "Financial Report", color: AppColors.appGreen, fontSize: 15)
                      //       ],
                      //     ),
                      //   ),
                      // )),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: GestureDetector(
                        onTap: (){
                          // UiHelper.navigateToNextScreen(context, EmployeeStockScreen());
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
            ),))


          ],
        ),
      ),
    );
  }

  void handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This will remove all data from SharedPreferences
    Get.offAll(()=>Login());
  }
}
