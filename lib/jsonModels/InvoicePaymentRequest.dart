class InvoicePaymentRequest {
  String? serviceInvoiceId;
  String? paidAmt;
  String? paymentType;
  int is_settlement = 0;
  InvoicePaymentRequest(
      {this.serviceInvoiceId, this.paidAmt, this.paymentType, required this.is_settlement});

  InvoicePaymentRequest.fromJson(Map<String, dynamic> json) {
    serviceInvoiceId = json['service_invoice_id'];
    paidAmt = json['paid_amt'];
    paymentType = json['payment_type'];
    is_settlement = json['is_settlement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_invoice_id'] = this.serviceInvoiceId;
    data['paid_amt'] = this.paidAmt;
    data['payment_type'] = this.paymentType;
    data['is_settlement'] = this.is_settlement;

    return data;
  }
}