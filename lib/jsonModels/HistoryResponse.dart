class HistoryResponse {
  String? startDate;
  String? endDate;
  List<HistoryData>? data;

  HistoryResponse({this.startDate, this.endDate, this.data});

  HistoryResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['data'] != null) {
      data = <HistoryData>[];
      json['data'].forEach((v) {
        data!.add(new HistoryData.fromJson(v));
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

class HistoryData {
  int? id;
  int? userId;
  String? jobTitle;
  int? clientAddressId;
  String? subject;
  String? serviceIds;
  String? tmIds;
  String? description;
  String? trn;
  String? tag;
  int? isFoodWatchAccount;
  String? jobDate;
  String? priority;
  String? subTotal;
  String? disPer;
  String? disAmt;
  String? vatPer;
  String? vatAmt;
  String? grandTotal;
  int? isCompleted;
  int? isModified;
  int? captainId;
  String? teamMemberIds;
  String? jobInstructions;
  int? termAndConditionId;
  int? quoteId;
  String? createdAt;
  String? updatedAt;
  String? jobStartTime;
  String? jobEndTime;
  User? user;
  Referencable? captain;
  Report? report;

  HistoryData(
      {this.id,
        this.userId,
        this.jobTitle,
        this.clientAddressId,
        this.subject,
        this.serviceIds,
        this.tmIds,
        this.description,
        this.trn,
        this.tag,
        this.isFoodWatchAccount,
        this.jobDate,
        this.priority,
        this.subTotal,
        this.disPer,
        this.disAmt,
        this.vatPer,
        this.vatAmt,
        this.grandTotal,
        this.isCompleted,
        this.isModified,
        this.captainId,
        this.teamMemberIds,
        this.jobInstructions,
        this.termAndConditionId,
        this.quoteId,
        this.createdAt,
        this.updatedAt,
        this.jobStartTime,
        this.jobEndTime,
        this.user,
        this.captain,
        this.report});

  HistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    jobTitle = json['job_title'];
    clientAddressId = json['client_address_id'];
    subject = json['subject'];
    serviceIds = json['service_ids'];
    tmIds = json['tm_ids'];
    description = json['description'];
    trn = json['trn'];
    tag = json['tag'];
    isFoodWatchAccount = json['is_food_watch_account'];
    jobDate = json['job_date'];
    priority = json['priority'];
    subTotal = json['sub_total'];
    disPer = json['dis_per'];
    disAmt = json['dis_amt'];
    vatPer = json['vat_per'];
    vatAmt = json['vat_amt'];
    grandTotal = json['grand_total'];
    isCompleted = json['is_completed'];
    isModified = json['is_modified'];
    captainId = json['captain_id'];
    teamMemberIds = json['team_member_ids'];
    jobInstructions = json['job_instructions'];
    termAndConditionId = json['term_and_condition_id'];
    quoteId = json['quote_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    jobStartTime = json['job_start_time'];
    jobEndTime = json['job_end_time'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    captain = json['captain'] != null
        ? new Referencable.fromJson(json['captain'])
        : null;
    report =
    json['report'] != null ? new Report.fromJson(json['report']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['job_title'] = this.jobTitle;
    data['client_address_id'] = this.clientAddressId;
    data['subject'] = this.subject;
    data['service_ids'] = this.serviceIds;
    data['tm_ids'] = this.tmIds;
    data['description'] = this.description;
    data['trn'] = this.trn;
    data['tag'] = this.tag;
    data['is_food_watch_account'] = this.isFoodWatchAccount;
    data['job_date'] = this.jobDate;
    data['priority'] = this.priority;
    data['sub_total'] = this.subTotal;
    data['dis_per'] = this.disPer;
    data['dis_amt'] = this.disAmt;
    data['vat_per'] = this.vatPer;
    data['vat_amt'] = this.vatAmt;
    data['grand_total'] = this.grandTotal;
    data['is_completed'] = this.isCompleted;
    data['is_modified'] = this.isModified;
    data['captain_id'] = this.captainId;
    data['team_member_ids'] = this.teamMemberIds;
    data['job_instructions'] = this.jobInstructions;
    data['term_and_condition_id'] = this.termAndConditionId;
    data['quote_id'] = this.quoteId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['job_start_time'] = this.jobStartTime;
    data['job_end_time'] = this.jobEndTime;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.captain != null) {
      data['captain'] = this.captain!.toJson();
    }
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    return data;
  }
}

class User {
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
  Client? client;

  User(
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
        this.client});

  User.fromJson(Map<String, dynamic> json) {
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
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Referencable? referencable;

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
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referencable = json['referencable'] != null
        ? new Referencable.fromJson(json['referencable'])
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
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.referencable != null) {
      data['referencable'] = this.referencable!.toJson();
    }
    return data;
  }
}

class Referencable {
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

  Referencable(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.firedAt});

  Referencable.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Report {
  int? id;
  int? jobId;

  Report({this.id, this.jobId});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    return data;
  }
}
