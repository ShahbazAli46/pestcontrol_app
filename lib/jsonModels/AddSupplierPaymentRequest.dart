class AddSupplierPaymentRequest {
  String? supplierId;
  String? vat;
  String? total;
  String? description;
  String? paymentType;
  String? bankId;
  String? amount;
  String? chequeNo;
  String? chequeDate;
  String? transectionId; // Corrected spelling

  AddSupplierPaymentRequest(
      {this.supplierId,
        this.vat,
        this.total,
        this.description,
        this.paymentType,
        this.bankId,
        this.amount,
        this.chequeNo,
        this.chequeDate,
        this.transectionId});

  AddSupplierPaymentRequest.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    vat = json['vat'];
    total = json['total'];
    description = json['description'];
    paymentType = json['payment_type'];
    bankId = json['bank_id'];
    amount = json['amount'];
    chequeNo = json['cheque_no'];
    chequeDate = json['cheque_date'];
    transectionId = json['transection_id']; // Corrected field
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['supplier_id'] = this.supplierId ?? "";
    data['vat'] = this.vat ?? "";
    data['total'] = this.total ?? "";
    data['description'] = this.description ?? "";
    data['payment_type'] = this.paymentType ?? "";
    data['bank_id'] = this.bankId ?? "";
    data['amount'] = this.amount ?? "";
    data['cheque_no'] = this.chequeNo ?? "";
    data['cheque_date'] = this.chequeDate ?? "";
    data['transection_id'] = this.transectionId ?? ""; // Corrected field
    return data;
  }
}
