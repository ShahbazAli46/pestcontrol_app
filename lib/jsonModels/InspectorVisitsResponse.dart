class InspectorVisitsResponse {
  String? startDate;
  String? endDate;
  List<InspectorVisitsResponseData>? data;

  InspectorVisitsResponse({this.startDate, this.endDate, this.data});

  InspectorVisitsResponse.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['data'] != null) {
      data = <InspectorVisitsResponseData>[];
      json['data'].forEach((v) {
        data!.add(new InspectorVisitsResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InspectorVisitsResponseData {
  int? id;
  int? userClientId;
  String? clientRemarks;
  String? inspectionRemarks;
  String? recommendationForOperation;
  String? generalComment;
  List<String>? pictures;
  String? nestingArea;
  int? userId;
  int? employeeId;
  String? createdAt;
  String? updatedAt;
  UserClient? userClient;

  InspectorVisitsResponseData(
      {this.id,
        this.userClientId,
        this.clientRemarks,
        this.inspectionRemarks,
        this.recommendationForOperation,
        this.generalComment,
        this.pictures,
        this.nestingArea,
        this.userId,
        this.employeeId,
        this.createdAt,
        this.updatedAt,
        this.userClient});

  InspectorVisitsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userClientId = json['user_client_id'];
    clientRemarks = json['client_remarks'];
    inspectionRemarks = json['inspection_remarks'];
    recommendationForOperation = json['recommendation_for_operation'];
    generalComment = json['general_comment'];
    pictures = json['pictures'].cast<String>();
    nestingArea = json['nesting_area'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userClient = json['user_client'] != null
        ? new UserClient.fromJson(json['user_client'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_client_id'] = this.userClientId;
    data['client_remarks'] = this.clientRemarks;
    data['inspection_remarks'] = this.inspectionRemarks;
    data['recommendation_for_operation'] = this.recommendationForOperation;
    data['general_comment'] = this.generalComment;
    data['pictures'] = this.pictures;
    data['nesting_area'] = this.nestingArea;
    data['user_id'] = this.userId;
    data['employee_id'] = this.employeeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userClient != null) {
      data['user_client'] = this.userClient!.toJson();
    }
    return data;
  }
}

class UserClient {
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

  UserClient(
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
        this.branchId});

  UserClient.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
