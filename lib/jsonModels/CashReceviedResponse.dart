class CashReceviedResponse {
  String? startDate;
  String? endDate;
  CashReceviedResponseData? data;

  CashReceviedResponse({this.startDate, this.endDate, this.data});

  CashReceviedResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    data = json['data'] != null ? new CashReceviedResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CashReceviedResponseData {
  String? totalCash;
  int? noOfTransection;

  CashReceviedResponseData({this.totalCash, this.noOfTransection});

  CashReceviedResponseData.fromJson(Map<String, dynamic> json) {
    totalCash = json['total_cash'];
    noOfTransection = json['no_of_transection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_cash'] = this.totalCash;
    data['no_of_transection'] = this.noOfTransection;
    return data;
  }
}
