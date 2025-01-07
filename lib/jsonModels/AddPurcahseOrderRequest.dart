class AddPurcahseOrderRequest {
  String? invoiceNo;
  String? supplierId;
  String? orderDate;
  String? deliveryDate;
  String? privateNote;
  String? disPer;
  String? productId;
  String? quantity;
  String? price;
  String? vatPer;

  AddPurcahseOrderRequest(
      {this.invoiceNo,
        this.supplierId,
        this.orderDate,
        this.deliveryDate,
        this.privateNote,
        this.disPer,
        this.productId,
        this.quantity,
        this.price,
        this.vatPer});

  AddPurcahseOrderRequest.fromJson(Map<String, dynamic> json) {
    invoiceNo = json['invoice_no'];
    supplierId = json['supplier_id'];
    orderDate = json['order_date'];
    deliveryDate = json['delivery_date'];
    privateNote = json['private_note'];
    disPer = json['dis_per'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    vatPer = json['vat_per'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['invoice_no'] = this.invoiceNo ?? "";
    data['supplier_id'] = this.supplierId ?? "";
    data['order_date'] = this.orderDate ?? "";
    data['delivery_date'] = this.deliveryDate ?? "";
    data['private_note'] = this.privateNote ?? "";
    data['dis_per'] = this.disPer ?? "";
    data['product_id'] = this.productId ?? "";
    data['quantity'] = this.quantity ?? "";
    data['price'] = this.price ?? "";
    data['vat_per'] = this.vatPer ?? "";
    return data;
  }
}
