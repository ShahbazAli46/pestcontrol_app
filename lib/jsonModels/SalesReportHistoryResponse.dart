class SalesReportHistoryResponse {
  List<SalesReportHistoryResponseData>? data;

  SalesReportHistoryResponse({this.data});

  SalesReportHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SalesReportHistoryResponseData>[];
      json['data'].forEach((v) {
        data!.add(new SalesReportHistoryResponseData.fromJson(v));
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

class SalesReportHistoryResponseData {
  int? id;
  String? target;
  String? commissionPer;
  String? sale;
  String? paidAmt;
  String? month;
  String? status;
  String? paidAt;
  int? referencableId;
  String? referencableType;
  String? createdAt;
  String? updatedAt;
  Referencable? referencable;

  SalesReportHistoryResponseData(
      {this.id,
        this.target,
        this.commissionPer,
        this.sale,
        this.paidAmt,
        this.month,
        this.status,
        this.paidAt,
        this.referencableId,
        this.referencableType,
        this.createdAt,
        this.updatedAt,
        this.referencable});

  SalesReportHistoryResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    target = json['target'];
    commissionPer = json['commission_per'];
    sale = json['sale'];
    paidAmt = json['paid_amt'];
    month = json['month'];
    status = json['status'];
    paidAt = json['paid_at'];
    referencableId = json['referencable_id'];
    referencableType = json['referencable_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referencable = json['referencable'] != null
        ? new Referencable.fromJson(json['referencable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['target'] = this.target;
    data['commission_per'] = this.commissionPer;
    data['sale'] = this.sale;
    data['paid_amt'] = this.paidAmt;
    data['month'] = this.month;
    data['status'] = this.status;
    data['paid_at'] = this.paidAt;
    data['referencable_id'] = this.referencableId;
    data['referencable_type'] = this.referencableType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.referencable != null) {
      data['referencable'] = this.referencable!.toJson();
    }
    return data;
  }
}

class Referencable {
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

  Referencable(
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

  Referencable.fromJson(Map<String, dynamic> json) {
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
