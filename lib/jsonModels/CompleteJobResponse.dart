class CompleteJobResponse {
  CompleteJobResponseData? data;

  CompleteJobResponse({this.data});

  CompleteJobResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CompleteJobResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CompleteJobResponseData {
  int? id;
  int? userId;
  String? jobTitle;
  int? clientAddressId;
  String? subject;
  String? serviceIds;
  String? tmIds;
  String? description;
  String? trn;
  String? tag;
  int? isFoodWatchAccount;
  String? jobDate;
  String? priority;
  String? subTotal;
  String? disPer;
  String? disAmt;
  String? vatPer;
  String? vatAmt;
  String? grandTotal;
  int? isCompleted;
  int? isModified;
  String? captainId;
  String? teamMemberIds;
  String? jobInstructions;
  int? termAndConditionId;
  int? quoteId;
  String? createdAt;
  String? updatedAt;
  String? jobStartTime;
  String? jobEndTime;
  String? deletedAt;
  int? isAssigned;
  int? isCompletedByCaptains;
  List<OverallPestFoundServices>? overallPestFoundServices;
  List<OverallTreatmentMethods>? overallTreatmentMethods;
  List<OverallCaptainAreas>? overallCaptainAreas;
  List<OverallCaptainProducts>? overallCaptainProducts;
  String? serviceReportPdf;
  String? report;

  CompleteJobResponseData(
      {this.id,
        this.userId,
        this.jobTitle,
        this.clientAddressId,
        this.subject,
        this.serviceIds,
        this.tmIds,
        this.description,
        this.trn,
        this.tag,
        this.isFoodWatchAccount,
        this.jobDate,
        this.priority,
        this.subTotal,
        this.disPer,
        this.disAmt,
        this.vatPer,
        this.vatAmt,
        this.grandTotal,
        this.isCompleted,
        this.isModified,
        this.captainId,
        this.teamMemberIds,
        this.jobInstructions,
        this.termAndConditionId,
        this.quoteId,
        this.createdAt,
        this.updatedAt,
        this.jobStartTime,
        this.jobEndTime,
        this.deletedAt,
        this.isAssigned,
        this.isCompletedByCaptains,
        this.overallPestFoundServices,
        this.overallTreatmentMethods,
        this.overallCaptainAreas,
        this.overallCaptainProducts,
        this.serviceReportPdf,
        this.report});

  CompleteJobResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    jobTitle = json['job_title'];
    clientAddressId = json['client_address_id'];
    subject = json['subject'];
    serviceIds = json['service_ids'];
    tmIds = json['tm_ids'];
    description = json['description'];
    trn = json['trn'];
    tag = json['tag'];
    isFoodWatchAccount = json['is_food_watch_account'];
    jobDate = json['job_date'];
    priority = json['priority'];
    subTotal = json['sub_total'];
    disPer = json['dis_per'];
    disAmt = json['dis_amt'];
    vatPer = json['vat_per'];
    vatAmt = json['vat_amt'];
    grandTotal = json['grand_total'];
    isCompleted = json['is_completed'];
    isModified = json['is_modified'];
    captainId = json['captain_id'];
    teamMemberIds = json['team_member_ids'];
    jobInstructions = json['job_instructions'];
    termAndConditionId = json['term_and_condition_id'];
    quoteId = json['quote_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    jobStartTime = json['job_start_time'];
    jobEndTime = json['job_end_time'];
    deletedAt = json['deleted_at'];
    isAssigned = json['is_assigned'];
    isCompletedByCaptains = json['is_completed_by_captains'];
    if (json['overall_pest_found_services'] != null) {
      overallPestFoundServices = <OverallPestFoundServices>[];
      json['overall_pest_found_services'].forEach((v) {
        overallPestFoundServices!.add(new OverallPestFoundServices.fromJson(v));
      });
    }
    if (json['overall_treatment_methods'] != null) {
      overallTreatmentMethods = <OverallTreatmentMethods>[];
      json['overall_treatment_methods'].forEach((v) {
        overallTreatmentMethods!.add(new OverallTreatmentMethods.fromJson(v));
      });
    }
    if (json['overall_captain_areas'] != null) {
      overallCaptainAreas = <OverallCaptainAreas>[];
      json['overall_captain_areas'].forEach((v) {
        overallCaptainAreas!.add(new OverallCaptainAreas.fromJson(v));
      });
    }
    if (json['overall_captain_products'] != null) {
      overallCaptainProducts = <OverallCaptainProducts>[];
      json['overall_captain_products'].forEach((v) {
        overallCaptainProducts!.add(new OverallCaptainProducts.fromJson(v));
      });
    }
    serviceReportPdf = json['service_report_pdf'];
    report = json['report'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['job_title'] = this.jobTitle;
    data['client_address_id'] = this.clientAddressId;
    data['subject'] = this.subject;
    data['service_ids'] = this.serviceIds;
    data['tm_ids'] = this.tmIds;
    data['description'] = this.description;
    data['trn'] = this.trn;
    data['tag'] = this.tag;
    data['is_food_watch_account'] = this.isFoodWatchAccount;
    data['job_date'] = this.jobDate;
    data['priority'] = this.priority;
    data['sub_total'] = this.subTotal;
    data['dis_per'] = this.disPer;
    data['dis_amt'] = this.disAmt;
    data['vat_per'] = this.vatPer;
    data['vat_amt'] = this.vatAmt;
    data['grand_total'] = this.grandTotal;
    data['is_completed'] = this.isCompleted;
    data['is_modified'] = this.isModified;
    data['captain_id'] = this.captainId;
    data['team_member_ids'] = this.teamMemberIds;
    data['job_instructions'] = this.jobInstructions;
    data['term_and_condition_id'] = this.termAndConditionId;
    data['quote_id'] = this.quoteId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['job_start_time'] = this.jobStartTime;
    data['job_end_time'] = this.jobEndTime;
    data['deleted_at'] = this.deletedAt;
    data['is_assigned'] = this.isAssigned;
    data['is_completed_by_captains'] = this.isCompletedByCaptains;
    if (this.overallPestFoundServices != null) {
      data['overall_pest_found_services'] =
          this.overallPestFoundServices!.map((v) => v.toJson()).toList();
    }
    if (this.overallTreatmentMethods != null) {
      data['overall_treatment_methods'] =
          this.overallTreatmentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.overallCaptainAreas != null) {
      data['overall_captain_areas'] =
          this.overallCaptainAreas!.map((v) => v.toJson()).toList();
    }
    if (this.overallCaptainProducts != null) {
      data['overall_captain_products'] =
          this.overallCaptainProducts!.map((v) => v.toJson()).toList();
    }
    data['service_report_pdf'] = this.serviceReportPdf;
    data['report'] = this.report;
    return data;
  }
}

class OverallPestFoundServices {
  int? id;
  String? pestName;
  String? serviceTitle;
  String? termAndConditions;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  OverallPestFoundServices(
      {this.id,
        this.pestName,
        this.serviceTitle,
        this.termAndConditions,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  OverallPestFoundServices.fromJson(Map<String, dynamic> json) {
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

class OverallTreatmentMethods {
  int? id;
  String? name;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  OverallTreatmentMethods(
      {this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  OverallTreatmentMethods.fromJson(Map<String, dynamic> json) {
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

class OverallCaptainAreas {
  int? id;
  int? jobId;
  int? jobServiceReportId;
  String? inspectedAreas;
  String? manifestedAreas;
  String? reportAndFollowUpDetail;
  String? infestationLevel;
  String? createdAt;
  String? updatedAt;
  String? pestFound;
  int? jobCaptainId;
  int? jobServiceReportCaptainId;

  OverallCaptainAreas(
      {this.id,
        this.jobId,
        this.jobServiceReportId,
        this.inspectedAreas,
        this.manifestedAreas,
        this.reportAndFollowUpDetail,
        this.infestationLevel,
        this.createdAt,
        this.updatedAt,
        this.pestFound,
        this.jobCaptainId,
        this.jobServiceReportCaptainId});

  OverallCaptainAreas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    jobServiceReportId = json['job_service_report_id'];
    inspectedAreas = json['inspected_areas'];
    manifestedAreas = json['manifested_areas'];
    reportAndFollowUpDetail = json['report_and_follow_up_detail'];
    infestationLevel = json['infestation_level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pestFound = json['pest_found'];
    jobCaptainId = json['job_captain_id'];
    jobServiceReportCaptainId = json['job_service_report_captain_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['job_service_report_id'] = this.jobServiceReportId;
    data['inspected_areas'] = this.inspectedAreas;
    data['manifested_areas'] = this.manifestedAreas;
    data['report_and_follow_up_detail'] = this.reportAndFollowUpDetail;
    data['infestation_level'] = this.infestationLevel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pest_found'] = this.pestFound;
    data['job_captain_id'] = this.jobCaptainId;
    data['job_service_report_captain_id'] = this.jobServiceReportCaptainId;
    return data;
  }
}

class OverallCaptainProducts {
  int? id;
  String? productName;
  int? qty;
  String? unit;

  OverallCaptainProducts({this.id, this.productName, this.qty, this.unit});

  OverallCaptainProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    qty = json['qty'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['qty'] = this.qty;
    data['unit'] = this.unit;
    return data;
  }
}
