class AllBanksReponse {
  List<BankData>? data;

  AllBanksReponse({this.data});

  AllBanksReponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BankData>[];
      json['data'].forEach((v) {
        data!.add(new BankData.fromJson(v));
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

class BankData {
  int? id;
  String? bankName;
  String? balance;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  BankData(
      {this.id,
        this.bankName,
        this.balance,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  BankData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    balance = json['balance'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_name'] = this.bankName;
    data['balance'] = this.balance;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
