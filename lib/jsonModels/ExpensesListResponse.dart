class ExpensesListResponse {
  List<Data>? data;

  ExpensesListResponse({this.data});

  ExpensesListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  String? totalAmount;

  Data(
      {this.id,
        this.expenseCategory,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.totalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseCategory = json['expense_category'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expense_category'] = this.expenseCategory;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
