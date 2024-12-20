class Urls {
  static String baseURL = "https://api.apcs.ae/api/";
  static String login = "${Urls.baseURL}login";
  static String upcomingJobs = "${Urls.baseURL}employee/";
  static String reschduleJob = "${Urls.baseURL}job/reschedule";
  static String startJob = "${Urls.baseURL}job/start/";
  static String singleJobDetails = "${Urls.baseURL}job/";
  static String services = "${Urls.baseURL}service";
  static String treatmentMethod = "${Urls.baseURL}treatment_method";
  static String employeeInfo = "${Urls.baseURL}employee/";
  static String createServiceReport = "${Urls.baseURL}job/service_report/create";
  static String allClients = "${Urls.baseURL}client";
  static String allInvoices = "${Urls.baseURL}service_invoices?user_id=";
  static String bank = "${Urls.baseURL}bank";
  static String addPaymentForInvoices = "${Urls.baseURL}service_invoices/add_payment";
  static String stockHistory = "${Urls.baseURL}employee/stock/history";
  static String itemHistroy = "${Urls.baseURL}employee/stock/used";
  static String completeJob = "${Urls.baseURL}job/move/complete/";
  static String sendFeedback = "${Urls.baseURL}job/service_report/feedback/create";
  static String salesHistory = "${Urls.baseURL}employee/commission/get?commission_month=";
  static String allOperationsTeams = "${Urls.baseURL}employee/sales_manager/get";
  static String assignJob = "${Urls.baseURL}job/sales_manager/assign";
  static String addExpense = "${Urls.baseURL}expense/create";
}



class Constants {
  static String serviceReportController = "serviceReportController";
  static String visitsTypeController = "visitsController";
  static String inspectedAreaController = "inspectedAreaController";
  static String jobController = "jobController";
  static String pestController = "pestController";
  static String treatmentmethodController = "treatmentmethodController";
  static String usedChemicalController = "usedChemicalController";
  static String allClients = "allClients";
  static String allJobs = "allClients";
  static String expensesController = "expensesController";
  static String products = "products";

}