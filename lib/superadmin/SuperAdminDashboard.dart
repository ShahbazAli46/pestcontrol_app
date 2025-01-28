import 'package:accurate/AccountantDashboard/Components/OutstandingScreen.dart';
import 'package:accurate/NotificationService.dart';
import 'package:accurate/components/generic/MonthPicker.dart';
import 'package:accurate/superadmin/Components/BanksScreen.dart';
import 'package:accurate/superadmin/Components/FinancialReportScreen.dart';
import 'package:accurate/superadmin/Components/QuotesScreen.dart';
import 'package:accurate/superadmin/Components/SalesReport.dart';
import 'package:accurate/superadmin/Components/StocksScreen.dart';
import 'package:accurate/superadmin/Components/ViewAllInvoiceScreen.dart';
import 'package:accurate/superadmin/Components/ViewAllSuppliers.dart';
import 'package:accurate/superadmin/Controllers/ExpensesScreen.dart';
import 'package:accurate/user/login.dart';
import 'package:accurate/utils/AlertService.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/ViewAllClients.dart';
import '../components/generic/Navbar.dart';
import '../components/generic/UIHelper.dart';
import '../sales_man/UpcomingJobsScreen.dart';
import '../utils/AppImages.dart';
import 'Components/AllUpcomingJobs.dart';

class SuperAdminDashboard extends StatefulWidget {
  const SuperAdminDashboard({Key? key}) : super(key: key);

  @override
  State<SuperAdminDashboard> createState() => _SuperAdminDashboardState();
}

class _SuperAdminDashboardState extends State<SuperAdminDashboard> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:Column(
          children: [
            Navbar(),
            SizedBox(height: 10,),
            AppTextLabels.boldTextShort(label: "Welcome", fontSize: 20, color: AppColors.appGreen),
            SizedBox(height: 10,),
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: (){
                              UiHelper.navigateToNextScreenGetX(SalesReport());
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
                                Image.asset(AppImages.sales, height: 50,),
                                SizedBox(height: 10,),
                                AppTextLabels.boldTextShort(label: "Sales Report", color: AppColors.appGreen, fontSize: 15)
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
                                AppTextLabels.boldTextShort(label: "Quotes Sent", color: AppColors.appGreen, fontSize: 15)
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
                            UiHelper.navigateToNextScreenGetX(AllUpComingJobs());
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
                            UiHelper.navigateToNextScreenGetX(ViewAllInvoicesScreen());
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
                                AppTextLabels.boldTextShort(label: "Invoices", color: AppColors.appGreen, fontSize: 15)
                              ],
                            ),
                          ),
                        )),
                        SizedBox(width: 10,),
                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreenGetX(StockScreen());
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
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreenGetX(ExpensesScreen());

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
                                Image.asset(AppImages.expenses, height: 50,),
                                SizedBox(height: 10,),
                                AppTextLabels.boldTextShort(label: "Expenses", color: AppColors.appGreen, fontSize: 15)
                              ],
                            ),
                          ),
                        )),
                        SizedBox(width: 10,),

                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreenGetX(ViewAllSuppliers());

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
                                Image.asset(AppImages.manufacture, height: 50,),
                                SizedBox(height: 10,),
                                AppTextLabels.boldTextShort(label: "Supplier", color: AppColors.appGreen, fontSize: 15)
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
                            UiHelper.navigateToNextScreenGetX(OutstadingScreen());
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
                                AppTextLabels.boldTextShort(label: "Outstandings", color: AppColors.appGreen, fontSize: 15)
                              ],
                            ),
                          ),
                        )),
                        SizedBox(width: 10,),
                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreenGetX(FinancialReportScreen());
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
                                Image.asset(AppImages.report, height: 50,),
                                SizedBox(height: 10,),
                                AppTextLabels.boldTextShort(label: "Financial Report", color: AppColors.appGreen, fontSize: 15)
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
                            UiHelper.navigateToNextScreenGetX(BanksScreen());
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
                                Image.asset(AppImages.bank, height: 50,),
                                SizedBox(height: 10,),
                                AppTextLabels.boldTextShort(label: "Banks", color: AppColors.appGreen, fontSize: 15)
                              ],
                            ),
                          ),
                        )),
                        SizedBox(width: 10,),
                        Expanded(child: GestureDetector(
                          onTap: (){
                            UiHelper.navigateToNextScreenGetX(ViewAllClients(type: ClientScreenViewTypes.forView));
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
                                AppTextLabels.boldTextShort(label: "Clients", color: AppColors.appGreen, fontSize: 15)
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      AlertService.showAlertWithCancelButton("Alert", "Are Sure you want to logout?", onOkPressed: (){
                        handleLogout();
                      });

                      // UiHelper.navigateToNextScreen(context, HistoryScreen());
                    },
                    child: Container(
                      width: 100,
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
                  ),
                ],
              ),
            ))


          ],
        ),
      ),
    );
  }
  onMonthChanged(month){
    print(month);
  }

  void handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This will remove all data from SharedPreferences
    Get.offAll(()=>Login());
  }
}
