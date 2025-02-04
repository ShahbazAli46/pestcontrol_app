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
  String? tag;
  int? durationInMonths;
  int? isFoodWatchAccount;
  String? billingMethod;
  int? dis_amt;
  int? vatPer;
  int? termAndConditionId;
  List<QuoteServices>? services;

  CreateQuoteRequest(
      {this.manageType,
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
        this.services});

  CreateQuoteRequest.fromJson(Map<String, dynamic> json) {
    manageType = json['manage_type'];
    userId = json['user_id'];
    quoteTitle = json['quote_title'];
    clientAddressId = json['client_address_id'];
    subject = json['subject'];
    tmIds = json['tm_ids'].cast<int>();
    description = json['description'];
    trn = json['trn'];
    tag = json['tag'];
    durationInMonths = json['duration_in_months'];
    isFoodWatchAccount = json['is_food_watch_account'];
    billingMethod = json['billing_method'];
    dis_amt = json['dis_amt'];
    vatPer = json['vat_per'];
    termAndConditionId = json['term_and_condition_id'];
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
    data['duration_in_months'] = this.durationInMonths;
    data['is_food_watch_account'] = this.isFoodWatchAccount;
    data['billing_method'] = this.billingMethod;
    data['dis_amt'] = this.dis_amt;
    data['vat_per'] = this.vatPer;
    data['term_and_condition_id'] = this.termAndConditionId;
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
