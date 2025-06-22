import 'QuoteServices.dart';

class CreateQuoteRequest {
  String? manageType;
  int? userId;
  String? quoteTitle;
  int? clientAddressId;
  String? subject;
  List<int>? tmIds;
  String? description;
  int? trn;
  int? quote_id;
  String? tag;
  int? durationInMonths;
  int? isFoodWatchAccount;
  String? billingMethod;
  int? dis_amt;
  int? vatPer;
  int? termAndConditionId;
  int? is_enable_scope_of_work;
  List<int>? service_agreement_ids;
  String? branch_id;
  List<QuoteServices>? services;

  CreateQuoteRequest({
    this.manageType,
    this.userId,
    this.quoteTitle,
    this.clientAddressId,
    this.subject,
    this.tmIds,
    this.description,
    this.trn,
    this.tag,
    this.durationInMonths,
    this.isFoodWatchAccount,
    this.billingMethod,
    this.dis_amt,
    this.vatPer,
    this.termAndConditionId,
    this.service_agreement_ids,
    this.quote_id,
    this.branch_id,
    this.services,
    this.is_enable_scope_of_work
  });

  CreateQuoteRequest.fromJson(Map<String, dynamic> json) {
    manageType = json['manage_type'];
    userId = json['user_id'];
    quoteTitle = json['quote_title'];
    clientAddressId = json['client_address_id'];
    subject = json['subject'];
    tmIds = json['tm_ids']?.cast<int>();
    description = json['description'];
    trn = json['trn'];
    tag = json['tag'];
    durationInMonths = json['duration_in_months'];
    isFoodWatchAccount = json['is_food_watch_account'];
    billingMethod = json['billing_method'];
    dis_amt = json['dis_amt'];
    vatPer = json['vat_per'];
    termAndConditionId = json['term_and_condition_id'];
    service_agreement_ids = json['service_agreement_ids']?.cast<int>();
    quote_id = json['quote_id'];
    branch_id = json['branch_id'];
    is_enable_scope_of_work = json['is_enable_scope_of_work'];
    if (json['services'] != null) {
      services = <QuoteServices>[];
      json['services'].forEach((v) {
        services!.add(new QuoteServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_type'] = this.manageType;
    data['user_id'] = this.userId;
    data['quote_title'] = this.quoteTitle;
    data['client_address_id'] = this.clientAddressId;
    data['subject'] = this.subject;
    data['tm_ids'] = this.tmIds;
    data['description'] = this.description;
    data['trn'] = this.trn;
    data['tag'] = this.tag;
    data['quote_id'] = this.quote_id;
    data['duration_in_months'] = this.durationInMonths;
    data['is_food_watch_account'] = this.isFoodWatchAccount;
    data['billing_method'] = this.billingMethod;
    data['dis_amt'] = this.dis_amt;
    data['vat_per'] = this.vatPer;
    data['term_and_condition_id'] = this.termAndConditionId;
    data['service_agreement_ids'] = this.service_agreement_ids;
    data['branch_id'] = this.branch_id;
    data['is_enable_scope_of_work'] = this.is_enable_scope_of_work;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Services {
  int? serviceId;
  List<Detail>? detail;

  Services({this.serviceId, this.detail});

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String? jobType;
  int? rate;
  int? noOfJobs;

  Detail({this.jobType, this.rate, this.noOfJobs});

  Detail.fromJson(Map<String, dynamic> json) {
    jobType = json['job_type'];
    rate = json['rate'];
    noOfJobs = json['no_of_jobs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_type'] = this.jobType;
    data['rate'] = this.rate;
    data['no_of_jobs'] = this.noOfJobs;
    return data;
  }
}
