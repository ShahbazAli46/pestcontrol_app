class FinancialReportResponse {
  FinancialReportResponseData? data;

  FinancialReportResponse({this.data});

  FinancialReportResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new FinancialReportResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FinancialReportResponseData {
  String? supplierBalance;
  String? purchaseOrder;
  String? paidEmployeeSalary;
  String? paidEmployeeComm;

  FinancialReportResponseData(
      {this.supplierBalance,
        this.purchaseOrder,
        this.paidEmployeeSalary,
        this.paidEmployeeComm});

  FinancialReportResponseData.fromJson(Map<String, dynamic> json) {
    supplierBalance = json['supplier_balance'];
    purchaseOrder = json['purchase_order'];
    paidEmployeeSalary = json['paid_employee_salary'];
    paidEmployeeComm = json['paid_employee_comm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplier_balance'] = this.supplierBalance;
    data['purchase_order'] = this.purchaseOrder;
    data['paid_employee_salary'] = this.paidEmployeeSalary;
    data['paid_employee_comm'] = this.paidEmployeeComm;
    return data;
  }
}
