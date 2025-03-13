class AddInspectionVisitRequest {
  String? userId;
  String? clientRemarks;
  String? recommendationForOperation;
  String? generalComment;
  String? nestingArea;
  String? userClientId;
  String? addressId;

  AddInspectionVisitRequest(
      {this.userId,
        this.clientRemarks,
        this.recommendationForOperation,
        this.generalComment,
        this.nestingArea,
        this.userClientId,
        this.addressId});

  AddInspectionVisitRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    clientRemarks = json['client_remarks'];
    recommendationForOperation = json['recommendation_for_operation'];
    generalComment = json['general_comment'];
    nestingArea = json['nesting_area'];
    userClientId = json['user_client_id'];
    addressId = json['address_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['client_remarks'] = this.clientRemarks;
    data['recommendation_for_operation'] = this.recommendationForOperation;
    data['general_comment'] = this.generalComment;
    data['nesting_area'] = this.nestingArea;
    data['user_client_id'] = this.userClientId;
    data['address_id'] = this.addressId;
    return data;
  }
}
