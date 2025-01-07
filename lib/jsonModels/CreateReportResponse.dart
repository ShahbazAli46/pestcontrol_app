class CreateReportResponse {
  String? status;
  String? message;
  Data? data;

  CreateReportResponse({this.status, this.message, this.data});

  CreateReportResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? jobId;
  String? id;

  Data(
      {this.jobId,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    jobId = "${json['job_id']}";
    id = "${json['id']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['id'] = this.id;
    return data;
  }
}
