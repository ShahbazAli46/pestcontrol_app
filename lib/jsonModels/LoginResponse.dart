class LoginResponse {
  String? status;
  String? token;
  Data? data;


  LoginResponse({this.status, this.token, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  int? roleId;
  int? isActive;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Role? role;
  Employee? employee;

  Data(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.role,
        this.employee});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
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
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
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
        this.updatedAt});

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
    return data;
  }
}
