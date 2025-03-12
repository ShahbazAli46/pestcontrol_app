class FollowUpsResponse {
  String? startDate;
  String? endDate;
  List<FollowUpsResponseData>? data;

  FollowUpsResponse({this.startDate, this.endDate, this.data});

  FollowUpsResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['data'] != null) {
      data = <FollowUpsResponseData>[];
      json['data'].forEach((v) {
        data!.add(new FollowUpsResponseData.fromJson(v));
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

class FollowUpsResponseData {
  int? id;
  int? userId;
  int? employeeId;
  int? userClientId;
  String? description;
  String? status;
  String? currentContractEndDate;
  String? visitDate;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? followUpDate;
  List<String>? images;
  int? clientAddressId;
  UserClient? userClient;
  ClientAddress? clientAddress;

  FollowUpsResponseData(
      {this.id,
        this.userId,
        this.employeeId,
        this.userClientId,
        this.description,
        this.status,
        this.currentContractEndDate,
        this.visitDate,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
        this.followUpDate,
        this.images,
        this.clientAddressId,
        this.userClient,
        this.clientAddress});

  FollowUpsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    userClientId = json['user_client_id'];
    description = json['description'];
    status = json['status'];
    currentContractEndDate = json['current_contract_end_date'];
    visitDate = json['visit_date'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    followUpDate = json['follow_up_date'];
    images = json['images'].cast<String>();
    clientAddressId = json['client_address_id'];
    userClient = json['user_client'] != null
        ? new UserClient.fromJson(json['user_client'])
        : null;
    clientAddress = json['client_address'] != null
        ? new ClientAddress.fromJson(json['client_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['user_client_id'] = this.userClientId;
    data['description'] = this.description;
    data['status'] = this.status;
    data['current_contract_end_date'] = this.currentContractEndDate;
    data['visit_date'] = this.visitDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['follow_up_date'] = this.followUpDate;
    data['images'] = this.images;
    data['client_address_id'] = this.clientAddressId;
    if (this.userClient != null) {
      data['user_client'] = this.userClient!.toJson();
    }
    if (this.clientAddress != null) {
      data['client_address'] = this.clientAddress!.toJson();
    }
    return data;
  }
}

class UserClient {
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
  Client? client;

  UserClient(
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
        this.branchId,
        this.client});

  UserClient.fromJson(Map<String, dynamic> json) {
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
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
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
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }
}

class Client {
  int? id;
  int? userId;
  int? roleId;
  String? firmName;
  String? phoneNumber;
  String? mobileNumber;
  String? industryName;
  String? referencableType;
  int? referencableId;
  String? openingBalance;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Client(
      {this.id,
        this.userId,
        this.roleId,
        this.firmName,
        this.phoneNumber,
        this.mobileNumber,
        this.industryName,
        this.referencableType,
        this.referencableId,
        this.openingBalance,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    roleId = json['role_id'];
    firmName = json['firm_name'];
    phoneNumber = json['phone_number'];
    mobileNumber = json['mobile_number'];
    industryName = json['industry_name'];
    referencableType = json['referencable_type'];
    referencableId = json['referencable_id'];
    openingBalance = json['opening_balance'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['firm_name'] = this.firmName;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['industry_name'] = this.industryName;
    data['referencable_type'] = this.referencableType;
    data['referencable_id'] = this.referencableId;
    data['opening_balance'] = this.openingBalance;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ClientAddress {
  int? id;
  int? clientId;
  int? userId;
  String? address;
  String? city;
  String? lat;
  String? lang;
  String? country;
  String? state;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? area;

  ClientAddress(
      {this.id,
        this.clientId,
        this.userId,
        this.address,
        this.city,
        this.lat,
        this.lang,
        this.country,
        this.state,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.area});

  ClientAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    userId = json['user_id'];
    address = json['address'];
    city = json['city'];
    lat = json['lat'];
    lang = json['lang'];
    country = json['country'];
    state = json['state'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['country'] = this.country;
    data['state'] = this.state;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['area'] = this.area;
    return data;
  }
}
