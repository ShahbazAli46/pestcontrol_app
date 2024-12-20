class PurchaseOrderDetailsResponse {
  PurchaseOrderDetailsResponseData? data;

  PurchaseOrderDetailsResponse({this.data});

  PurchaseOrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PurchaseOrderDetailsResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PurchaseOrderDetailsResponseData {
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
  List<OrderDetails>? orderDetails;

  PurchaseOrderDetailsResponseData(
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
        this.supplier,
        this.orderDetails});

  PurchaseOrderDetailsResponseData.fromJson(Map<String, dynamic> json) {
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
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
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
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Supplier {
  int? id;
  String? supplierName;

  Supplier({this.id, this.supplierName});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierName = json['supplier_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['supplier_name'] = this.supplierName;
    return data;
  }
}

class OrderDetails {
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
  Product? product;

  OrderDetails(
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
        this.product});

  OrderDetails.fromJson(Map<String, dynamic> json) {
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
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
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
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
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
  Brand? brand;

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
        this.updatedAt,
        this.brand});

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
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
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
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    return data;
  }
}

class Brand {
  int? id;
  String? name;

  Brand({this.id, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
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
