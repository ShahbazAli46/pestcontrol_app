class EditQuoteResponse {
  EditQuoteResponseData? data;

  EditQuoteResponse({this.data});

  EditQuoteResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new EditQuoteResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EditQuoteResponseData {
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
  String? licenseNo;
  String? contractCancelledAt;
  String? contractCancelReason;
  List<TreatmentMethods>? treatmentMethods;
  User? user;
  TermAndCondition? termAndCondition;
  List<EditQuoteResponseQuoteServices>? quoteServices;
  List<int>? service_agreement_ids;
  String? pdfUrl;
  int? branch_id;
  EditQuoteResponseData(
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
        this.service_agreement_ids,
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
        this.licenseNo,
        this.contractCancelledAt,
        this.contractCancelReason,
        this.treatmentMethods,
        this.user,
        this.termAndCondition,
        this.pdfUrl,
        this.branch_id,
        this.quoteServices});

  EditQuoteResponseData.fromJson(Map<String, dynamic> json) {
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
    service_agreement_ids = json['service_agreement_ids']?.cast<int>();
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
    licenseNo = json['license_no'];
    pdfUrl = json['pdf_url'];
    branch_id = json['branch_id'];
    contractCancelledAt = json['contract_cancelled_at'];
    contractCancelReason = json['contract_cancel_reason'];
    if (json['treatment_methods'] != null) {
      treatmentMethods = <TreatmentMethods>[];
      json['treatment_methods'].forEach((v) {
        treatmentMethods!.add(new TreatmentMethods.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    termAndCondition = json['term_and_condition'] != null
        ? new TermAndCondition.fromJson(json['term_and_condition'])
        : null;
    if (json['quote_services'] != null) {
      quoteServices = <EditQuoteResponseQuoteServices>[];
      json['quote_services'].forEach((v) {
        quoteServices!.add(new EditQuoteResponseQuoteServices.fromJson(v));
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
    data['license_no'] = this.licenseNo;
    data['contract_cancelled_at'] = this.contractCancelledAt;
    data['contract_cancel_reason'] = this.contractCancelReason;
    if (this.treatmentMethods != null) {
      data['treatment_methods'] =
          this.treatmentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.termAndCondition != null) {
      data['term_and_condition'] = this.termAndCondition!.toJson();
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
    branchId = "${json['branch_id']}";
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
  String? firedAt;
  String? appVersion;
  String? firebaseToken;
  int? branchId;

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
        this.firedAt,
        this.appVersion,
        this.firebaseToken,
        this.branchId});

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

class EditQuoteResponseQuoteServices {
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

  EditQuoteResponseQuoteServices(
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

  EditQuoteResponseQuoteServices.fromJson(Map<String, dynamic> json) {
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
