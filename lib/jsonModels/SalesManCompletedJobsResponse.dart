class SalesManCompletedJobsResponse {
  String? startDate;
  String? endDate;
  List<SalesManCompletedJobsResponseData>? data;

  SalesManCompletedJobsResponse({this.startDate, this.endDate, this.data});

  SalesManCompletedJobsResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['data'] != null) {
      data = <SalesManCompletedJobsResponseData>[];
      json['data'].forEach((v) {
        data!.add(new SalesManCompletedJobsResponseData.fromJson(v));
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

class SalesManCompletedJobsResponseData {
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
  List<RescheduleDates>? rescheduleDates;
  TermAndCondition? termAndCondition;
  ClientAddress? clientAddress;
  Captain? captain;
  List<JobServices>? jobServices;

  SalesManCompletedJobsResponseData(
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
        this.rescheduleDates,
        this.termAndCondition,
        this.clientAddress,
        this.captain,
        this.jobServices});

  SalesManCompletedJobsResponseData.fromJson(Map<String, dynamic> json) {
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
    if (json['reschedule_dates'] != null) {
      rescheduleDates = <RescheduleDates>[];
      json['reschedule_dates'].forEach((v) {
        rescheduleDates!.add(new RescheduleDates.fromJson(v));
      });
    }
    termAndCondition = json['term_and_condition'] != null
        ? new TermAndCondition.fromJson(json['term_and_condition'])
        : null;
    clientAddress = json['client_address'] != null
        ? new ClientAddress.fromJson(json['client_address'])
        : null;
    captain =
    json['captain'] != null ? new Captain.fromJson(json['captain']) : null;
    if (json['job_services'] != null) {
      jobServices = <JobServices>[];
      json['job_services'].forEach((v) {
        jobServices!.add(new JobServices.fromJson(v));
      });
    }
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
    if (this.rescheduleDates != null) {
      data['reschedule_dates'] =
          this.rescheduleDates!.map((v) => v.toJson()).toList();
    }
    if (this.termAndCondition != null) {
      data['term_and_condition'] = this.termAndCondition!.toJson();
    }
    if (this.clientAddress != null) {
      data['client_address'] = this.clientAddress!.toJson();
    }
    if (this.captain != null) {
      data['captain'] = this.captain!.toJson();
    }
    if (this.jobServices != null) {
      data['job_services'] = this.jobServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
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
  String? branchId;
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
        this.appVersion,
        this.firebaseToken,
        this.branchId,
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

class RescheduleDates {
  int? id;
  int? jobId;
  String? jobDate;
  String? reason;
  String? createdAt;
  String? updatedAt;

  RescheduleDates(
      {this.id,
        this.jobId,
        this.jobDate,
        this.reason,
        this.createdAt,
        this.updatedAt});

  RescheduleDates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    jobDate = json['job_date'];
    reason = json['reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['job_date'] = this.jobDate;
    data['reason'] = this.reason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TermAndCondition {
  int? id;
  String? name;
  String? text;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  TermAndCondition(
      {this.id,
        this.name,
        this.text,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  TermAndCondition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    text = json['text'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['text'] = this.text;
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

class Captain {
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

  Captain(
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

  Captain.fromJson(Map<String, dynamic> json) {
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

class JobServices {
  int? id;
  int? jobId;
  int? serviceId;
  String? rate;
  String? subTotal;
  int? quoteId;
  String? createdAt;
  String? updatedAt;
  Service? service;

  JobServices(
      {this.id,
        this.jobId,
        this.serviceId,
        this.rate,
        this.subTotal,
        this.quoteId,
        this.createdAt,
        this.updatedAt,
        this.service});

  JobServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    serviceId = json['service_id'];
    rate = json['rate'];
    subTotal = json['sub_total'];
    quoteId = json['quote_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['service_id'] = this.serviceId;
    data['rate'] = this.rate;
    data['sub_total'] = this.subTotal;
    data['quote_id'] = this.quoteId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Service {
  int? id;
  String? pestName;
  String? serviceTitle;
  String? termAndConditions;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Service(
      {this.id,
        this.pestName,
        this.serviceTitle,
        this.termAndConditions,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pestName = json['pest_name'];
    serviceTitle = json['service_title'];
    termAndConditions = json['term_and_conditions'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pest_name'] = this.pestName;
    data['service_title'] = this.serviceTitle;
    data['term_and_conditions'] = this.termAndConditions;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
