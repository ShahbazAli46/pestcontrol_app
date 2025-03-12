class SalesOfficerTargetResponse {
  SalesOfficerTargetResponseData? data;

  SalesOfficerTargetResponse({this.data});

  SalesOfficerTargetResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SalesOfficerTargetResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SalesOfficerTargetResponseData {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  int? isActive;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? firedAt;
  String? appVersion;
  String? firebaseToken;
  int? branchId;
  Employee? employee;
  Role? role;
  List<EmpContractTargets>? empContractTargets;
  List<EmployeeCommissions>? employeeCommissions;

  SalesOfficerTargetResponseData(
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
        this.appVersion,
        this.firebaseToken,
        this.branchId,
        this.employee,
        this.role,
        this.empContractTargets,
        this.employeeCommissions});

  SalesOfficerTargetResponseData.fromJson(Map<String, dynamic> json) {
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
    appVersion = json['app_version'];
    firebaseToken = json['firebase_token'];
    branchId = json['branch_id'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    if (json['emp_contract_targets'] != null) {
      empContractTargets = <EmpContractTargets>[];
      json['emp_contract_targets'].forEach((v) {
        empContractTargets!.add(new EmpContractTargets.fromJson(v));
      });
    }
    if (json['employee_commissions'] != null) {
      employeeCommissions = <EmployeeCommissions>[];
      json['employee_commissions'].forEach((v) {
        employeeCommissions!.add(new EmployeeCommissions.fromJson(v));
      });
    }
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
    data['app_version'] = this.appVersion;
    data['firebase_token'] = this.firebaseToken;
    data['branch_id'] = this.branchId;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.empContractTargets != null) {
      data['emp_contract_targets'] =
          this.empContractTargets!.map((v) => v.toJson()).toList();
    }
    if (this.employeeCommissions != null) {
      data['employee_commissions'] =
          this.employeeCommissions!.map((v) => v.toJson()).toList();
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
  String? target;
  String? profession;
  String? relativeName;
  String? relation;
  String? emergencyContact;
  String? basicSalary;
  String? allowance;
  String? other;
  String? totalSalary;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? commissionPer;
  String? holdSalary;
  String? country;
  int? branchId;
  String? joiningDate;
  int? remainingOffDays;
  String? contractTarget;
  String? currentAdvBalance;
  String? currentFineBalance;

  Employee(
      {this.id,
        this.userId,
        this.roleId,
        this.profileImage,
        this.phoneNumber,
        this.target,
        this.profession,
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
        this.commissionPer,
        this.holdSalary,
        this.country,
        this.branchId,
        this.joiningDate,
        this.remainingOffDays,
        this.contractTarget,
        this.currentAdvBalance,
        this.currentFineBalance});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    roleId = json['role_id'];
    profileImage = json['profile_image'];
    phoneNumber = json['phone_number'];
    target = json['target'];
    profession = json['profession'];
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
    commissionPer = json['commission_per'];
    holdSalary = json['hold_salary'];
    country = json['country'];
    branchId = json['branch_id'];
    joiningDate = json['joining_date'];
    remainingOffDays = json['remaining_off_days'];
    contractTarget = json['contract_target'];
    currentAdvBalance = json['current_adv_balance'];
    currentFineBalance = json['current_fine_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['profile_image'] = this.profileImage;
    data['phone_number'] = this.phoneNumber;
    data['target'] = this.target;
    data['profession'] = this.profession;
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
    data['commission_per'] = this.commissionPer;
    data['hold_salary'] = this.holdSalary;
    data['country'] = this.country;
    data['branch_id'] = this.branchId;
    data['joining_date'] = this.joiningDate;
    data['remaining_off_days'] = this.remainingOffDays;
    data['contract_target'] = this.contractTarget;
    data['current_adv_balance'] = this.currentAdvBalance;
    data['current_fine_balance'] = this.currentFineBalance;
    return data;
  }
}

class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class EmpContractTargets {
  int? id;
  int? userId;
  int? employeeId;
  String? month;
  String? baseTarget;
  String? contractTarget;
  String? achievedTarget;
  String? cancelledContractAmt;
  String? remainingTarget;
  String? createdAt;
  String? updatedAt;
  List<Details>? details;

  EmpContractTargets(
      {this.id,
        this.userId,
        this.employeeId,
        this.month,
        this.baseTarget,
        this.contractTarget,
        this.achievedTarget,
        this.cancelledContractAmt,
        this.remainingTarget,
        this.createdAt,
        this.updatedAt,
        this.details});

  EmpContractTargets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    month = json['month'];
    baseTarget = json['base_target'];
    contractTarget = json['contract_target'];
    achievedTarget = json['achieved_target'];
    cancelledContractAmt = json['cancelled_contract_amt'];
    remainingTarget = json['remaining_target'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['month'] = this.month;
    data['base_target'] = this.baseTarget;
    data['contract_target'] = this.contractTarget;
    data['achieved_target'] = this.achievedTarget;
    data['cancelled_contract_amt'] = this.cancelledContractAmt;
    data['remaining_target'] = this.remainingTarget;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  int? empContractTargetId;
  int? userId;
  int? employeeId;
  String? detail;
  String? month;
  int? contractId;
  String? amount;
  String? type;
  String? createdAt;
  String? updatedAt;

  Details(
      {this.id,
        this.empContractTargetId,
        this.userId,
        this.employeeId,
        this.detail,
        this.month,
        this.contractId,
        this.amount,
        this.type,
        this.createdAt,
        this.updatedAt});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empContractTargetId = json['emp_contract_target_id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    detail = json['detail'];
    month = json['month'];
    contractId = json['contract_id'];
    amount = json['amount'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_contract_target_id'] = this.empContractTargetId;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['detail'] = this.detail;
    data['month'] = this.month;
    data['contract_id'] = this.contractId;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class EmployeeCommissions {
  int? id;
  String? target;
  String? commissionPer;
  String? sale;
  String? paidAmt;
  String? month;
  String? status;
  String? paidAt;
  int? referencableId;
  String? referencableType;
  String? createdAt;
  String? updatedAt;

  EmployeeCommissions(
      {this.id,
        this.target,
        this.commissionPer,
        this.sale,
        this.paidAmt,
        this.month,
        this.status,
        this.paidAt,
        this.referencableId,
        this.referencableType,
        this.createdAt,
        this.updatedAt});

  EmployeeCommissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    target = json['target'];
    commissionPer = json['commission_per'];
    sale = json['sale'];
    paidAmt = json['paid_amt'];
    month = json['month'];
    status = json['status'];
    paidAt = json['paid_at'];
    referencableId = json['referencable_id'];
    referencableType = json['referencable_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['target'] = this.target;
    data['commission_per'] = this.commissionPer;
    data['sale'] = this.sale;
    data['paid_amt'] = this.paidAmt;
    data['month'] = this.month;
    data['status'] = this.status;
    data['paid_at'] = this.paidAt;
    data['referencable_id'] = this.referencableId;
    data['referencable_type'] = this.referencableType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
