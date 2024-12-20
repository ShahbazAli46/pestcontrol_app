class ProductUseHistoryResponse {
  ProductUseHistoryResponseData? data;

  ProductUseHistoryResponse({this.data});

  ProductUseHistoryResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProductUseHistoryResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProductUseHistoryResponseData {
  User? user;
  Product? product;
  List<UsedStock>? usedStock;

  ProductUseHistoryResponseData({this.user, this.product, this.usedStock});

  ProductUseHistoryResponseData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['used_stock'] != null) {
      usedStock = <UsedStock>[];
      json['used_stock'].forEach((v) {
        usedStock!.add(new UsedStock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.usedStock != null) {
      data['used_stock'] = this.usedStock!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  int? roleId;
  int? isActive;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? firedAt;
  Employee? employee;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.firedAt,
        this.employee});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firedAt = json['fired_at'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['is_active'] = this.isActive;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fired_at'] = this.firedAt;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class Employee {
  int? id;
  int? userId;
  int? roleId;
  String? profileImage;
  String? phoneNumber;
  String? eidNo;
  String? target;
  String? eidStart;
  String? eidExpiry;
  String? profession;
  String? passportNo;
  String? passportStart;
  String? passportExpiry;
  String? hiStatus;
  String? hiStart;
  String? hiExpiry;
  String? uiStatus;
  String? uiStart;
  String? uiExpiry;
  String? dmCard;
  String? dmStart;
  String? dmExpiry;
  String? relativeName;
  String? relation;
  String? emergencyContact;
  String? basicSalary;
  String? allowance;
  String? other;
  String? totalSalary;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? labourCardExpiry;
  String? commissionPer;

  Employee(
      {this.id,
        this.userId,
        this.roleId,
        this.profileImage,
        this.phoneNumber,
        this.eidNo,
        this.target,
        this.eidStart,
        this.eidExpiry,
        this.profession,
        this.passportNo,
        this.passportStart,
        this.passportExpiry,
        this.hiStatus,
        this.hiStart,
        this.hiExpiry,
        this.uiStatus,
        this.uiStart,
        this.uiExpiry,
        this.dmCard,
        this.dmStart,
        this.dmExpiry,
        this.relativeName,
        this.relation,
        this.emergencyContact,
        this.basicSalary,
        this.allowance,
        this.other,
        this.totalSalary,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.labourCardExpiry,
        this.commissionPer});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    roleId = json['role_id'];
    profileImage = json['profile_image'];
    phoneNumber = json['phone_number'];
    eidNo = json['eid_no'];
    target = json['target'];
    eidStart = json['eid_start'];
    eidExpiry = json['eid_expiry'];
    profession = json['profession'];
    passportNo = json['passport_no'];
    passportStart = json['passport_start'];
    passportExpiry = json['passport_expiry'];
    hiStatus = json['hi_status'];
    hiStart = json['hi_start'];
    hiExpiry = json['hi_expiry'];
    uiStatus = json['ui_status'];
    uiStart = json['ui_start'];
    uiExpiry = json['ui_expiry'];
    dmCard = json['dm_card'];
    dmStart = json['dm_start'];
    dmExpiry = json['dm_expiry'];
    relativeName = json['relative_name'];
    relation = json['relation'];
    emergencyContact = json['emergency_contact'];
    basicSalary = json['basic_salary'];
    allowance = json['allowance'];
    other = json['other'];
    totalSalary = json['total_salary'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    labourCardExpiry = json['labour_card_expiry'];
    commissionPer = json['commission_per'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['profile_image'] = this.profileImage;
    data['phone_number'] = this.phoneNumber;
    data['eid_no'] = this.eidNo;
    data['target'] = this.target;
    data['eid_start'] = this.eidStart;
    data['eid_expiry'] = this.eidExpiry;
    data['profession'] = this.profession;
    data['passport_no'] = this.passportNo;
    data['passport_start'] = this.passportStart;
    data['passport_expiry'] = this.passportExpiry;
    data['hi_status'] = this.hiStatus;
    data['hi_start'] = this.hiStart;
    data['hi_expiry'] = this.hiExpiry;
    data['ui_status'] = this.uiStatus;
    data['ui_start'] = this.uiStart;
    data['ui_expiry'] = this.uiExpiry;
    data['dm_card'] = this.dmCard;
    data['dm_start'] = this.dmStart;
    data['dm_expiry'] = this.dmExpiry;
    data['relative_name'] = this.relativeName;
    data['relation'] = this.relation;
    data['emergency_contact'] = this.emergencyContact;
    data['basic_salary'] = this.basicSalary;
    data['allowance'] = this.allowance;
    data['other'] = this.other;
    data['total_salary'] = this.totalSalary;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['labour_card_expiry'] = this.labourCardExpiry;
    data['commission_per'] = this.commissionPer;
    return data;
  }
}

class Product {
  int? id;
  String? productName;
  String? batchNumber;
  int? brandId;
  String? mfgDate;
  String? expDate;
  String? productType;
  String? unit;
  String? activeIngredients;
  String? othersIngredients;
  String? moccaeApproval;
  Null? moccaeStratDate;
  String? moccaeExpDate;
  String? perItemQty;
  String? description;
  String? productPicture;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
        this.productName,
        this.batchNumber,
        this.brandId,
        this.mfgDate,
        this.expDate,
        this.productType,
        this.unit,
        this.activeIngredients,
        this.othersIngredients,
        this.moccaeApproval,
        this.moccaeStratDate,
        this.moccaeExpDate,
        this.perItemQty,
        this.description,
        this.productPicture,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    batchNumber = json['batch_number'];
    brandId = json['brand_id'];
    mfgDate = json['mfg_date'];
    expDate = json['exp_date'];
    productType = json['product_type'];
    unit = json['unit'];
    activeIngredients = json['active_ingredients'];
    othersIngredients = json['others_ingredients'];
    moccaeApproval = json['moccae_approval'];
    moccaeStratDate = json['moccae_strat_date'];
    moccaeExpDate = json['moccae_exp_date'];
    perItemQty = json['per_item_qty'];
    description = json['description'];
    productPicture = json['product_picture'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['batch_number'] = this.batchNumber;
    data['brand_id'] = this.brandId;
    data['mfg_date'] = this.mfgDate;
    data['exp_date'] = this.expDate;
    data['product_type'] = this.productType;
    data['unit'] = this.unit;
    data['active_ingredients'] = this.activeIngredients;
    data['others_ingredients'] = this.othersIngredients;
    data['moccae_approval'] = this.moccaeApproval;
    data['moccae_strat_date'] = this.moccaeStratDate;
    data['moccae_exp_date'] = this.moccaeExpDate;
    data['per_item_qty'] = this.perItemQty;
    data['description'] = this.description;
    data['product_picture'] = this.productPicture;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UsedStock {
  int? id;
  int? jobId;
  int? jobServiceReportId;
  int? productId;
  String? dose;
  int? qty;
  String? total;
  String? price;
  int? isExtra;
  String? createdAt;
  String? updatedAt;
  Job? job;

  UsedStock(
      {this.id,
        this.jobId,
        this.jobServiceReportId,
        this.productId,
        this.dose,
        this.qty,
        this.total,
        this.price,
        this.isExtra,
        this.createdAt,
        this.updatedAt,
        this.job});

  UsedStock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    jobServiceReportId = json['job_service_report_id'];
    productId = json['product_id'];
    dose = json['dose'];
    qty = json['qty'];
    total = json['total'];
    price = json['price'];
    isExtra = json['is_extra'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['job_service_report_id'] = this.jobServiceReportId;
    data['product_id'] = this.productId;
    data['dose'] = this.dose;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['price'] = this.price;
    data['is_extra'] = this.isExtra;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    return data;
  }
}

class Job {
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
  int? captainId;
  String? teamMemberIds;
  String? jobInstructions;
  int? termAndConditionId;
  int? quoteId;
  String? createdAt;
  String? updatedAt;
  String? jobStartTime;
  String? jobEndTime;
  User? user;

  Job(
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
        this.user});

  Job.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
