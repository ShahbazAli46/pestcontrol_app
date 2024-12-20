class AllSuppliersResponse {
  List<AllSuppliersResponseData>? data;

  AllSuppliersResponse({this.data});

  AllSuppliersResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllSuppliersResponseData>[];
      json['data'].forEach((v) {
        data!.add(new AllSuppliersResponseData.fromJson(v));
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

class AllSuppliersResponseData {
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

  AllSuppliersResponseData(
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
        this.balance});

  AllSuppliersResponseData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
