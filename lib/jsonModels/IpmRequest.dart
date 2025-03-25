class IpmRequest {
  String? jobId;
  String? userClientId;
  String? description;
  String? reportDate;

  IpmRequest(
      {this.jobId, this.userClientId, this.description, this.reportDate});

  IpmRequest.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    userClientId = json['user_client_id'];
    description = json['description'];
    reportDate = json['report_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['user_client_id'] = this.userClientId;
    data['description'] = this.description;
    data['report_date'] = this.reportDate;
    return data;
  }
}
