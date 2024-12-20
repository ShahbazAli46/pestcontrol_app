class ProductHistoryResponse {
  ProductHistoryResponseData? data;

  ProductHistoryResponse({this.data});

  ProductHistoryResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProductHistoryResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProductHistoryResponseData {
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
  List<AssignedStockHistory>? assignedStockHistory;
  List<PurchasedStockHistory>? purchasedStockHistory;
  List<Attachments>? attachments;
  List<Stocks>? stocks;

  ProductHistoryResponseData(
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
        this.assignedStockHistory,
        this.purchasedStockHistory,
        this.attachments,
        this.stocks});

  ProductHistoryResponseData.fromJson(Map<String, dynamic> json) {
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
    if (json['assigned_stock_history'] != null) {
      assignedStockHistory = <AssignedStockHistory>[];
      json['assigned_stock_history'].forEach((v) {
        assignedStockHistory!.add(new AssignedStockHistory.fromJson(v));
      });
    }
    if (json['purchased_stock_history'] != null) {
      purchasedStockHistory = <PurchasedStockHistory>[];
      json['purchased_stock_history'].forEach((v) {
        purchasedStockHistory!.add(new PurchasedStockHistory.fromJson(v));
      });
    }
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
    if (this.assignedStockHistory != null) {
      data['assigned_stock_history'] =
          this.assignedStockHistory!.map((v) => v.toJson()).toList();
    }
    if (this.purchasedStockHistory != null) {
      data['purchased_stock_history'] =
          this.purchasedStockHistory!.map((v) => v.toJson()).toList();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssignedStockHistory {
  int? id;
  int? productId;
  String? totalQty;
  String? stockIn;
  String? stockOut;
  String? remainingQty;
  int? personId;
  String? personType;
  Null? linkId;
  Null? linkName;
  String? createdAt;
  String? updatedAt;
  Person? person;

  AssignedStockHistory(
      {this.id,
        this.productId,
        this.totalQty,
        this.stockIn,
        this.stockOut,
        this.remainingQty,
        this.personId,
        this.personType,
        this.linkId,
        this.linkName,
        this.createdAt,
        this.updatedAt,
        this.person});

  AssignedStockHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    totalQty = json['total_qty'];
    stockIn = json['stock_in'];
    stockOut = json['stock_out'];
    remainingQty = json['remaining_qty'];
    personId = json['person_id'];
    personType = json['person_type'];
    linkId = json['link_id'];
    linkName = json['link_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    person =
    json['person'] != null ? new Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['total_qty'] = this.totalQty;
    data['stock_in'] = this.stockIn;
    data['stock_out'] = this.stockOut;
    data['remaining_qty'] = this.remainingQty;
    data['person_id'] = this.personId;
    data['person_type'] = this.personType;
    data['link_id'] = this.linkId;
    data['link_name'] = this.linkName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.person != null) {
      data['person'] = this.person!.toJson();
    }
    return data;
  }
}

class Person {
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

  Person(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.isActive,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.firedAt});

  Person.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class PurchasedStockHistory {
  int? id;
  int? purchaseOrderId;
  int? productId;
  String? quantity;
  String? price;
  String? subTotal;
  String? vatPer;
  String? vatAmount;
  String? total;
  String? createdAt;
  String? updatedAt;
  PurchaseOrder? purchaseOrder;

  PurchasedStockHistory(
      {this.id,
        this.purchaseOrderId,
        this.productId,
        this.quantity,
        this.price,
        this.subTotal,
        this.vatPer,
        this.vatAmount,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.purchaseOrder});

  PurchasedStockHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseOrderId = json['purchase_order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    subTotal = json['sub_total'];
    vatPer = json['vat_per'];
    vatAmount = json['vat_amount'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    purchaseOrder = json['purchase_order'] != null
        ? new PurchaseOrder.fromJson(json['purchase_order'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purchase_order_id'] = this.purchaseOrderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['sub_total'] = this.subTotal;
    data['vat_per'] = this.vatPer;
    data['vat_amount'] = this.vatAmount;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.purchaseOrder != null) {
      data['purchase_order'] = this.purchaseOrder!.toJson();
    }
    return data;
  }
}

class PurchaseOrder {
  int? id;
  String? poId;
  Null? purchaseInvoice;
  int? supplierId;
  String? city;
  String? zip;
  String? orderDate;
  String? deliveryDate;
  String? privateNote;
  String? subTotal;
  String? vatAmt;
  String? disPer;
  String? disAmt;
  String? grandTotal;
  String? createdAt;
  String? updatedAt;
  String? invoiceNo;
  Supplier? supplier;

  PurchaseOrder(
      {this.id,
        this.poId,
        this.purchaseInvoice,
        this.supplierId,
        this.city,
        this.zip,
        this.orderDate,
        this.deliveryDate,
        this.privateNote,
        this.subTotal,
        this.vatAmt,
        this.disPer,
        this.disAmt,
        this.grandTotal,
        this.createdAt,
        this.updatedAt,
        this.invoiceNo,
        this.supplier});

  PurchaseOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    poId = json['po_id'];
    purchaseInvoice = json['purchase_invoice'];
    supplierId = json['supplier_id'];
    city = json['city'];
    zip = json['zip'];
    orderDate = json['order_date'];
    deliveryDate = json['delivery_date'];
    privateNote = json['private_note'];
    subTotal = json['sub_total'];
    vatAmt = json['vat_amt'];
    disPer = json['dis_per'];
    disAmt = json['dis_amt'];
    grandTotal = json['grand_total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    invoiceNo = json['invoice_no'];
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['po_id'] = this.poId;
    data['purchase_invoice'] = this.purchaseInvoice;
    data['supplier_id'] = this.supplierId;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['order_date'] = this.orderDate;
    data['delivery_date'] = this.deliveryDate;
    data['private_note'] = this.privateNote;
    data['sub_total'] = this.subTotal;
    data['vat_amt'] = this.vatAmt;
    data['dis_per'] = this.disPer;
    data['dis_amt'] = this.disAmt;
    data['grand_total'] = this.grandTotal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['invoice_no'] = this.invoiceNo;
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    return data;
  }
}

class Supplier {
  int? id;
  String? supplierName;
  String? companyName;
  String? email;
  String? number;
  String? trnNo;
  String? itemNotes;
  String? address;
  String? country;
  Null? state;
  String? city;
  String? zip;
  Null? tag;
  String? openingBalance;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Supplier(
      {this.id,
        this.supplierName,
        this.companyName,
        this.email,
        this.number,
        this.trnNo,
        this.itemNotes,
        this.address,
        this.country,
        this.state,
        this.city,
        this.zip,
        this.tag,
        this.openingBalance,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierName = json['supplier_name'];
    companyName = json['company_name'];
    email = json['email'];
    number = json['number'];
    trnNo = json['trn_no'];
    itemNotes = json['item_notes'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zip = json['zip'];
    tag = json['tag'];
    openingBalance = json['opening_balance'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['supplier_name'] = this.supplierName;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['number'] = this.number;
    data['trn_no'] = this.trnNo;
    data['item_notes'] = this.itemNotes;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['tag'] = this.tag;
    data['opening_balance'] = this.openingBalance;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
