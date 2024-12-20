class PendingPaymentsResponse {
  List<PendingPaymentsResponseData>? data;

  PendingPaymentsResponse({this.data});

  PendingPaymentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PendingPaymentsResponseData>[];
      json['data'].forEach((v) {
        data!.add(new PendingPaymentsResponseData.fromJson(v));
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

class PendingPaymentsResponseData {
  int? id;
  int? clientUserId;
  int? employeeUserId;
  int? serviceInvoiceId;
  String? paidAmt;
  int? clientLedgerId;
  String? status;
  String? createdAt;
  String? updatedAt;
  ClientUser? clientUser;
  ClientUser? employeeUser;

  PendingPaymentsResponseData(
      {this.id,
        this.clientUserId,
        this.employeeUserId,
        this.serviceInvoiceId,
        this.paidAmt,
        this.clientLedgerId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.clientUser,
        this.employeeUser});

  PendingPaymentsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientUserId = json['client_user_id'];
    employeeUserId = json['employee_user_id'];
    serviceInvoiceId = json['service_invoice_id'];
    paidAmt = json['paid_amt'];
    clientLedgerId = json['client_ledger_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    clientUser = json['client_user'] != null
        ? new ClientUser.fromJson(json['client_user'])
        : null;
    employeeUser = json['employee_user'] != null
        ? new ClientUser.fromJson(json['employee_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_user_id'] = this.clientUserId;
    data['employee_user_id'] = this.employeeUserId;
    data['service_invoice_id'] = this.serviceInvoiceId;
    data['paid_amt'] = this.paidAmt;
    data['client_ledger_id'] = this.clientLedgerId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.clientUser != null) {
      data['client_user'] = this.clientUser!.toJson();
    }
    if (this.employeeUser != null) {
      data['employee_user'] = this.employeeUser!.toJson();
    }
    return data;
  }
}

class ClientUser {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  int? roleId;
  int? isActive;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? firedAt;

  ClientUser(
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

  ClientUser.fromJson(Map<String, dynamic> json) {
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
