class ApproveQuoteRequest {
  String? trn;
  String? licenseNo;
  String? isFoodWatchAccount;
  List<ApproveQuoteRequestQuoteServices>? quoteServices = [];

  ApproveQuoteRequest(
      {this.trn, this.licenseNo, this.isFoodWatchAccount, this.quoteServices});

  ApproveQuoteRequest.fromJson(Map<String, dynamic> json) {
    trn = json['trn'];
    licenseNo = json['license_no'];
    isFoodWatchAccount = json['is_food_watch_account'];
    if (json['quote_services'] != null) {
      quoteServices = <ApproveQuoteRequestQuoteServices>[];
      json['quote_services'].forEach((v) {
        quoteServices!.add(new ApproveQuoteRequestQuoteServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trn'] = this.trn;
    data['license_no'] = this.licenseNo;
    data['is_food_watch_account'] = this.isFoodWatchAccount;
    if (this.quoteServices != null) {
      data['quote_services'] =
          this.quoteServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApproveQuoteRequestQuoteServices {
  int? quoteServiceId;
  List<String>? dates;

  ApproveQuoteRequestQuoteServices({this.quoteServiceId, this.dates});

  ApproveQuoteRequestQuoteServices.fromJson(Map<String, dynamic> json) {
    quoteServiceId = json['quote_service_id'];
    dates = json['dates'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote_service_id'] = this.quoteServiceId;
    data['dates'] = this.dates;
    return data;
  }
}
