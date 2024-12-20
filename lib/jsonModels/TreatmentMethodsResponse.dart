class TreatmentMethodsResponse {
  List<MethodsData>? data;

  TreatmentMethodsResponse({this.data});

  TreatmentMethodsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MethodsData>[];
      json['data'].forEach((v) {
        data!.add(new MethodsData.fromJson(v));
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

class MethodsData {
  int? id;
  String? name;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  MethodsData({this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  MethodsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
