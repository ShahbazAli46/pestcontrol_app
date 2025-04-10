class CreateReportRequest {
  int? jobId;
  String? typeOfVisit;
  List<int>? tmIds;
  List<int>? pestFoundIds;
  String? recommendationsAndRemarks;
  List<Addresses>? addresses;
  List<UsedProducts>? usedProducts;

  CreateReportRequest(
      {this.jobId,
        this.typeOfVisit,
        this.tmIds,
        this.pestFoundIds,
        this.recommendationsAndRemarks,
        this.addresses,
        this.usedProducts});

  CreateReportRequest.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    typeOfVisit = json['type_of_visit'];
    tmIds = json['tm_ids'].cast<int>();
    pestFoundIds = json['pest_found_ids'].cast<int>();
    recommendationsAndRemarks = json['recommendations_and_remarks'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    if (json['used_products'] != null) {
      usedProducts = <UsedProducts>[];
      json['used_products'].forEach((v) {
        usedProducts!.add(new UsedProducts.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['type_of_visit'] = this.typeOfVisit;
    data['tm_ids'] = this.tmIds; // This should be a List<int>
    data['pest_found_ids'] = this.pestFoundIds; // This should be a List<int>
    data['recommendations_and_remarks'] = this.recommendationsAndRemarks;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList(); // This should be a List<Map<String, dynamic>>
    }
    if (this.usedProducts != null) {
      data['used_products'] = this.usedProducts!.map((v) => v.toJson()).toList(); // This should be a List<Map<String, dynamic>>
    }
    return data;
  }

}

class Addresses {
  String? inspectedAreas;
  String? manifestedAreas;
  String? reportAndFollowUpDetail;
  String? infestationLevel;

  Addresses(
      {this.inspectedAreas,
        this.manifestedAreas,
        this.reportAndFollowUpDetail,
        this.infestationLevel});

  Addresses.fromJson(Map<String, dynamic> json) {
    inspectedAreas = json['inspected_areas'];
    manifestedAreas = json['manifested_areas'];
    reportAndFollowUpDetail = json['report_and_follow_up_detail'];
    infestationLevel = json['infestation_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inspected_areas'] = this.inspectedAreas;
    data['manifested_areas'] = this.manifestedAreas;
    data['report_and_follow_up_detail'] = this.reportAndFollowUpDetail;
    data['infestation_level'] = this.infestationLevel;
    return data;
  }
}

class UsedProducts {
  int? productId;
  int? dose;
  int? qty;
  int? price;
  int? isExtra;

  UsedProducts({this.productId, this.dose, this.qty, this.price, this.isExtra});

  UsedProducts.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    dose = json['dose'];
    qty = json['qty'];
    price = json['price'];
    isExtra = json['is_extra'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['dose'] = this.dose;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['is_extra'] = this.isExtra;
    return data;
  }
}
