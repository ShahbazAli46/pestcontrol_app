class SalesOfficerVisitRequest {
  String? userId;
  String? description;
  String? status;
  String? currentContractEndDate;
  String? visitDate;
  String? latitude;
  String? longitude;
  String? userClientId;
  String? followUpDate;
  String? client_address_id;
  List<Images>? images;

  SalesOfficerVisitRequest(
      {this.userId,
        this.description,
        this.status,
        this.currentContractEndDate,
        this.visitDate,
        this.latitude,
        this.longitude,
        this.userClientId,
        this.followUpDate,
        this.client_address_id,
        this.images});

  SalesOfficerVisitRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    description = json['description'];
    status = json['status'];
    currentContractEndDate = json['current_contract_end_date'];
    visitDate = json['visit_date'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userClientId = json['user_client_id'];
    followUpDate = json['follow_up_date'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['status'] = this.status;
    data['client_address_id'] = this.client_address_id;
    data['current_contract_end_date'] = this.currentContractEndDate;
    data['visit_date'] = this.visitDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['user_client_id'] = this.userClientId;
    data['follow_up_date'] = this.followUpDate;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? file;

  Images({this.file});

  Images.fromJson(Map<String, dynamic> json) {
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    return data;
  }
}
