class SalesmanIncomeResponse {
  String? startDate;
  String? endDate;
  List<SalesmanIncomeResponseData>? data;

  SalesmanIncomeResponse({this.startDate, this.endDate, this.data});

  SalesmanIncomeResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['data'] != null) {
      data = <SalesmanIncomeResponseData>[];
      json['data'].forEach((v) {
        data!.add(new SalesmanIncomeResponseData.fromJson(v));
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

class SalesmanIncomeResponseData {
  int? id;
  String? serviceInvoiceId;
  String? userInvoiceId;
  int? invoiceableId;
  String? invoiceableType;
  int? userId;
  String? issuedDate;
  String? totalAmt;
  String? paidAmt;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? jobIds;
  int? addressId;
  String? promiseDate;
  String? assignedUserId;
  int? jobId;
  String? settlementAmt;
  String? settlementAt;
  int? isTakenCheque;
  User? user;

  SalesmanIncomeResponseData(
      {this.id,
        this.serviceInvoiceId,
        this.userInvoiceId,
        this.invoiceableId,
        this.invoiceableType,
        this.userId,
        this.issuedDate,
        this.totalAmt,
        this.paidAmt,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.jobIds,
        this.addressId,
        this.promiseDate,
        this.assignedUserId,
        this.jobId,
        this.settlementAmt,
        this.settlementAt,
        this.isTakenCheque,
        this.user});

  SalesmanIncomeResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceInvoiceId = json['service_invoice_id'];
    userInvoiceId = json['user_invoice_id'];
    invoiceableId = json['invoiceable_id'];
    invoiceableType = json['invoiceable_type'];
    userId = json['user_id'];
    issuedDate = json['issued_date'];
    totalAmt = json['total_amt'];
    paidAmt = json['paid_amt'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    jobIds = json['job_ids'];
    addressId = json['address_id'];
    promiseDate = json['promise_date'];
    assignedUserId = json['assigned_user_id'];
    jobId = json['job_id'];
    settlementAmt = json['settlement_amt'];
    settlementAt = json['settlement_at'];
    isTakenCheque = json['is_taken_cheque'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_invoice_id'] = this.serviceInvoiceId;
    data['user_invoice_id'] = this.userInvoiceId;
    data['invoiceable_id'] = this.invoiceableId;
    data['invoiceable_type'] = this.invoiceableType;
    data['user_id'] = this.userId;
    data['issued_date'] = this.issuedDate;
    data['total_amt'] = this.totalAmt;
    data['paid_amt'] = this.paidAmt;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['job_ids'] = this.jobIds;
    data['address_id'] = this.addressId;
    data['promise_date'] = this.promiseDate;
    data['assigned_user_id'] = this.assignedUserId;
    data['job_id'] = this.jobId;
    data['settlement_amt'] = this.settlementAmt;
    data['settlement_at'] = this.settlementAt;
    data['is_taken_cheque'] = this.isTakenCheque;
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
  String? appVersion;
  String? firebaseToken;
  String? branchId;
  Client? client;

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
        this.firedAt,
        this.appVersion,
        this.firebaseToken,
        this.branchId,
        this.client});

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
    appVersion = json['app_version'];
    firebaseToken = json['firebase_token'];
    branchId = json['branch_id'];
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
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
    data['app_version'] = this.appVersion;
    data['firebase_token'] = this.firebaseToken;
    data['branch_id'] = this.branchId;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }
}

class Client {
  int? id;
  int? userId;
  int? roleId;
  String? firmName;
  String? phoneNumber;
  String? mobileNumber;
  String? industryName;
  String? referencableType;
  int? referencableId;
  String? openingBalance;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Client(
      {this.id,
        this.userId,
        this.roleId,
        this.firmName,
        this.phoneNumber,
        this.mobileNumber,
        this.industryName,
        this.referencableType,
        this.referencableId,
        this.openingBalance,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    roleId = json['role_id'];
    firmName = json['firm_name'];
    phoneNumber = json['phone_number'];
    mobileNumber = json['mobile_number'];
    industryName = json['industry_name'];
    referencableType = json['referencable_type'];
    referencableId = json['referencable_id'];
    openingBalance = json['opening_balance'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['firm_name'] = this.firmName;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['industry_name'] = this.industryName;
    data['referencable_type'] = this.referencableType;
    data['referencable_id'] = this.referencableId;
    data['opening_balance'] = this.openingBalance;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
