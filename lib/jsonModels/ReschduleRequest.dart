class ReschduleRequest {
  String? jobId;
  String? jobDate;
  String? reason;

  ReschduleRequest({this.jobId, this.jobDate, this.reason});

  ReschduleRequest.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobDate = json['job_date'];
    reason = json['reason'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['job_id'] = this.jobId!;
    data['job_date'] = this.jobDate!;
    data['reason'] = this.reason!;
    return data;
  }
}