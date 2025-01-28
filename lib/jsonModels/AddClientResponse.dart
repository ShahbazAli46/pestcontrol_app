class AddClientResponse {
  String? status;
  String? message;
  Data? data;

  AddClientResponse({this.status, this.message, this.data});

  AddClientResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  int? roleId;
  String? createdAt;
  String? updatedAt;
  Client? client;

  Data(
      {this.id,
        this.name,
        this.email,
        this.roleId,
        this.createdAt,
        this.updatedAt,
        this.client});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }
}

class Client {
  int? id;
  String? phoneNumber;
  String? mobileNumber;
  String? firmName;
  String? industryName;
  String? referencableId;
  String? referencableType;

  int? roleId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Client(
      {this.id,
        this.phoneNumber,
        this.mobileNumber,
        this.firmName,
        this.industryName,
        this.referencableId,
        this.referencableType,
        this.roleId,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
    mobileNumber = json['mobile_number'];
    firmName = json['firm_name'];
    industryName = json['industry_name'];
    referencableId = "${json['referencable_id']}";
    referencableType = json['referencable_type'];
    roleId = json['role_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['firm_name'] = this.firmName;
    data['industry_name'] = this.industryName;
    data['referencable_id'] = this.referencableId;
    data['referencable_type'] = this.referencableType;
    data['role_id'] = this.roleId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
