class SingleVehicleResponse {
  SingleVehicleResponseData? data;

  SingleVehicleResponse({this.data});

  SingleVehicleResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SingleVehicleResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SingleVehicleResponseData {
  int? id;
  String? vehicleNumber;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? modalName;
  int? userId;
  String? condition;
  String? expiryDate;
  String? oilChangeLimit;
  List<VehicleExpenses>? vehicleExpenses;
  SingleVehicleResponseDataUser? user;

  SingleVehicleResponseData(
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
        this.vehicleExpenses,
        this.user});

  SingleVehicleResponseData.fromJson(Map<String, dynamic> json) {
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
    if (json['vehicle_expenses'] != null) {
      vehicleExpenses = <VehicleExpenses>[];
      json['vehicle_expenses'].forEach((v) {
        vehicleExpenses!.add(new VehicleExpenses.fromJson(v));
      });
    }
    user = json['user'] != null ? new SingleVehicleResponseDataUser.fromJson(json['user']) : null;
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
    if (this.vehicleExpenses != null) {
      data['vehicle_expenses'] =
          this.vehicleExpenses!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class VehicleExpenses {
  int? id;
  Null? bankId;
  int? vehicleId;
  String? fuelAmount;
  String? oilAmount;
  String? maintenanceAmount;
  String? expenseDate;
  String? totalAmt;
  String? paymentType;
  Null? chequeNo;
  Null? chequeDate;
  Null? transectionId;
  String? vatPer;
  String? vatAmount;
  String? totalAmount;
  String? createdAt;
  String? updatedAt;
  String? oilChangeLimit;

  VehicleExpenses(
      {this.id,
        this.bankId,
        this.vehicleId,
        this.fuelAmount,
        this.oilAmount,
        this.maintenanceAmount,
        this.expenseDate,
        this.totalAmt,
        this.paymentType,
        this.chequeNo,
        this.chequeDate,
        this.transectionId,
        this.vatPer,
        this.vatAmount,
        this.totalAmount,
        this.createdAt,
        this.updatedAt,
        this.oilChangeLimit});

  VehicleExpenses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bank_id'];
    vehicleId = json['vehicle_id'];
    fuelAmount = json['fuel_amount'];
    oilAmount = json['oil_amount'];
    maintenanceAmount = json['maintenance_amount'];
    expenseDate = json['expense_date'];
    totalAmt = json['total_amt'];
    paymentType = json['payment_type'];
    chequeNo = json['cheque_no'];
    chequeDate = json['cheque_date'];
    transectionId = json['transection_id'];
    vatPer = json['vat_per'];
    vatAmount = json['vat_amount'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    oilChangeLimit = json['oil_change_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_id'] = this.bankId;
    data['vehicle_id'] = this.vehicleId;
    data['fuel_amount'] = this.fuelAmount;
    data['oil_amount'] = this.oilAmount;
    data['maintenance_amount'] = this.maintenanceAmount;
    data['expense_date'] = this.expenseDate;
    data['total_amt'] = this.totalAmt;
    data['payment_type'] = this.paymentType;
    data['cheque_no'] = this.chequeNo;
    data['cheque_date'] = this.chequeDate;
    data['transection_id'] = this.transectionId;
    data['vat_per'] = this.vatPer;
    data['vat_amount'] = this.vatAmount;
    data['total_amount'] = this.totalAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['oil_change_limit'] = this.oilChangeLimit;
    return data;
  }
}

class SingleVehicleResponseDataUser {
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

  SingleVehicleResponseDataUser(
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

  SingleVehicleResponseDataUser.fromJson(Map<String, dynamic> json) {
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
