class SupplierInfoResponse {
  SupplierInfoResponseData? data;

  SupplierInfoResponse({this.data});

  SupplierInfoResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupplierInfoResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupplierInfoResponseData {
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
  String? balance;
  List<BankInfos>? bankInfos;

  SupplierInfoResponseData(
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
        this.balance,
        this.bankInfos});

  SupplierInfoResponseData.fromJson(Map<String, dynamic> json) {
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
    balance = json['balance'];
    if (json['bank_infos'] != null) {
      bankInfos = <BankInfos>[];
      json['bank_infos'].forEach((v) {
        bankInfos!.add(new BankInfos.fromJson(v));
      });
    }
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
    data['balance'] = this.balance;
    if (this.bankInfos != null) {
      data['bank_infos'] = this.bankInfos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankInfos {
  int? id;
  String? bankName;
  String? iban;
  String? accountNumber;
  String? address;
  int? linkableId;
  String? linkableType;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  BankInfos(
      {this.id,
        this.bankName,
        this.iban,
        this.accountNumber,
        this.address,
        this.linkableId,
        this.linkableType,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  BankInfos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    iban = json['iban'];
    accountNumber = json['account_number'];
    address = json['address'];
    linkableId = json['linkable_id'];
    linkableType = json['linkable_type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_name'] = this.bankName;
    data['iban'] = this.iban;
    data['account_number'] = this.accountNumber;
    data['address'] = this.address;
    data['linkable_id'] = this.linkableId;
    data['linkable_type'] = this.linkableType;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
