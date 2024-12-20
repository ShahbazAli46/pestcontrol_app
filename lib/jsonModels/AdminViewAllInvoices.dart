class AdminViewAllInvoices {
  String? startDate;
  String? endDate;
  List<AdminViewAllInvoicesData>? data;

  AdminViewAllInvoices({this.startDate, this.endDate, this.data});

  AdminViewAllInvoices.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['data'] != null) {
      data = <AdminViewAllInvoicesData>[];
      json['data'].forEach((v) {
        data!.add(new AdminViewAllInvoicesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdminViewAllInvoicesData {
  int? id;
  String? serviceInvoiceId;
  int? invoiceableId;
  String? invoiceableType;
  int? userId;
  String? issuedDate;
  String? totalAmt;
  String? paidAmt;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? title;
  User? user;

  AdminViewAllInvoicesData(
      {this.id,
        this.serviceInvoiceId,
        this.invoiceableId,
        this.invoiceableType,
        this.userId,
        this.issuedDate,
        this.totalAmt,
        this.paidAmt,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.user});

  AdminViewAllInvoicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceInvoiceId = json['service_invoice_id'];
    invoiceableId = json['invoiceable_id'];
    invoiceableType = json['invoiceable_type'];
    userId = json['user_id'];
    issuedDate = json['issued_date'];
    totalAmt = json['total_amt'];
    paidAmt = json['paid_amt'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_invoice_id'] = this.serviceInvoiceId;
    data['invoiceable_id'] = this.invoiceableId;
    data['invoiceable_type'] = this.invoiceableType;
    data['user_id'] = this.userId;
    data['issued_date'] = this.issuedDate;
    data['total_amt'] = this.totalAmt;
    data['paid_amt'] = this.paidAmt;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  int? isActive;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? firedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.firedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firedAt = json['fired_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['is_active'] = this.isActive;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fired_at'] = this.firedAt;
    return data;
  }
}
