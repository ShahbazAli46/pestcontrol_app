class PaymentFollowUpsResponse {
  String? startDate;
  String? endDate;
  List<PaymentFollowUpsResponseData>? data;

  PaymentFollowUpsResponse({this.startDate, this.endDate, this.data});

  PaymentFollowUpsResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['data'] != null) {
      data = <PaymentFollowUpsResponseData>[];
      json['data'].forEach((v) {
        data!.add(new PaymentFollowUpsResponseData.fromJson(v));
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

class PaymentFollowUpsResponseData {
  int? id;
  int? clientUserId;
  int? clientId;
  String? completedAt;
  String? createdAt;
  String? updatedAt;
  List<ClientFollowDetailUps>? clientFollowDetailUps;
  ClientUser? clientUser;

  PaymentFollowUpsResponseData(
      {this.id,
        this.clientUserId,
        this.clientId,
        this.completedAt,
        this.createdAt,
        this.updatedAt,
        this.clientFollowDetailUps,
        this.clientUser});

  PaymentFollowUpsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientUserId = json['client_user_id'];
    clientId = json['client_id'];
    completedAt = json['completed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['client_follow_detail_ups'] != null) {
      clientFollowDetailUps = <ClientFollowDetailUps>[];
      json['client_follow_detail_ups'].forEach((v) {
        clientFollowDetailUps!.add(new ClientFollowDetailUps.fromJson(v));
      });
    }
    clientUser = json['client_user'] != null
        ? new ClientUser.fromJson(json['client_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_user_id'] = this.clientUserId;
    data['client_id'] = this.clientId;
    data['completed_at'] = this.completedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.clientFollowDetailUps != null) {
      data['client_follow_detail_ups'] =
          this.clientFollowDetailUps!.map((v) => v.toJson()).toList();
    }
    if (this.clientUser != null) {
      data['client_user'] = this.clientUser!.toJson();
    }
    return data;
  }
}

class ClientFollowDetailUps {
  int? id;
  int? clientFollowUpId;
  int? employeeUserId;
  int? clientId;
  int? clientUserId;
  String? responseType;
  String? promiseDate;
  String? latitude;
  String? longitude;
  String? other;
  String? createdAt;
  String? updatedAt;
  String? nextPromiseDate;
  EmployeeUser? employeeUser;

  ClientFollowDetailUps(
      {this.id,
        this.clientFollowUpId,
        this.employeeUserId,
        this.clientId,
        this.clientUserId,
        this.responseType,
        this.promiseDate,
        this.latitude,
        this.longitude,
        this.other,
        this.createdAt,
        this.updatedAt,
        this.nextPromiseDate,
        this.employeeUser});

  ClientFollowDetailUps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientFollowUpId = json['client_follow_up_id'];
    employeeUserId = json['employee_user_id'];
    clientId = json['client_id'];
    clientUserId = json['client_user_id'];
    responseType = json['response_type'];
    promiseDate = json['promise_date'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    other = json['other'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nextPromiseDate = json['next_promise_date'];
    employeeUser = json['employee_user'] != null
        ? new EmployeeUser.fromJson(json['employee_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_follow_up_id'] = this.clientFollowUpId;
    data['employee_user_id'] = this.employeeUserId;
    data['client_id'] = this.clientId;
    data['client_user_id'] = this.clientUserId;
    data['response_type'] = this.responseType;
    data['promise_date'] = this.promiseDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['other'] = this.other;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['next_promise_date'] = this.nextPromiseDate;
    if (this.employeeUser != null) {
      data['employee_user'] = this.employeeUser!.toJson();
    }
    return data;
  }
}

class EmployeeUser {
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
  String? appVersion;
  String? firebaseToken;
  int? branchId;

  EmployeeUser(
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

  EmployeeUser.fromJson(Map<String, dynamic> json) {
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

class ClientUser {
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
  Null? appVersion;
  Null? firebaseToken;
  Null? branchId;
  Client? client;

  ClientUser(
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

  ClientUser.fromJson(Map<String, dynamic> json) {
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
  String? promiseDate;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  EmployeeUser? referencable;

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
        this.promiseDate,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.referencable});

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
    promiseDate = json['promise_date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referencable = json['referencable'] != null
        ? new EmployeeUser.fromJson(json['referencable'])
        : null;
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
    data['promise_date'] = this.promiseDate;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.referencable != null) {
      data['referencable'] = this.referencable!.toJson();
    }
    return data;
  }


}


class FollowUpInfo {
  final String salesMan;
  final String firmName;
  final String recoveryPersonName;
  final String followUpDate;
  final String nextFollowUpDate;
  final String latlong;
  final String status;
  final int salesManId;
  final String desc;

  FollowUpInfo({
    required this.salesMan,
    required this.firmName,
    required this.recoveryPersonName,
    required this.followUpDate,
    required this.nextFollowUpDate,
    required this.latlong,
    required this.status,
    required this.salesManId,
    required this.desc
  });
}