class ServiceAgreementResponse {
  List<ServiceAgreementResponseData>? data;

  ServiceAgreementResponse({this.data});

  ServiceAgreementResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ServiceAgreementResponseData>[];
      json['data'].forEach((v) {
        data!.add(new ServiceAgreementResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceAgreementResponseData {
  int? id;
  String? pestName;
  String? serviceTitle;
  String? termAndConditions;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  ServiceAgreementResponseData(
      {this.id,
        this.pestName,
        this.serviceTitle,
        this.termAndConditions,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  ServiceAgreementResponseData.fromJson(Map<String, dynamic> json) {
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
