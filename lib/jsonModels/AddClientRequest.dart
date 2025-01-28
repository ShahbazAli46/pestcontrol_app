class AddClientRequest {
  String? name;
  String? email;
  String? phoneNumber;
  String? mobileNumber;
  String? firmName;
  String? industryName;
  String? referencableId;
  String? referencableType;
  String? openingBalance;

  AddClientRequest(
      {this.name,
        this.email,
        this.phoneNumber,
        this.mobileNumber,
        this.firmName,
        this.industryName,
        this.referencableId,
        this.referencableType,
        this.openingBalance});

  AddClientRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    mobileNumber = json['mobile_number'];
    firmName = json['firm_name'];
    industryName = json['industry_name'];
    referencableId = json['referencable_id'];
    referencableType = json['referencable_type'];
    openingBalance = json['opening_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['firm_name'] = this.firmName;
    data['industry_name'] = this.industryName;
    data['referencable_id'] = this.referencableId;
    data['referencable_type'] = this.referencableType;
    data['opening_balance'] = this.openingBalance;
    return data;
  }
}
