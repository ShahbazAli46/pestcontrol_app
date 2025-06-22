class SubmitReportRequest {
  String? jobId;
  String? typeOfVisit;
  String? recommendationsAndRemarks;
  String? forOfficeUse;
  String? signatureImg;

  SubmitReportRequest(
      {this.jobId,
        this.typeOfVisit,
        this.recommendationsAndRemarks,
        this.forOfficeUse,
        this.signatureImg});

  SubmitReportRequest.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    typeOfVisit = json['type_of_visit'];
    recommendationsAndRemarks = json['recommendations_and_remarks'];
    forOfficeUse = json['for_office_use'];
    signatureImg = json['signature_img'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['job_id'] = this.jobId ?? "";
    data['type_of_visit'] = this.typeOfVisit ?? "";
    data['recommendations_and_remarks'] = this.recommendationsAndRemarks ?? "" ;
    data['for_office_use'] = this.forOfficeUse ?? "";

    return data;
  }
}
