import 'package:accurate/UserRepository.dart';
import 'package:accurate/components/ViewAllClients.dart';
import 'package:accurate/components/generic/Navbar.dart';
import 'package:accurate/components/generic/UIHelper.dart';
import 'package:accurate/main.dart';
import 'package:accurate/sales_man/HistoryScreen.dart';
import 'package:accurate/sales_man/UpcomingJobsScreen.dart';
import 'package:accurate/user/UserProfile/UserProfileScreen.dart';
import 'package:accurate/user/login.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/AppImages.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/EmployeStockScreen.dart';

class SalesManDashboard extends StatefulWidget {
  const SalesManDashboard({Key? key}) : super(key: key);

  @override
  State<SalesManDashboard> createState() => _SalesManDashboardState();
}

class _SalesManDashboardState extends State<SalesManDashboard> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Get.deleteAll(force: true);
  }
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
            Expanded(
              child: SingleChildScrollView(child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreen(context, UpComingJobsScreen());
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
                                AppTextLabels.boldTextShort(label: "Up Coming Jobs", color: AppColors.appGreen, fontSize: 15)
                              ],
                            ),
                          ),
                        )),
                        SizedBox(width: 10,),
                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreenGetX(ViewAllClients(type: ClientScreenViewTypes.forPayment,));
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreen(context, EmployeeStockScreen());
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
                                Image.asset(AppImages.stock, height: 50,),
                                SizedBox(height: 10,),
                                AppTextLabels.boldTextShort(label: "Stocks", color: AppColors.appGreen, fontSize: 15)
                              ],
                            ),
                          ),
                        )),
                        SizedBox(width: 10,),
                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreen(context, HistoryScreen());
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
                                Image.asset(AppImages.history, height: 50,),
                                SizedBox(height: 10,),
                                AppTextLabels.boldTextShort(label: "History", color: AppColors.appGreen, fontSize: 15)
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
