class PaymentFollowUpRequest {
  String? clientUserId;
  String? responseType;
  String? promiseDate;
  String? other;
  String? longitude;
  String? latitude;

  PaymentFollowUpRequest(
      {this.clientUserId,
        this.responseType,
        this.promiseDate,
        this.other,
        this.longitude,
        this.latitude});

  PaymentFollowUpRequest.fromJson(Map<String, dynamic> json) {
    clientUserId = json['client_user_id'];
    responseType = json['response_type'];
    promiseDate = json['promise_date'];
    other = json['other'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_user_id'] = this.clientUserId;
    data['response_type'] = this.responseType;
    data['promise_date'] = this.promiseDate;
    data['other'] = this.other;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
