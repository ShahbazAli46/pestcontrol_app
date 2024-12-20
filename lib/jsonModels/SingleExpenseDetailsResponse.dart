class SingleExpenseDetailsResponse {
  Data? data;

  SingleExpenseDetailsResponse({this.data});

  SingleExpenseDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? expenseCategory;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Expenses>? expenses;

  Data(
      {this.id,
        this.expenseCategory,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.expenses});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseCategory = json['expense_category'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['expenses'] != null) {
      expenses = <Expenses>[];
      json['expenses'].forEach((v) {
        expenses!.add(new Expenses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expense_category'] = this.expenseCategory;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.expenses != null) {
      data['expenses'] = this.expenses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Expenses {
  int? id;
  Null? bankId;
  int? expenseCategoryId;
  String? expenseName;
  String? paymentType;
  String? amount;
  Null? chequeNo;
  Null? chequeDate;
  Null? transectionId;
  String? vatPer;
  String? vatAmount;
  String? description;
  String? totalAmount;
  String? expenseFile;
  String? expenseDate;
  String? createdAt;
  String? updatedAt;

  Expenses(
      {this.id,
        this.bankId,
        this.expenseCategoryId,
        this.expenseName,
        this.paymentType,
        this.amount,
        this.chequeNo,
        this.chequeDate,
        this.transectionId,
        this.vatPer,
        this.vatAmount,
        this.description,
        this.totalAmount,
        this.expenseFile,
        this.expenseDate,
        this.createdAt,
        this.updatedAt});

  Expenses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bank_id'];
    expenseCategoryId = json['expense_category_id'];
    expenseName = json['expense_name'];
    paymentType = json['payment_type'];
    amount = json['amount'];
    chequeNo = json['cheque_no'];
    chequeDate = json['cheque_date'];
    transectionId = json['transection_id'];
    vatPer = json['vat_per'];
    vatAmount = json['vat_amount'];
    description = json['description'];
    totalAmount = json['total_amount'];
    expenseFile = json['expense_file'];
    expenseDate = json['expense_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_id'] = this.bankId;
    data['expense_category_id'] = this.expenseCategoryId;
    data['expense_name'] = this.expenseName;
    data['payment_type'] = this.paymentType;
    data['amount'] = this.amount;
    data['cheque_no'] = this.chequeNo;
    data['cheque_date'] = this.chequeDate;
    data['transection_id'] = this.transectionId;
    data['vat_per'] = this.vatPer;
    data['vat_amount'] = this.vatAmount;
    data['description'] = this.description;
    data['total_amount'] = this.totalAmount;
    data['expense_file'] = this.expenseFile;
    data['expense_date'] = this.expenseDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
