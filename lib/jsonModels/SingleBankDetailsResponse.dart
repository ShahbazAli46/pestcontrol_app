class SingleBankDetailsResponse {
  String? startDate;
  String? endDate;
  SingleBankDetailsResponseData? data;

  SingleBankDetailsResponse({this.startDate, this.endDate, this.data});

  SingleBankDetailsResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    data = json['data'] != null ? new SingleBankDetailsResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SingleBankDetailsResponseData {
  int? id;
  String? bankName;
  String? balance;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<SingleBankDetailsResponseDataLedgers>? ledgers;

  SingleBankDetailsResponseData(
      {this.id,
        this.bankName,
        this.balance,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.ledgers});

  SingleBankDetailsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    balance = json['balance'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['ledgers'] != null) {
      ledgers = <SingleBankDetailsResponseDataLedgers>[];
      json['ledgers'].forEach((v) {
        ledgers!.add(new SingleBankDetailsResponseDataLedgers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_name'] = this.bankName;
    data['balance'] = this.balance;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.ledgers != null) {
      data['ledgers'] = this.ledgers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SingleBankDetailsResponseDataLedgers {
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
  Referenceable? referenceable;

  SingleBankDetailsResponseDataLedgers(
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
        this.referenceable});

  SingleBankDetailsResponseDataLedgers.fromJson(Map<String, dynamic> json) {
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
    if (this.referenceable != null) {
      data['referenceable'] = this.referenceable!.toJson();
    }
    return data;
  }
}

class Referenceable {
  int? id;
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
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? emailVerifiedAt;
  int? roleId;
  int? isActive;
  String? firedAt;
  String? appVersion;
  String? firebaseToken;
  int? bankId;
  int? expenseCategoryId;
  String? expenseName;
  String? paymentType;
  String? amount;
  String? chequeNo;
  String? chequeDate;
  String? transectionId;
  String? vatPer;
  String? vatAmount;
  String? description;
  String? totalAmount;
  String? expenseFile;
  String? expenseDate;

  Referenceable(
      {this.id,
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
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.emailVerifiedAt,
        this.roleId,
        this.isActive,
        this.firedAt,
        this.appVersion,
        this.firebaseToken,
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
        this.expenseDate});

  Referenceable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    isActive = json['is_active'];
    firedAt = json['fired_at'];
    appVersion = json['app_version'];
    firebaseToken = json['firebase_token'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['is_active'] = this.isActive;
    data['fired_at'] = this.firedAt;
    data['app_version'] = this.appVersion;
    data['firebase_token'] = this.firebaseToken;
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
    return data;
  }
}
