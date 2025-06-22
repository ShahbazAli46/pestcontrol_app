import 'package:accurate/AccountantDashboard/AccountantDashboardScreen.dart';
import 'package:accurate/QualityInspector/QualityInspectorDashboard.dart';
import 'package:accurate/RecoveryOfficeDashboard/RecoverOfficerDashboard.dart';
import 'package:accurate/SalesManagerAndSalesMan/SalesMan/SalesOfficerDashboard.dart';
import 'package:accurate/components/generic/DashedSeparatorPainter.dart';
import 'package:accurate/main.dart';
import 'package:accurate/sales_man/salesManDashboard.dart';
import 'package:accurate/superadmin/SuperAdminDashboard.dart';
import 'package:accurate/user/login.dart';
import 'package:accurate/utils/AppImages.dart';
import 'package:accurate/utils/TextStyle.dart';
import 'package:accurate/utils/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';


class UiHelper {

  static Container AppContainer ({required Widget  child}) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8), // Add this line
          boxShadow: [ // Add this line
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
      child: child,
    );
  }


  static Widget dashedBoarder ( ){
    return CustomPaint(
      painter: DashedSeparatorPainter(),
      child: Container(
        height: 1, // Set the height of the separator
      ),
    );
  }

  static void navigateToNextScreen(BuildContext context, nextScreen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => nextScreen));
  }


  static void backToDashboard(context){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => UiHelper.goToUserDashboardAsPerUserRole(userObj?.data?.roleId ?? 0)),
          (route) => false, // This removes all previous routes
    );
  }


  static void navigateToNextScreenGetX(Widget nextScreen) {
    Get.to(() => nextScreen,
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: 150), // Adjust duration as needed
    );
  }

  static Widget loadNetworkImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(AppImages.logo); // Replace with your actual error image
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Image.asset(AppImages.logo); // Replace with your actual placeholder image
          }
        },
      ),
    );
  }


  static Widget loadNetworkImageFuture({
    required Future<String> imageUrlFuture,
    double? width,
    double? height,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) {
    return FutureBuilder<String>(
      future: imageUrlFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FadeInImage(
              image: NetworkImage(snapshot.data!),
              placeholder: AssetImage(AppImages.logo),
              fit: fit ?? BoxFit.cover,
              width: width,
              height: height,
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: Center(child: Text('Error loading image')),
          );
        } else {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  static Widget loadFutureText({
    required Future<String> textFuture,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return FutureBuilder<String>(
      future: textFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return AppTextLabels.boldTextShort(label: snapshot.data!, color: AppColors.appGreen, fontSize: 20);
        } else if (snapshot.hasError) {
          return Text(
            'Error loading text: ${snapshot.error}',
            style: TextStyle(color: Colors.red),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  static Expanded loader(){
    return Expanded(
      child
          : Column(
        children: [
          Expanded(child: Text("")),
          Image.asset(AppImages.logo, height: 150,),
          SizedBox(height: 20,),
          Center(child: CircularProgressIndicator()),
          Expanded(child: Text(""))
        ],
      ),
    );
  }


  static String formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      return '${DateFormat('MMM d, y').format(dateTime)}';
    } catch(e){
      return "Unparse able Date ${date}";
    }

  }

  static String formatDateToMonthYear(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      // Using intl package for date formatting
      return DateFormat('dd MMM, yyyy').format(dateTime);  // Changed format pattern
    } catch (e) {
      return 'Invalid Date';
    }
  }
  static void makePhoneCall  (String phoneNumber) async{
    if (phoneNumber.isNotEmpty) {
      await launch('tel:$phoneNumber');
    } else {
      print('Phone number is empty.');
    }
  }

  static Future<void> sendEmail(String emailAddress) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      } else {
        print('Cannot launch email client for URI: $emailUri');
      }
    } catch (e) {
      print('Error launching email client: $e');
    }
  }



  static String formatUAECurrency(double value) {
    final formatter = NumberFormat.currency(
      locale: 'ar_AE',
      symbol: "AED",
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  static String formatDateForServer(DateTime date){
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static Widget buildRow(String label, String areaObject) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Color(0xffF9FAFB)),
              child: Center(
                  child: AppTextLabels.regularShortText(
                      label: label,
                      color: AppColors.appBlack,
                      textAlign: TextAlign.center)),
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: areaObject));
                Get.snackbar(
                  'Success', // title
                  'Copied to clipboard', // message
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.black87,
                  colorText: Colors.white,
                );
              },
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 50, // Set the minimum height here
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextLabels.regularShortText(
                        label: areaObject,
                        color: AppColors.appBlack,
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget commonContainer (Widget child){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
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
        child: child,
      ),
    );
  }

  static Widget goToUserDashboardAsPerUserRole(int roleId){
    Widget home;
    home = Login();
    if (roleId == 4) {
      home = const SalesManDashboard();
    } else if (roleId == 1){
      home = const SuperAdminDashboard();
    } else if (roleId == 6){
      home =  AccountantDashboardScreen();
    } else if (roleId == 7){
      home = RecoverOfficerDashboard();
    } else if (roleId == 9){
      home = SalesOfficerDashboard();
    } else if (roleId == 10){
      home = QualityInspectorDashboard();
    }
    return home;
  }


  static Map<String, String> getMonthStartAndEndDates(String yearMonth) {
    // Parse the input string
    final parts = yearMonth.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);

    // Calculate first day of the month
    final firstDay = DateTime(year, month, 1);

    // Calculate last day of the month
    // Using month+1 and day 0 gives the last day of the previous month
    final lastDay = DateTime(year, month + 1, 0);

    // Format dates as YYYY-MM-DD
    final startDate = '${firstDay.year}-${firstDay.month.toString().padLeft(2, '0')}-${firstDay.day.toString().padLeft(2, '0')}';
    final endDate = '${lastDay.year}-${lastDay.month.toString().padLeft(2, '0')}-${lastDay.day.toString().padLeft(2, '0')}';

    return {
      'startDate': startDate,
      'endDate': endDate
    };
  }
  static String formatDateTime(String dateTimeStr) {
    try {
      // Check if the string is just a date or has time component
      String dateString = dateTimeStr.trim();
      DateTime dateTime;

      if (dateString.length <= 10) {  // If only date is provided (YYYY-MM-DD)
        dateTime = DateTime.parse(dateString);
        // Set default time to start of day
        dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
      } else {
        dateTime = DateTime.parse(dateString);
      }

      // List of month abbreviations
      List<String> months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];

      // Get components
      int day = dateTime.day;
      String month = months[dateTime.month - 1];
      int year = dateTime.year;

      // Convert hour to 12-hour format
      int hour = dateTime.hour;
      String period = 'AM';
      if (hour >= 12) {
        period = 'PM';
        if (hour > 12) {
          hour -= 12;
        }
      }
      if (hour == 0) {
        hour = 12;
      }

      // Format minutes with leading zero if needed
      String minutes = dateTime.minute.toString().padLeft(2, '0');

      // If original string didn't have time, return only date
      if (dateString.length <= 10) {
        return '$day $month $year';
      }

      // Return full date and time
      return '$day $month $year, $hour:$minutes $period';
    } catch (e) {
      // Handle invalid date formats
      return 'Invalid date format';
    }
  }
  static List<DateTime> getFirstAndLastDateOfMonth(String dateStr) {
    // Parse the input string into a DateTime object
    DateFormat dateFormat = DateFormat('yyyy-MM');
    DateTime date = dateFormat.parse(dateStr);

    // Get the first day of the month
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);

    // Get the last day of the month
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 0).subtract(Duration(days: 1));

    // Return the first and last dates of the month
    return [firstDayOfMonth, lastDayOfMonth];
  }


  static List<String> getDocumentsByProfession(String profession) {
    const List<String> allDocuments = [
      "Employment Letter",
      "Job Offer Letter/Joining Letter APCS",
      "Passport Handover Form",
      "Passport",
      "EID",
      "DM Card",
      "Driving Licence",
      "MOHRE Letter",
      "Labour Card",
      "Change Status",
      "Visa",
      "EHOC",
      "Medical Report",
      "Visa Stamping",
      "Health Insurance",
      "Vehicle Policy",
      "Asset Policy",
      "ILOE Insurance",
      "Bank Detail/Salary Transfer",
    ];

    // Documents to exclude for HR Manager
    const List<String> hrExcludedDocs = ["Vehicle Policy", "DM Card", "EHOC"];

    // Handle HR Manager case
    if (profession == "HR Manager") {
      return allDocuments.where((doc) => !hrExcludedDocs.contains(doc)).toList();
    }

    // Handle Sales roles
    if (profession == "Sales Manager" || profession == "Sales Officer") {
      const List<String> salesExcludedDocs = ["DM Card", "EHOC"];
      return allDocuments.where((doc) => !salesExcludedDocs.contains(doc)).toList();
    }

    // For other professions, return all documents
    return allDocuments;
  }

  static void handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This will remove all data from SharedPreferences
    Get.offAll(()=>Login());
  }

}