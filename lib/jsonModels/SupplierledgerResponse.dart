class SupplierledgerResponse {
  List<Data>? data;

  SupplierledgerResponse({this.data});

  SupplierledgerResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? bankId;
  String? description;
  String? drAmt;
  String? crAmt;
  String? paymentType;
  String? cashAmt;
  String? posAmt;
  String? chequeAmt;
  String? onlineAmt;
  String? chequeNo;
  String? chequeDate;
  String? entryType;
  String? transectionId;
  String? bankBalance;
  String? cashBalance;
  int? personId;
  String? personType;
  int? linkId;
  String? linkName;
  String? createdAt;
  String? updatedAt;
  PurchaseOrder? purchaseOrder;
  Personable? personable;

  Data(
      {this.id,
        this.bankId,
        this.description,
        this.drAmt,
        this.crAmt,
        this.paymentType,
        this.cashAmt,
        this.posAmt,
        this.chequeAmt,
        this.onlineAmt,
        this.chequeNo,
        this.chequeDate,
        this.entryType,
        this.transectionId,
        this.bankBalance,
        this.cashBalance,
        this.personId,
        this.personType,
        this.linkId,
        this.linkName,
        this.createdAt,
        this.updatedAt,
        this.purchaseOrder,
        this.personable});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bank_id'];
    description = json['description'];
    drAmt = json['dr_amt'];
    crAmt = json['cr_amt'];
    paymentType = json['payment_type'];
    cashAmt = json['cash_amt'];
    posAmt = json['pos_amt'];
    chequeAmt = json['cheque_amt'];
    onlineAmt = json['online_amt'];
    chequeNo = json['cheque_no'];
    chequeDate = json['cheque_date'];
    entryType = json['entry_type'];
    transectionId = json['transection_id'];
    bankBalance = json['bank_balance'];
    cashBalance = json['cash_balance'];
    personId = json['person_id'];
    personType = json['person_type'];
    linkId = json['link_id'];
    linkName = json['link_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    purchaseOrder = json['purchase_order'] != null
        ? new PurchaseOrder.fromJson(json['purchase_order'])
        : null;
    personable = json['personable'] != null
        ? new Personable.fromJson(json['personable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_id'] = this.bankId;
    data['description'] = this.description;
    data['dr_amt'] = this.drAmt;
    data['cr_amt'] = this.crAmt;
    data['payment_type'] = this.paymentType;
    data['cash_amt'] = this.cashAmt;
    data['pos_amt'] = this.posAmt;
    data['cheque_amt'] = this.chequeAmt;
    data['online_amt'] = this.onlineAmt;
    data['cheque_no'] = this.chequeNo;
    data['cheque_date'] = this.chequeDate;
    data['entry_type'] = this.entryType;
    data['transection_id'] = this.transectionId;
    data['bank_balance'] = this.bankBalance;
    data['cash_balance'] = this.cashBalance;
    data['person_id'] = this.personId;
    data['person_type'] = this.personType;
    data['link_id'] = this.linkId;
    data['link_name'] = this.linkName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.purchaseOrder != null) {
      data['purchase_order'] = this.purchaseOrder!.toJson();
    }
    if (this.personable != null) {
      data['personable'] = this.personable!.toJson();
    }
    return data;
  }
}

class PurchaseOrder {
  int? id;
  String? poId;
  String? purchaseInvoice;
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
        this.invoiceNo});

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
    return data;
  }
}

class Personable {
  int? id;
  String? supplierName;
  String? companyName;
  String? email;
  String? number;
  String? trnNo;
  String? itemNotes;
  String? address;
  String? country;
  String? state;
  String? city;
  String? zip;
  String? tag;
  String? openingBalance;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Personable(
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

  Personable.fromJson(Map<String, dynamic> json) {
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
