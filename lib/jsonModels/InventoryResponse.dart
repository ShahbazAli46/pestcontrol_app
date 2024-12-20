class InventoryResponse {
  List<InventoryResponseData>? data;

  InventoryResponse({this.data});

  InventoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <InventoryResponseData>[];
      json['data'].forEach((v) {
        data!.add(new InventoryResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InventoryResponseData {
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
  String? moccaeStratDate;
  String? moccaeExpDate;
  String? perItemQty;
  String? description;
  String? productPicture;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Attachments>? attachments;
  List<Stocks>? stocks;

  InventoryResponseData(
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
        this.updatedAt,
        this.attachments,
        this.stocks});

  InventoryResponseData.fromJson(Map<String, dynamic> json) {
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
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(new Stocks.fromJson(v));
      });
    }
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
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  int? id;
  String? fileName;
  String? filePath;
  String? fileExtension;
  String? fileSize;
  String? attachmentDescription;
  String? attachmentableType;
  int? attachmentableId;
  String? createdAt;
  String? updatedAt;

  Attachments(
      {this.id,
        this.fileName,
        this.filePath,
        this.fileExtension,
        this.fileSize,
        this.attachmentDescription,
        this.attachmentableType,
        this.attachmentableId,
        this.createdAt,
        this.updatedAt});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    fileExtension = json['file_extension'];
    fileSize = json['file_size'];
    attachmentDescription = json['attachment_description'];
    attachmentableType = json['attachmentable_type'];
    attachmentableId = json['attachmentable_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_name'] = this.fileName;
    data['file_path'] = this.filePath;
    data['file_extension'] = this.fileExtension;
    data['file_size'] = this.fileSize;
    data['attachment_description'] = this.attachmentDescription;
    data['attachmentable_type'] = this.attachmentableType;
    data['attachmentable_id'] = this.attachmentableId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Stocks {
  int? id;
  int? productId;
  String? totalQty;
  String? remainingQty;

  Stocks({this.id, this.productId, this.totalQty, this.remainingQty});

  Stocks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    totalQty = json['total_qty'];
    remainingQty = json['remaining_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['total_qty'] = this.totalQty;
    data['remaining_qty'] = this.remainingQty;
    return data;
  }
}
