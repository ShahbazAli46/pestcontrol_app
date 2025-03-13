class JobDetailsResponse {
  JobDetailsResponseData? data;

  JobDetailsResponse({this.data});

  JobDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new JobDetailsResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class JobDetailsResponseData {
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
  List<TreatmentMethods>? treatmentMethods;
  List<TeamMembers>? teamMembers;
  TeamMembers? captain;
  User? user;
  TermAndCondition? termAndCondition;
  List<JobServices>? jobServices;
  List<RescheduleDates>? rescheduleDates;
  ClientAddress? clientAddress;


  JobDetailsResponseData(
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
        this.treatmentMethods,
        this.teamMembers,
        this.user,
        this.termAndCondition,
        this.jobServices,
        this.captain,
        this.rescheduleDates,
        this.clientAddress});

  JobDetailsResponseData.fromJson(Map<String, dynamic> json) {
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
    captain = json['captain'] != null
        ? new TeamMembers.fromJson(json['captain'])
        : null;
    if (json['treatment_methods'] != null) {
      treatmentMethods = <TreatmentMethods>[];
      json['treatment_methods'].forEach((v) {
        treatmentMethods!.add(new TreatmentMethods.fromJson(v));
      });
    }
    if (json['team_members'] != null) {
      teamMembers = <TeamMembers>[];
      json['team_members'].forEach((v) {
        teamMembers!.add(new TeamMembers.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    termAndCondition = json['term_and_condition'] != null
        ? new TermAndCondition.fromJson(json['term_and_condition'])
        : null;
    if (json['job_services'] != null) {
      jobServices = <JobServices>[];
      json['job_services'].forEach((v) {
        jobServices!.add(new JobServices.fromJson(v));
      });
    }
    if (json['reschedule_dates'] != null) {
      rescheduleDates = <RescheduleDates>[];
      json['reschedule_dates'].forEach((v) {
        rescheduleDates!.add(new RescheduleDates.fromJson(v));
      });
    }
    clientAddress = json['client_address'] != null
        ? new ClientAddress.fromJson(json['client_address'])
        : null;
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
    if (this.treatmentMethods != null) {
      data['treatment_methods'] =
          this.treatmentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.teamMembers != null) {
      data['team_members'] = this.teamMembers!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.termAndCondition != null) {
      data['term_and_condition'] = this.termAndCondition!.toJson();
    }
    if (this.jobServices != null) {
      data['job_services'] = this.jobServices!.map((v) => v.toJson()).toList();
    }
    if (this.rescheduleDates != null) {
      data['reschedule_dates'] =
          this.rescheduleDates!.map((v) => v.toJson()).toList();
    }
    if (this.clientAddress != null) {
      data['client_address'] = this.clientAddress!.toJson();
    }
    return data;
  }
}

class TreatmentMethods {
  int? id;
  String? name;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  TreatmentMethods(
      {this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  TreatmentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TeamMembers {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  int? isActive;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Employee? employee;

  TeamMembers(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.employee});

  TeamMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
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
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class Employee {
  int? id;
  int? userId;
  int? roleId;
  String? profileImage;
  String? phoneNumber;
  String? eidNo;
  String? target;
  String? eidStart;
  String? eidExpiry;
  String? profession;
  String? passportNo;
  String? passportStart;
  String? passportExpiry;
  String? hiStatus;
  String? hiStart;
  String? hiExpiry;
  String? uiStatus;
  String? uiStart;
  String? uiExpiry;
  String? dmCard;
  String? dmStart;
  String? dmExpiry;
  String? relativeName;
  String? relation;
  String? emergencyContact;
  String? basicSalary;
  String? allowance;
  String? other;
  String? totalSalary;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Employee(
      {this.id,
        this.userId,
        this.roleId,
        this.profileImage,
        this.phoneNumber,
        this.eidNo,
        this.target,
        this.eidStart,
        this.eidExpiry,
        this.profession,
        this.passportNo,
        this.passportStart,
        this.passportExpiry,
        this.hiStatus,
        this.hiStart,
        this.hiExpiry,
        this.uiStatus,
        this.uiStart,
        this.uiExpiry,
        this.dmCard,
        this.dmStart,
        this.dmExpiry,
        this.relativeName,
        this.relation,
        this.emergencyContact,
        this.basicSalary,
        this.allowance,
        this.other,
        this.totalSalary,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    roleId = json['role_id'];
    profileImage = json['profile_image'];
    phoneNumber = json['phone_number'];
    eidNo = json['eid_no'];
    target = json['target'];
    eidStart = json['eid_start'];
    eidExpiry = json['eid_expiry'];
    profession = json['profession'];
    passportNo = json['passport_no'];
    passportStart = json['passport_start'];
    passportExpiry = json['passport_expiry'];
    hiStatus = json['hi_status'];
    hiStart = json['hi_start'];
    hiExpiry = json['hi_expiry'];
    uiStatus = json['ui_status'];
    uiStart = json['ui_start'];
    uiExpiry = json['ui_expiry'];
    dmCard = json['dm_card'];
    dmStart = json['dm_start'];
    dmExpiry = json['dm_expiry'];
    relativeName = json['relative_name'];
    relation = json['relation'];
    emergencyContact = json['emergency_contact'];
    basicSalary = json['basic_salary'];
    allowance = json['allowance'];
    other = json['other'];
    totalSalary = json['total_salary'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['profile_image'] = this.profileImage;
    data['phone_number'] = this.phoneNumber;
    data['eid_no'] = this.eidNo;
    data['target'] = this.target;
    data['eid_start'] = this.eidStart;
    data['eid_expiry'] = this.eidExpiry;
    data['profession'] = this.profession;
    data['passport_no'] = this.passportNo;
    data['passport_start'] = this.passportStart;
    data['passport_expiry'] = this.passportExpiry;
    data['hi_status'] = this.hiStatus;
    data['hi_start'] = this.hiStart;
    data['hi_expiry'] = this.hiExpiry;
    data['ui_status'] = this.uiStatus;
    data['ui_start'] = this.uiStart;
    data['ui_expiry'] = this.uiExpiry;
    data['dm_card'] = this.dmCard;
    data['dm_start'] = this.dmStart;
    data['dm_expiry'] = this.dmExpiry;
    data['relative_name'] = this.relativeName;
    data['relation'] = this.relation;
    data['emergency_contact'] = this.emergencyContact;
    data['basic_salary'] = this.basicSalary;
    data['allowance'] = this.allowance;
    data['other'] = this.other;
    data['total_salary'] = this.totalSalary;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  int? branchId;
  Client? client;
  List<ClientInspectionReports>? clientInspectionReports;

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
        this.client,
        this.clientInspectionReports});

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
    if (json['client_inspection_reports'] != null) {
      clientInspectionReports = <ClientInspectionReports>[];
      json['client_inspection_reports'].forEach((v) {
        clientInspectionReports!.add(new ClientInspectionReports.fromJson(v));
      });
    }
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
    if (this.clientInspectionReports != null) {
      data['client_inspection_reports'] =
          this.clientInspectionReports!.map((v) => v.toJson()).toList();
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
  String? emailVerifiedAt;
  int? roleId;
  int? isActive;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Referencable(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

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
        this.updatedAt});

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
    return data;
  }
}


class ClientInspectionReports {
  int? id;
  int? userClientId;
  String? clientRemarks;
  String? inspectionRemarks;
  String? recommendationForOperation;
  String? generalComment;
  List<String>? pictures;
  String? nestingArea;
  int? userId;
  int? employeeId;
  String? createdAt;
  String? updatedAt;

  ClientInspectionReports(
      {this.id,
        this.userClientId,
        this.clientRemarks,
        this.inspectionRemarks,
        this.recommendationForOperation,
        this.generalComment,
        this.pictures,
        this.nestingArea,
        this.userId,
        this.employeeId,
        this.createdAt,
        this.updatedAt});

  ClientInspectionReports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userClientId = json['user_client_id'];
    clientRemarks = json['client_remarks'];
    inspectionRemarks = json['inspection_remarks'];
    recommendationForOperation = json['recommendation_for_operation'];
    generalComment = json['general_comment'];
    pictures = json['pictures'].cast<String>();
    nestingArea = json['nesting_area'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_client_id'] = this.userClientId;
    data['client_remarks'] = this.clientRemarks;
    data['inspection_remarks'] = this.inspectionRemarks;
    data['recommendation_for_operation'] = this.recommendationForOperation;
    data['general_comment'] = this.generalComment;
    data['pictures'] = this.pictures;
    data['nesting_area'] = this.nestingArea;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
