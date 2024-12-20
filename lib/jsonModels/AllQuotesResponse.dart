class AllQuotesResponse {
  String? type;
  List<AllQuotesResponseData>? data;

  AllQuotesResponse({this.type, this.data});

  AllQuotesResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['data'] != null) {
      data = <AllQuotesResponseData>[];
      json['data'].forEach((v) {
        data!.add(new AllQuotesResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllQuotesResponseData {
  int? id;
  int? userId;
  String? quoteTitle;
  int? clientAddressId;
  String? subject;
  String? serviceIds;
  String? tmIds;
  String? description;
  String? trn;
  String? tag;
  int? durationInMonths;
  int? isFoodWatchAccount;
  String? billingMethod;
  int? noOfInstallments;
  String? subTotal;
  String? disPer;
  String? disAmt;
  String? vatPer;
  String? vatAmt;
  String? grandTotal;
  String? contractStartDate;
  String? contractEndDate;
  int? isContracted;
  int? termAndConditionId;
  String? createdAt;
  String? updatedAt;
  int? clientId;
  List<TreatmentMethods>? treatmentMethods;
  User? user;
  List<QuoteServices>? quoteServices;

  AllQuotesResponseData(
      {this.id,
        this.userId,
        this.quoteTitle,
        this.clientAddressId,
        this.subject,
        this.serviceIds,
        this.tmIds,
        this.description,
        this.trn,
        this.tag,
        this.durationInMonths,
        this.isFoodWatchAccount,
        this.billingMethod,
        this.noOfInstallments,
        this.subTotal,
        this.disPer,
        this.disAmt,
        this.vatPer,
        this.vatAmt,
        this.grandTotal,
        this.contractStartDate,
        this.contractEndDate,
        this.isContracted,
        this.termAndConditionId,
        this.createdAt,
        this.updatedAt,
        this.clientId,
        this.treatmentMethods,
        this.user,
        this.quoteServices});

  AllQuotesResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    quoteTitle = json['quote_title'];
    clientAddressId = json['client_address_id'];
    subject = json['subject'];
    serviceIds = json['service_ids'];
    tmIds = json['tm_ids'];
    description = json['description'];
    trn = json['trn'];
    tag = json['tag'];
    durationInMonths = json['duration_in_months'];
    isFoodWatchAccount = json['is_food_watch_account'];
    billingMethod = json['billing_method'];
    noOfInstallments = json['no_of_installments'];
    subTotal = json['sub_total'];
    disPer = json['dis_per'];
    disAmt = json['dis_amt'];
    vatPer = json['vat_per'];
    vatAmt = json['vat_amt'];
    grandTotal = json['grand_total'];
    contractStartDate = json['contract_start_date'];
    contractEndDate = json['contract_end_date'];
    isContracted = json['is_contracted'];
    termAndConditionId = json['term_and_condition_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    clientId = json['client_id'];
    if (json['treatment_methods'] != null) {
      treatmentMethods = <TreatmentMethods>[];
      json['treatment_methods'].forEach((v) {
        treatmentMethods!.add(new TreatmentMethods.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['quote_services'] != null) {
      quoteServices = <QuoteServices>[];
      json['quote_services'].forEach((v) {
        quoteServices!.add(new QuoteServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['quote_title'] = this.quoteTitle;
    data['client_address_id'] = this.clientAddressId;
    data['subject'] = this.subject;
    data['service_ids'] = this.serviceIds;
    data['tm_ids'] = this.tmIds;
    data['description'] = this.description;
    data['trn'] = this.trn;
    data['tag'] = this.tag;
    data['duration_in_months'] = this.durationInMonths;
    data['is_food_watch_account'] = this.isFoodWatchAccount;
    data['billing_method'] = this.billingMethod;
    data['no_of_installments'] = this.noOfInstallments;
    data['sub_total'] = this.subTotal;
    data['dis_per'] = this.disPer;
    data['dis_amt'] = this.disAmt;
    data['vat_per'] = this.vatPer;
    data['vat_amt'] = this.vatAmt;
    data['grand_total'] = this.grandTotal;
    data['contract_start_date'] = this.contractStartDate;
    data['contract_end_date'] = this.contractEndDate;
    data['is_contracted'] = this.isContracted;
    data['term_and_condition_id'] = this.termAndConditionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['client_id'] = this.clientId;
    if (this.treatmentMethods != null) {
      data['treatment_methods'] =
          this.treatmentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.quoteServices != null) {
      data['quote_services'] =
          this.quoteServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TreatmentMethods {
  int? id;
  String? name;
  Null? deletedAt;
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

class QuoteServices {
  int? id;
  int? quoteId;
  int? serviceId;
  int? noOfServices;
  String? jobType;
  String? rate;
  String? subTotal;
  String? createdAt;
  String? updatedAt;
  Service? service;
  List<QuoteServiceDates>? quoteServiceDates;

  QuoteServices(
      {this.id,
        this.quoteId,
        this.serviceId,
        this.noOfServices,
        this.jobType,
        this.rate,
        this.subTotal,
        this.createdAt,
        this.updatedAt,
        this.service,
        this.quoteServiceDates});

  QuoteServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quoteId = json['quote_id'];
    serviceId = json['service_id'];
    noOfServices = json['no_of_services'];
    jobType = json['job_type'];
    rate = json['rate'];
    subTotal = json['sub_total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    if (json['quote_service_dates'] != null) {
      quoteServiceDates = <QuoteServiceDates>[];
      json['quote_service_dates'].forEach((v) {
        quoteServiceDates!.add(new QuoteServiceDates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quote_id'] = this.quoteId;
    data['service_id'] = this.serviceId;
    data['no_of_services'] = this.noOfServices;
    data['job_type'] = this.jobType;
    data['rate'] = this.rate;
    data['sub_total'] = this.subTotal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.quoteServiceDates != null) {
      data['quote_service_dates'] =
          this.quoteServiceDates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  int? id;
  String? pestName;
  String? serviceTitle;
  String? termAndConditions;
  Null? deletedAt;
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

class QuoteServiceDates {
  int? id;
  int? quoteId;
  int? serviceId;
  int? quoteServiceId;
  String? serviceDate;
  String? createdAt;
  String? updatedAt;

  QuoteServiceDates(
      {this.id,
        this.quoteId,
        this.serviceId,
        this.quoteServiceId,
        this.serviceDate,
        this.createdAt,
        this.updatedAt});

  QuoteServiceDates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quoteId = json['quote_id'];
    serviceId = json['service_id'];
    quoteServiceId = json['quote_service_id'];
    serviceDate = json['service_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quote_id'] = this.quoteId;
    data['service_id'] = this.serviceId;
    data['quote_service_id'] = this.quoteServiceId;
    data['service_date'] = this.serviceDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
