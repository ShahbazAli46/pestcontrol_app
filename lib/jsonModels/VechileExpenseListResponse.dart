class VehicleExpenseListResponse {
  List<VehicleExpenseListResponseData>? data;

  VehicleExpenseListResponse({this.data});

  VehicleExpenseListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VehicleExpenseListResponseData>[];
      json['data'].forEach((v) {
        data!.add(new VehicleExpenseListResponseData.fromJson(v));
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

class VehicleExpenseListResponseData {
  int? id;
  String? vehicleNumber;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? modalName;
  int? userId;
  String? condition;
  String? expiryDate;
  String? oilChangeLimit;
  String? totalAmount;
  User? user;

  VehicleExpenseListResponseData(
      {this.id,
        this.vehicleNumber,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.modalName,
        this.userId,
        this.condition,
        this.expiryDate,
        this.oilChangeLimit,
        this.totalAmount,
        this.user});

  VehicleExpenseListResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleNumber = json['vehicle_number'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    modalName = json['modal_name'];
    userId = json['user_id'];
    condition = json['condition'];
    expiryDate = json['expiry_date'];
    oilChangeLimit = json['oil_change_limit'];
    totalAmount = json['total_amount'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_number'] = this.vehicleNumber;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['modal_name'] = this.modalName;
    data['user_id'] = this.userId;
    data['condition'] = this.condition;
    data['expiry_date'] = this.expiryDate;
    data['oil_change_limit'] = this.oilChangeLimit;
    data['total_amount'] = this.totalAmount;
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
  Null? emailVerifiedAt;
  int? roleId;
  int? isActive;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? firedAt;

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
