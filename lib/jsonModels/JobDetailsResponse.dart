class JobDetailsResponse {
  JobDetailsResponse({
    required this.data,
  });

  final JobDetailsResponseData? data;

  factory JobDetailsResponse.fromJson(Map<String, dynamic> json){
    return JobDetailsResponse(
      data: json["data"] == null ? null : JobDetailsResponseData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };

  @override
  String toString(){
    return "$data, ";
  }
}

class JobDetailsResponseData {
  JobDetailsResponseData({
    required this.id,
    required this.userId,
    required this.jobTitle,
    required this.clientAddressId,
    required this.subject,
    required this.serviceIds,
    required this.tmIds,
    required this.description,
    required this.trn,
    required this.tag,
    required this.isFoodWatchAccount,
    required this.jobDate,
    required this.priority,
    required this.subTotal,
    required this.disPer,
    required this.disAmt,
    required this.vatPer,
    required this.vatAmt,
    required this.grandTotal,
    required this.isCompleted,
    required this.isModified,
    required this.captainId,
    required this.teamMemberIds,
    required this.jobInstructions,
    required this.termAndConditionId,
    required this.quoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.jobStartTime,
    required this.jobEndTime,
    required this.deletedAt,
    required this.isAssigned,
    required this.captainIds,
    required this.treatmentMethods,
    required this.serviceReportPdf,
    required this.user,
    required this.termAndCondition,
    required this.jobServices,
    required this.rescheduleDates,
    required this.clientAddress,
    required this.captains,
    required this.report,
  });

  final int? id;
  final int? userId;
  final String? jobTitle;
  final int? clientAddressId;
  final String? subject;
  final String? serviceIds;
  final String? tmIds;
  final String? description;
  final String? trn;
  final String? tag;
  final int? isFoodWatchAccount;
  final String? jobDate;
  final String? priority;
  final String? subTotal;
  final String? disPer;
  final String? disAmt;
  final String? vatPer;
  final String? vatAmt;
  final String? grandTotal;
  final int? isCompleted;
  final int? isModified;
  final dynamic captainId;
  final dynamic teamMemberIds;
  final dynamic jobInstructions;
  final int? termAndConditionId;
  final int? quoteId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? jobStartTime;
  final dynamic jobEndTime;
  final dynamic deletedAt;
  final int? isAssigned;
  final List<int> captainIds;
  final List<TermAndCondition> treatmentMethods;
  final dynamic serviceReportPdf;
  final User? user;
  final TermAndCondition? termAndCondition;
  final List<JobService> jobServices;
  final List<RescheduleDate> rescheduleDates;
  final ClientAddress? clientAddress;
  final List<Captain> captains;
  final dynamic report;

  factory JobDetailsResponseData.fromJson(Map<String, dynamic> json){
    return JobDetailsResponseData(
      id: json["id"],
      userId: json["user_id"],
      jobTitle: json["job_title"],
      clientAddressId: json["client_address_id"],
      subject: json["subject"],
      serviceIds: json["service_ids"],
      tmIds: json["tm_ids"],
      description: json["description"],
      trn: json["trn"],
      tag: json["tag"],
      isFoodWatchAccount: json["is_food_watch_account"],
      jobDate: json["job_date"] ?? "",
      priority: json["priority"],
      subTotal: json["sub_total"],
      disPer: json["dis_per"],
      disAmt: json["dis_amt"],
      vatPer: json["vat_per"],
      vatAmt: json["vat_amt"],
      grandTotal: json["grand_total"],
      isCompleted: json["is_completed"],
      isModified: json["is_modified"],
      captainId: json["captain_id"],
      teamMemberIds: json["team_member_ids"],
      jobInstructions: json["job_instructions"],
      termAndConditionId: json["term_and_condition_id"],
      quoteId: json["quote_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      jobStartTime: DateTime.tryParse(json["job_start_time"] ?? ""),
      jobEndTime: json["job_end_time"],
      deletedAt: json["deleted_at"],
      isAssigned: json["is_assigned"],
      captainIds: json["captain_ids"] == null ? [] : List<int>.from(json["captain_ids"]!.map((x) => x)),
      treatmentMethods: json["treatment_methods"] == null ? [] : List<TermAndCondition>.from(json["treatment_methods"]!.map((x) => TermAndCondition.fromJson(x))),
      serviceReportPdf: json["service_report_pdf"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      termAndCondition: json["term_and_condition"] == null ? null : TermAndCondition.fromJson(json["term_and_condition"]),
      jobServices: json["job_services"] == null ? [] : List<JobService>.from(json["job_services"]!.map((x) => JobService.fromJson(x))),
      rescheduleDates: json["reschedule_dates"] == null ? [] : List<RescheduleDate>.from(json["reschedule_dates"]!.map((x) => RescheduleDate.fromJson(x))),
      clientAddress: json["client_address"] == null ? null : ClientAddress.fromJson(json["client_address"]),
      captains: json["captains"] == null ? [] : List<Captain>.from(json["captains"]!.map((x) => Captain.fromJson(x))),
      report: json["report"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "job_title": jobTitle,
    "client_address_id": clientAddressId,
    "subject": subject,
    "service_ids": serviceIds,
    "tm_ids": tmIds,
    "description": description,
    "trn": trn,
    "tag": tag,
    "is_food_watch_account": isFoodWatchAccount,
    "job_date": jobDate,
    "priority": priority,
    "sub_total": subTotal,
    "dis_per": disPer,
    "dis_amt": disAmt,
    "vat_per": vatPer,
    "vat_amt": vatAmt,
    "grand_total": grandTotal,
    "is_completed": isCompleted,
    "is_modified": isModified,
    "captain_id": captainId,
    "team_member_ids": teamMemberIds,
    "job_instructions": jobInstructions,
    "term_and_condition_id": termAndConditionId,
    "quote_id": quoteId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_start_time": jobStartTime?.toIso8601String(),
    "job_end_time": jobEndTime,
    "deleted_at": deletedAt,
    "is_assigned": isAssigned,
    "captain_ids": captainIds.map((x) => x).toList(),
    "treatment_methods": treatmentMethods.map((x) => x?.toJson()).toList(),
    "service_report_pdf": serviceReportPdf,
    "user": user?.toJson(),
    "term_and_condition": termAndCondition?.toJson(),
    "job_services": jobServices.map((x) => x?.toJson()).toList(),
    "reschedule_dates": rescheduleDates.map((x) => x?.toJson()).toList(),
    "client_address": clientAddress?.toJson(),
    "captains": captains.map((x) => x?.toJson()).toList(),
    "report": report,
  };

  @override
  String toString(){
    return "$id, $userId, $jobTitle, $clientAddressId, $subject, $serviceIds, $tmIds, $description, $trn, $tag, $isFoodWatchAccount, $jobDate, $priority, $subTotal, $disPer, $disAmt, $vatPer, $vatAmt, $grandTotal, $isCompleted, $isModified, $captainId, $teamMemberIds, $jobInstructions, $termAndConditionId, $quoteId, $createdAt, $updatedAt, $jobStartTime, $jobEndTime, $deletedAt, $isAssigned, $captainIds, $treatmentMethods, $serviceReportPdf, $user, $termAndCondition, $jobServices, $rescheduleDates, $clientAddress, $captains, $report, ";
  }
}

class Captain {
  Captain({
    required this.id,
    required this.captainId,
    required this.jobId,
    required this.teamMemberIds,
    required this.jobInstruction,
    required this.isCompleted,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.teamMembers,
    required this.captainProducts,
    required this.captainAreas,
    required this.reportCaptain,
    required this.captain,
  });

  final int? id;
  final int? captainId;
  final int? jobId;
  final String? teamMemberIds;
  final dynamic jobInstruction;
  final int? isCompleted;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<User> teamMembers;
  final List<CaptainProduct> captainProducts;
  final List<CaptainArea> captainAreas;
  final ReportCaptain? reportCaptain;
  final User? captain;

  factory Captain.fromJson(Map<String, dynamic> json){
    return Captain(
      id: json["id"],
      captainId: json["captain_id"],
      jobId: json["job_id"],
      teamMemberIds: json["team_member_ids"],
      jobInstruction: json["job_instruction"],
      isCompleted: json["is_completed"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      teamMembers: json["team_members"] == null ? [] : List<User>.from(json["team_members"]!.map((x) => User.fromJson(x))),
      captainProducts: json["captain_products"] == null ? [] : List<CaptainProduct>.from(json["captain_products"]!.map((x) => CaptainProduct.fromJson(x))),
      captainAreas: json["captain_areas"] == null ? [] : List<CaptainArea>.from(json["captain_areas"]!.map((x) => CaptainArea.fromJson(x))),
      reportCaptain: json["report_captain"] == null ? null : ReportCaptain.fromJson(json["report_captain"]),
      captain: json["captain"] == null ? null : User.fromJson(json["captain"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "captain_id": captainId,
    "job_id": jobId,
    "team_member_ids": teamMemberIds,
    "job_instruction": jobInstruction,
    "is_completed": isCompleted,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "team_members": teamMembers.map((x) => x?.toJson()).toList(),
    "captain_products": captainProducts.map((x) => x?.toJson()).toList(),
    "captain_areas": captainAreas.map((x) => x?.toJson()).toList(),
    "report_captain": reportCaptain?.toJson(),
    "captain": captain?.toJson(),
  };

  @override
  String toString(){
    return "$id, $captainId, $jobId, $teamMemberIds, $jobInstruction, $isCompleted, $deletedAt, $createdAt, $updatedAt, $teamMembers, $captainProducts, $captainAreas, $reportCaptain, $captain, ";
  }
}

class Client {
  Client({
    required this.id,
    required this.userId,
    required this.roleId,
    required this.firmName,
    required this.phoneNumber,
    required this.mobileNumber,
    required this.industryName,
    required this.referencableType,
    required this.referencableId,
    required this.openingBalance,
    required this.promiseDate,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.referencable,
  });

  final int? id;
  final int? userId;
  final int? roleId;
  final String? firmName;
  final String? phoneNumber;
  final String? mobileNumber;
  final String? industryName;
  final String? referencableType;
  final int? referencableId;
  final String? openingBalance;
  final dynamic promiseDate;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? referencable;

  factory Client.fromJson(Map<String, dynamic> json){
    return Client(
      id: json["id"],
      userId: json["user_id"],
      roleId: json["role_id"],
      firmName: json["firm_name"],
      phoneNumber: json["phone_number"],
      mobileNumber: json["mobile_number"],
      industryName: json["industry_name"],
      referencableType: json["referencable_type"],
      referencableId: json["referencable_id"],
      openingBalance: json["opening_balance"],
      promiseDate: json["promise_date"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      referencable: json["referencable"] == null ? null : User.fromJson(json["referencable"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "role_id": roleId,
    "firm_name": firmName,
    "phone_number": phoneNumber,
    "mobile_number": mobileNumber,
    "industry_name": industryName,
    "referencable_type": referencableType,
    "referencable_id": referencableId,
    "opening_balance": openingBalance,
    "promise_date": promiseDate,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "referencable": referencable?.toJson(),
  };

  @override
  String toString(){
    return "$id, $userId, $roleId, $firmName, $phoneNumber, $mobileNumber, $industryName, $referencableType, $referencableId, $openingBalance, $promiseDate, $deletedAt, $createdAt, $updatedAt, $referencable, ";
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.roleId,
    required this.isActive,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.firedAt,
    required this.appVersion,
    required this.firebaseToken,
    required this.branchId,
    required this.employee,
    required this.client,
    required this.clientInspectionReports,
  });

  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final int? roleId;
  final int? isActive;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic firedAt;
  final String? appVersion;
  final String? firebaseToken;
  final int? branchId;
  final Employee? employee;
  final Client? client;
  final List<dynamic> clientInspectionReports;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      roleId: json["role_id"],
      isActive: json["is_active"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      firedAt: json["fired_at"],
      appVersion: json["app_version"],
      firebaseToken: json["firebase_token"],
      branchId: json["branch_id"],
      employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
      client: json["client"] == null ? null : Client.fromJson(json["client"]),
      clientInspectionReports: json["client_inspection_reports"] == null ? [] : List<dynamic>.from(json["client_inspection_reports"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "role_id": roleId,
    "is_active": isActive,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "fired_at": firedAt,
    "app_version": appVersion,
    "firebase_token": firebaseToken,
    "branch_id": branchId,
    "employee": employee?.toJson(),
    "client": client?.toJson(),
    "client_inspection_reports": clientInspectionReports.map((x) => x).toList(),
  };

  @override
  String toString(){
    return "$id, $name, $email, $emailVerifiedAt, $roleId, $isActive, $deletedAt, $createdAt, $updatedAt, $firedAt, $appVersion, $firebaseToken, $branchId, $employee, $client, $clientInspectionReports, ";
  }
}

class Employee {
  Employee({
    required this.id,
    required this.userId,
    required this.roleId,
    required this.profileImage,
    required this.phoneNumber,
    required this.target,
    required this.profession,
    required this.relativeName,
    required this.relation,
    required this.emergencyContact,
    required this.basicSalary,
    required this.allowance,
    required this.other,
    required this.totalSalary,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.commissionPer,
    required this.holdSalary,
    required this.country,
    required this.branchId,
    required this.joiningDate,
    required this.remainingOffDays,
    required this.contractTarget,
    required this.currentAdvBalance,
    required this.currentFineBalance,
  });

  final int? id;
  final int? userId;
  final int? roleId;
  final String? profileImage;
  final String? phoneNumber;
  final String? target;
  final String? profession;
  final String? relativeName;
  final String? relation;
  final String? emergencyContact;
  final String? basicSalary;
  final String? allowance;
  final String? other;
  final String? totalSalary;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? commissionPer;
  final String? holdSalary;
  final String? country;
  final int? branchId;
  final DateTime? joiningDate;
  final int? remainingOffDays;
  final String? contractTarget;
  final String? currentAdvBalance;
  final String? currentFineBalance;

  factory Employee.fromJson(Map<String, dynamic> json){
    return Employee(
      id: json["id"],
      userId: json["user_id"],
      roleId: json["role_id"],
      profileImage: json["profile_image"],
      phoneNumber: json["phone_number"],
      target: json["target"],
      profession: json["profession"],
      relativeName: json["relative_name"],
      relation: json["relation"],
      emergencyContact: json["emergency_contact"],
      basicSalary: json["basic_salary"],
      allowance: json["allowance"],
      other: json["other"],
      totalSalary: json["total_salary"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      commissionPer: json["commission_per"],
      holdSalary: json["hold_salary"],
      country: json["country"],
      branchId: json["branch_id"],
      joiningDate: DateTime.tryParse(json["joining_date"] ?? ""),
      remainingOffDays: json["remaining_off_days"],
      contractTarget: json["contract_target"],
      currentAdvBalance: json["current_adv_balance"],
      currentFineBalance: json["current_fine_balance"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "role_id": roleId,
    "profile_image": profileImage,
    "phone_number": phoneNumber,
    "target": target,
    "profession": profession,
    "relative_name": relativeName,
    "relation": relation,
    "emergency_contact": emergencyContact,
    "basic_salary": basicSalary,
    "allowance": allowance,
    "other": other,
    "total_salary": totalSalary,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "commission_per": commissionPer,
    "hold_salary": holdSalary,
    "country": country,
    "branch_id": branchId,
    "remaining_off_days": remainingOffDays,
    "contract_target": contractTarget,
    "current_adv_balance": currentAdvBalance,
    "current_fine_balance": currentFineBalance,
  };

  @override
  String toString(){
    return "$id, $userId, $roleId, $profileImage, $phoneNumber, $target, $profession, $relativeName, $relation, $emergencyContact, $basicSalary, $allowance, $other, $totalSalary, $deletedAt, $createdAt, $updatedAt, $commissionPer, $holdSalary, $country, $branchId, $joiningDate, $remainingOffDays, $contractTarget, $currentAdvBalance, $currentFineBalance, ";
  }
}

class CaptainArea {
  CaptainArea({
    required this.id,
    required this.jobId,
    required this.jobServiceReportId,
    required this.inspectedAreas,
    required this.manifestedAreas,
    required this.reportAndFollowUpDetail,
    required this.infestationLevel,
    required this.createdAt,
    required this.updatedAt,
    required this.pestFound,
    required this.jobCaptainId,
    required this.jobServiceReportCaptainId,
  });

  final int? id;
  final int? jobId;
  final int? jobServiceReportId;
  final String? inspectedAreas;
  final String? manifestedAreas;
  final String? reportAndFollowUpDetail;
  final String? infestationLevel;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? pestFound;
  final int? jobCaptainId;
  final int? jobServiceReportCaptainId;

  factory CaptainArea.fromJson(Map<String, dynamic> json){
    return CaptainArea(
      id: json["id"],
      jobId: json["job_id"],
      jobServiceReportId: json["job_service_report_id"],
      inspectedAreas: json["inspected_areas"],
      manifestedAreas: json["manifested_areas"],
      reportAndFollowUpDetail: json["report_and_follow_up_detail"],
      infestationLevel: json["infestation_level"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pestFound: json["pest_found"],
      jobCaptainId: json["job_captain_id"],
      jobServiceReportCaptainId: json["job_service_report_captain_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_id": jobId,
    "job_service_report_id": jobServiceReportId,
    "inspected_areas": inspectedAreas,
    "manifested_areas": manifestedAreas,
    "report_and_follow_up_detail": reportAndFollowUpDetail,
    "infestation_level": infestationLevel,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pest_found": pestFound,
    "job_captain_id": jobCaptainId,
    "job_service_report_captain_id": jobServiceReportCaptainId,
  };

  @override
  String toString(){
    return "$id, $jobId, $jobServiceReportId, $inspectedAreas, $manifestedAreas, $reportAndFollowUpDetail, $infestationLevel, $createdAt, $updatedAt, $pestFound, $jobCaptainId, $jobServiceReportCaptainId, ";
  }
}

class CaptainProduct {
  CaptainProduct({
    required this.id,
    required this.jobId,
    required this.jobServiceReportId,
    required this.productId,
    required this.dose,
    required this.qty,
    required this.total,
    required this.price,
    required this.avgPrice,
    required this.isExtra,
    required this.createdAt,
    required this.updatedAt,
    required this.jobCaptainId,
    required this.jobServiceReportCaptainId,
    required this.product,
  });

  final int? id;
  final int? jobId;
  final int? jobServiceReportId;
  final int? productId;
  final String? dose;
  final int? qty;
  final String? total;
  final String? price;
  final String? avgPrice;
  final int? isExtra;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? jobCaptainId;
  final int? jobServiceReportCaptainId;
  final Product? product;

  factory CaptainProduct.fromJson(Map<String, dynamic> json){
    return CaptainProduct(
      id: json["id"],
      jobId: json["job_id"],
      jobServiceReportId: json["job_service_report_id"],
      productId: json["product_id"],
      dose: json["dose"],
      qty: json["qty"],
      total: json["total"],
      price: json["price"],
      avgPrice: json["avg_price"],
      isExtra: json["is_extra"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      jobCaptainId: json["job_captain_id"],
      jobServiceReportCaptainId: json["job_service_report_captain_id"],
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_id": jobId,
    "job_service_report_id": jobServiceReportId,
    "product_id": productId,
    "dose": dose,
    "qty": qty,
    "total": total,
    "price": price,
    "avg_price": avgPrice,
    "is_extra": isExtra,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_captain_id": jobCaptainId,
    "job_service_report_captain_id": jobServiceReportCaptainId,
    "product": product?.toJson(),
  };

  @override
  String toString(){
    return "$id, $jobId, $jobServiceReportId, $productId, $dose, $qty, $total, $price, $avgPrice, $isExtra, $createdAt, $updatedAt, $jobCaptainId, $jobServiceReportCaptainId, $product, ";
  }
}

class Product {
  Product({
    required this.id,
    required this.productName,
    required this.batchNumber,
    required this.brandId,
    required this.mfgDate,
    required this.expDate,
    required this.productType,
    required this.unit,
    required this.activeIngredients,
    required this.othersIngredients,
    required this.moccaeApproval,
    required this.moccaeStratDate,
    required this.moccaeExpDate,
    required this.perItemQty,
    required this.description,
    required this.productPicture,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.productCategory,
  });

  final int? id;
  final String? productName;
  final String? batchNumber;
  final int? brandId;
  final DateTime? mfgDate;
  final DateTime? expDate;
  final String? productType;
  final String? unit;
  final String? activeIngredients;
  final String? othersIngredients;
  final String? moccaeApproval;
  final dynamic moccaeStratDate;
  final DateTime? moccaeExpDate;
  final String? perItemQty;
  final String? description;
  final String? productPicture;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? productCategory;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      productName: json["product_name"],
      batchNumber: json["batch_number"],
      brandId: json["brand_id"],
      mfgDate: DateTime.tryParse(json["mfg_date"] ?? ""),
      expDate: DateTime.tryParse(json["exp_date"] ?? ""),
      productType: json["product_type"],
      unit: json["unit"],
      activeIngredients: json["active_ingredients"],
      othersIngredients: json["others_ingredients"],
      moccaeApproval: json["moccae_approval"],
      moccaeStratDate: json["moccae_strat_date"],
      moccaeExpDate: DateTime.tryParse(json["moccae_exp_date"] ?? ""),
      perItemQty: json["per_item_qty"],
      description: json["description"],
      productPicture: json["product_picture"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      productCategory: json["product_category"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "batch_number": batchNumber,
    "brand_id": brandId,
    "product_type": productType,
    "unit": unit,
    "active_ingredients": activeIngredients,
    "others_ingredients": othersIngredients,
    "moccae_approval": moccaeApproval,
    "moccae_strat_date": moccaeStratDate,
    "per_item_qty": perItemQty,
    "description": description,
    "product_picture": productPicture,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product_category": productCategory,
  };

  @override
  String toString(){
    return "$id, $productName, $batchNumber, $brandId, $mfgDate, $expDate, $productType, $unit, $activeIngredients, $othersIngredients, $moccaeApproval, $moccaeStratDate, $moccaeExpDate, $perItemQty, $description, $productPicture, $deletedAt, $createdAt, $updatedAt, $productCategory, ";
  }
}

class ReportCaptain {
  ReportCaptain({
    required this.id,
    required this.captainId,
    required this.jobId,
    required this.jobServiceReportId,
    required this.pestFoundIds,
    required this.tmIds,
    required this.createdAt,
    required this.updatedAt,
    required this.jobCaptainId,
    required this.treatmentMethods,
    required this.pestFoundServices,
  });

  final int? id;
  final int? captainId;
  final int? jobId;
  final int? jobServiceReportId;
  final List<int> pestFoundIds;
  final List<int> tmIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? jobCaptainId;
  final List<TermAndCondition> treatmentMethods;
  final List<Service> pestFoundServices;

  factory ReportCaptain.fromJson(Map<String, dynamic> json){
    return ReportCaptain(
      id: json["id"],
      captainId: json["captain_id"],
      jobId: json["job_id"],
      jobServiceReportId: json["job_service_report_id"],
      pestFoundIds: json["pest_found_ids"] == null ? [] : List<int>.from(json["pest_found_ids"]!.map((x) => x)),
      tmIds: json["tm_ids"] == null ? [] : List<int>.from(json["tm_ids"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      jobCaptainId: json["job_captain_id"],
      treatmentMethods: json["treatment_methods"] == null ? [] : List<TermAndCondition>.from(json["treatment_methods"]!.map((x) => TermAndCondition.fromJson(x))),
      pestFoundServices: json["pest_found_services"] == null ? [] : List<Service>.from(json["pest_found_services"]!.map((x) => Service.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "captain_id": captainId,
    "job_id": jobId,
    "job_service_report_id": jobServiceReportId,
    "pest_found_ids": pestFoundIds.map((x) => x).toList(),
    "tm_ids": tmIds.map((x) => x).toList(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_captain_id": jobCaptainId,
    "treatment_methods": treatmentMethods.map((x) => x?.toJson()).toList(),
    "pest_found_services": pestFoundServices.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$id, $captainId, $jobId, $jobServiceReportId, $pestFoundIds, $tmIds, $createdAt, $updatedAt, $jobCaptainId, $treatmentMethods, $pestFoundServices, ";
  }
}

class Service {
  Service({
    required this.id,
    required this.pestName,
    required this.serviceTitle,
    required this.termAndConditions,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? pestName;
  final String? serviceTitle;
  final String? termAndConditions;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Service.fromJson(Map<String, dynamic> json){
    return Service(
      id: json["id"],
      pestName: json["pest_name"],
      serviceTitle: json["service_title"],
      termAndConditions: json["term_and_conditions"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "pest_name": pestName,
    "service_title": serviceTitle,
    "term_and_conditions": termAndConditions,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $pestName, $serviceTitle, $termAndConditions, $deletedAt, $createdAt, $updatedAt, ";
  }
}

class TermAndCondition {
  TermAndCondition({
    required this.id,
    required this.name,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.text,
  });

  final int? id;
  final String? name;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? text;

  factory TermAndCondition.fromJson(Map<String, dynamic> json){
    return TermAndCondition(
      id: json["id"],
      name: json["name"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      text: json["text"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "text": text,
  };

  @override
  String toString(){
    return "$id, $name, $deletedAt, $createdAt, $updatedAt, $text, ";
  }
}

class ClientAddress {
  ClientAddress({
    required this.id,
    required this.clientId,
    required this.userId,
    required this.address,
    required this.city,
    required this.lat,
    required this.lang,
    required this.country,
    required this.state,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.area,
  });

  final int? id;
  final int? clientId;
  final int? userId;
  final String? address;
  final String? city;
  final String? lat;
  final String? lang;
  final String? country;
  final String? state;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? area;

  factory ClientAddress.fromJson(Map<String, dynamic> json){
    return ClientAddress(
      id: json["id"],
      clientId: json["client_id"],
      userId: json["user_id"],
      address: json["address"],
      city: json["city"],
      lat: json["lat"],
      lang: json["lang"],
      country: json["country"],
      state: json["state"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      area: json["area"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "user_id": userId,
    "address": address,
    "city": city,
    "lat": lat,
    "lang": lang,
    "country": country,
    "state": state,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "area": area,
  };

  @override
  String toString(){
    return "$id, $clientId, $userId, $address, $city, $lat, $lang, $country, $state, $deletedAt, $createdAt, $updatedAt, $area, ";
  }
}

class JobService {
  JobService({
    required this.id,
    required this.jobId,
    required this.serviceId,
    required this.rate,
    required this.subTotal,
    required this.quoteId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.serviceDate,
    required this.isModified,
    required this.service,
  });

  final int? id;
  final int? jobId;
  final int? serviceId;
  final String? rate;
  final String? subTotal;
  final int? quoteId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final DateTime? serviceDate;
  final int? isModified;
  final Service? service;

  factory JobService.fromJson(Map<String, dynamic> json){
    return JobService(
      id: json["id"],
      jobId: json["job_id"],
      serviceId: json["service_id"],
      rate: json["rate"],
      subTotal: json["sub_total"],
      quoteId: json["quote_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      status: json["status"],
      serviceDate: DateTime.tryParse(json["service_date"] ?? ""),
      isModified: json["is_modified"],
      service: json["service"] == null ? null : Service.fromJson(json["service"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_id": jobId,
    "service_id": serviceId,
    "rate": rate,
    "sub_total": subTotal,
    "quote_id": quoteId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "status": status,
    "service_date": serviceDate?.toIso8601String(),
    "is_modified": isModified,
    "service": service?.toJson(),
  };

  @override
  String toString(){
    return "$id, $jobId, $serviceId, $rate, $subTotal, $quoteId, $createdAt, $updatedAt, $status, $serviceDate, $isModified, $service, ";
  }
}

class RescheduleDate {
  RescheduleDate({
    required this.id,
    required this.jobId,
    required this.jobDate,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
    required this.jobServiceId,
  });

  final int? id;
  final int? jobId;
  final String? jobDate;
  final String? reason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic jobServiceId;

  factory RescheduleDate.fromJson(Map<String, dynamic> json){
    return RescheduleDate(
      id: json["id"],
      jobId: json["job_id"],
      jobDate: (json["job_date"] ?? ""),
      reason: json["reason"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      jobServiceId: json["job_service_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_id": jobId,
    "job_date": jobDate,
    "reason": reason,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "job_service_id": jobServiceId,
  };

  @override
  String toString(){
    return "$id, $jobId, $jobDate, $reason, $createdAt, $updatedAt, $jobServiceId, ";
  }
}
