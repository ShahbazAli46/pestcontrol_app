class TermAndConditionsResponse {
  List<TermAndConditionsResponseData>? data;

  TermAndConditionsResponse({this.data});

  TermAndConditionsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TermAndConditionsResponseData>[];
      json['data'].forEach((v) {
        data!.add(new TermAndConditionsResponseData.fromJson(v));
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

class TermAndConditionsResponseData {
  int? id;
  String? name;
  String? text;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  TermAndConditionsResponseData(
      {this.id,
        this.name,
        this.text,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  TermAndConditionsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    text = json['text'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['text'] = this.text;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
