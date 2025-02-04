class QuoteServices {
  int? serviceId;
  String serviceName = "";
  String serviceType = "";
  String jobsCount = "";
  String jobDuration = "";
  List<QuoteServicesDetail>? detail = [];

  QuoteServices({this.serviceId, this.detail});

  QuoteServices.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    if (json['detail'] != null) {
      detail = <QuoteServicesDetail>[];
      json['detail'].forEach((v) {
        detail!.add(new QuoteServicesDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuoteServicesDetail {
  String? jobType;
  int? rate;
  int? noOfJobs;

  QuoteServicesDetail({this.jobType, this.rate, this.noOfJobs});

  QuoteServicesDetail.fromJson(Map<String, dynamic> json) {
    jobType = json['job_type'];
    rate = json['rate'];
    noOfJobs = json['no_of_jobs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_type'] = this.jobType;
    data['rate'] = this.rate;
    data['no_of_jobs'] = this.noOfJobs;
    return data;
  }
}
