class PaymentScreenResponse {
  String? startDate;
  String? endDate;
  List<PaymentScreenResponseData>? data;

  PaymentScreenResponse({this.startDate, this.endDate, this.data});

  PaymentScreenResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['data'] != null) {
      data = <PaymentScreenResponseData>[];
      json['data'].forEach((v) {
        data!.add(new PaymentScreenResponseData.fromJson(v));
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

class PaymentScreenResponseData {
  int? id;
  int? bankId;
  String? description;
  String? drAmt;
  String? crAmt;
  String? paymentType;
  String? cashAmt;
  String? posAmt;
  String? chequeAmt;
  String? onlineAmt;
  String? chequeNo;
  String? chequeDate;
  String? entryType;
  String? transectionId;
  String? bankBalance;
  String? cashBalance;
  int? personId;
  String? personType;
  int? linkId;
  String? linkName;
  String? createdAt;
  String? updatedAt;
  int? referenceableId;
  String? referenceableType;
  Personable? personable;
  Referenceable? referenceable;

  PaymentScreenResponseData(
      {this.id,
        this.bankId,
        this.description,
        this.drAmt,
        this.crAmt,
        this.paymentType,
        this.cashAmt,
        this.posAmt,
        this.chequeAmt,
        this.onlineAmt,
        this.chequeNo,
        this.chequeDate,
        this.entryType,
        this.transectionId,
        this.bankBalance,
        this.cashBalance,
        this.personId,
        this.personType,
        this.linkId,
        this.linkName,
        this.createdAt,
        this.updatedAt,
        this.referenceableId,
        this.referenceableType,
        this.personable,
        this.referenceable});

  PaymentScreenResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bank_id'];
    description = json['description'];
    drAmt = json['dr_amt'];
    crAmt = json['cr_amt'];
    paymentType = json['payment_type'];
    cashAmt = json['cash_amt'];
    posAmt = json['pos_amt'];
    chequeAmt = json['cheque_amt'];
    onlineAmt = json['online_amt'];
    chequeNo = json['cheque_no'];
    chequeDate = json['cheque_date'];
    entryType = json['entry_type'];
    transectionId = json['transection_id'];
    bankBalance = json['bank_balance'];
    cashBalance = json['cash_balance'];
    personId = json['person_id'];
    personType = json['person_type'];
    linkId = json['link_id'];
    linkName = json['link_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referenceableId = json['referenceable_id'];
    referenceableType = json['referenceable_type'];
    personable = json['personable'] != null
        ? new Personable.fromJson(json['personable'])
        : null;
    referenceable = json['referenceable'] != null
        ? new Referenceable.fromJson(json['referenceable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_id'] = this.bankId;
    data['description'] = this.description;
    data['dr_amt'] = this.drAmt;
    data['cr_amt'] = this.crAmt;
    data['payment_type'] = this.paymentType;
    data['cash_amt'] = this.cashAmt;
    data['pos_amt'] = this.posAmt;
    data['cheque_amt'] = this.chequeAmt;
    data['online_amt'] = this.onlineAmt;
    data['cheque_no'] = this.chequeNo;
    data['cheque_date'] = this.chequeDate;
    data['entry_type'] = this.entryType;
    data['transection_id'] = this.transectionId;
    data['bank_balance'] = this.bankBalance;
    data['cash_balance'] = this.cashBalance;
    data['person_id'] = this.personId;
    data['person_type'] = this.personType;
    data['link_id'] = this.linkId;
    data['link_name'] = this.linkName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['referenceable_id'] = this.referenceableId;
    data['referenceable_type'] = this.referenceableType;
    if (this.personable != null) {
      data['personable'] = this.personable!.toJson();
    }
    if (this.referenceable != null) {
      data['referenceable'] = this.referenceable!.toJson();
    }
    return data;
  }
}

class Personable {
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
  int? branchId;

  Personable(
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
        this.branchId});

  Personable.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Referenceable {
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
  String? meterReading;
  String? supplierName;
  String? companyName;
  String? email;
  String? number;
  String? trnNo;
  String? itemNotes;
  String? address;
  String? country;
  String? state;
  String? city;
  String? zip;
  String? tag;
  String? openingBalance;
  String? name;
  String? emailVerifiedAt;
  int? roleId;
  int? isActive;
  String? firedAt;
  String? appVersion;
  String? firebaseToken;
  int? branchId;

  Referenceable(
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
        this.meterReading,
        this.supplierName,
        this.companyName,
        this.email,
        this.number,
        this.trnNo,
        this.itemNotes,
        this.address,
        this.country,
        this.state,
        this.city,
        this.zip,
        this.tag,
        this.openingBalance,
        this.name,
        this.emailVerifiedAt,
        this.roleId,
        this.isActive,
        this.firedAt,
        this.appVersion,
        this.firebaseToken,
        this.branchId});

  Referenceable.fromJson(Map<String, dynamic> json) {
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
    meterReading = json['meter_reading'];
    supplierName = json['supplier_name'];
    companyName = json['company_name'];
    email = json['email'];
    number = json['number'];
    trnNo = json['trn_no'];
    itemNotes = json['item_notes'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zip = json['zip'];
    tag = json['tag'];
    openingBalance = json['opening_balance'];
    name = json['name'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    isActive = json['is_active'];
    firedAt = json['fired_at'];
    appVersion = json['app_version'];
    firebaseToken = json['firebase_token'];
    branchId = json['branch_id'];
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
    data['meter_reading'] = this.meterReading;
    data['supplier_name'] = this.supplierName;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['number'] = this.number;
    data['trn_no'] = this.trnNo;
    data['item_notes'] = this.itemNotes;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['tag'] = this.tag;
    data['opening_balance'] = this.openingBalance;
    data['name'] = this.name;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['is_active'] = this.isActive;
    data['fired_at'] = this.firedAt;
    data['app_version'] = this.appVersion;
    data['firebase_token'] = this.firebaseToken;
    data['branch_id'] = this.branchId;
    return data;
  }
}
