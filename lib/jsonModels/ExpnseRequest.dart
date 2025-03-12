class ExpenseRequest {
  String? expenseName;
  String? expenseDate;
  String? expenseCategoryId;
  String? vat;
  String? total;
  String? description;
  String? paymentType;
  String? transectionId;
  String? amount;
  String? chequeDate;
  String? bankId;
  String? branch_id;
  String? cheque_no;

  ExpenseRequest(
      {this.expenseName,
        this.expenseDate,
        this.expenseCategoryId,
        this.vat,
        this.total,
        this.description,
        this.paymentType,
        this.transectionId,
        this.amount,
        this.chequeDate,
        this.bankId,
        this.branch_id,
        this.cheque_no
      });

  ExpenseRequest.fromJson(Map<String, dynamic> json) {
    expenseName = json['expense_name'];
    expenseDate = json['expense_date'];
    expenseCategoryId = json['expense_category_id'];
    vat = json['vat'];
    total = json['total'];
    description = json['description'];
    paymentType = json['payment_type'];
    transectionId = json['transection_id'];
    amount = json['amount'];
    chequeDate = json['cheque_date'];
    bankId = json['bank_id'];
    branch_id = json['branch_id'];
    cheque_no = json['cheque_no'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['expense_name'] = this.expenseName ?? "";
    data['expense_date'] = this.expenseDate ?? "";
    data['expense_category_id'] = this.expenseCategoryId ?? "";
    data['vat'] = this.vat ?? "";
    data['total'] = this.total ?? "";
    data['description'] = this.description ?? "";
    data['payment_type'] = this.paymentType ?? "";
    data['transection_id'] = this.transectionId ?? "";
    data['amount'] = this.amount ?? "";
    data['cheque_date'] = this.chequeDate ?? "";
    data['bank_id'] = this.bankId ?? "";
    data['branch_id'] = this.branch_id ?? "";
    data['cheque_no'] = this.cheque_no ?? "";
    return data;
  }
}
