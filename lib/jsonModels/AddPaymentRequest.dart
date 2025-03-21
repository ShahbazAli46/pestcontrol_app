class AddPaymentRequest {
  String? serviceInvoiceId;
  String? paidAmt;
  String? description;
  String? paymentType;
  String? bankId;
  String? transectionId;
  int? is_settlement = 0;

  AddPaymentRequest(
      {this.serviceInvoiceId,
        this.paidAmt,
        this.description,
        this.paymentType,
        this.bankId,
        this.transectionId,
        this.is_settlement
      });

  AddPaymentRequest.fromJson(Map<String, dynamic> json) {
    serviceInvoiceId = json['service_invoice_id'];
    paidAmt = json['paid_amt'];
    description = json['description'];
    paymentType = json['payment_type'];
    bankId = json['bank_id'];
    transectionId = json['transection_id'];
    is_settlement = json['is_settlement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_invoice_id'] = this.serviceInvoiceId;
    data['paid_amt'] = this.paidAmt;
    data['description'] = this.description;
    data['payment_type'] = this.paymentType;
    data['bank_id'] = this.bankId;
    data['transection_id'] = this.transectionId;
    data['is_settlement'] = this.is_settlement;
    return data;
  }
}
