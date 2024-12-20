class PosCollectionResponse {
  String? startDate;
  String? endDate;
  PosCollectionResponseData? data;

  PosCollectionResponse({this.startDate, this.endDate, this.data});

  PosCollectionResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    data = json['data'] != null ? new PosCollectionResponseData.fromJson(json['data']) : null;
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

class PosCollectionResponseData {
  String? totalPos;
  int? noOfTransection;

  PosCollectionResponseData({this.totalPos, this.noOfTransection});

  PosCollectionResponseData.fromJson(Map<String, dynamic> json) {
    totalPos = json['total_pos'];
    noOfTransection = json['no_of_transection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pos'] = this.totalPos;
    data['no_of_transection'] = this.noOfTransection;
    return data;
  }
}
