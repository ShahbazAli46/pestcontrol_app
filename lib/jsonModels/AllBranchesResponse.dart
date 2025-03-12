class AllBranchesResponse {
  List<AllBranchesResponseData>? data;

  AllBranchesResponse({this.data});

  AllBranchesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllBranchesResponseData>[];
      json['data'].forEach((v) {
        data!.add(new AllBranchesResponseData.fromJson(v));
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

class AllBranchesResponseData {
  int? id;
  String? name;
  String? address;
  String? phone;
  String? email;
  String? createdAt;
  String? updatedAt;

  AllBranchesResponseData(
      {this.id,
        this.name,
        this.address,
        this.phone,
        this.email,
        this.createdAt,
        this.updatedAt});

  AllBranchesResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
