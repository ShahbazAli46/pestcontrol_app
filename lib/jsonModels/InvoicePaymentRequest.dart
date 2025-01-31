class InvoicePaymentRequest {
  String? serviceInvoiceId;
  String? paidAmt;
  String? paymentType;

  InvoicePaymentRequest(
      {this.serviceInvoiceId, this.paidAmt, this.paymentType});

  InvoicePaymentRequest.fromJson(Map<String, dynamic> json) {
    serviceInvoiceId = json['service_invoice_id'];
    paidAmt = json['paid_amt'];
    paymentType = json['payment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_invoice_id'] = this.serviceInvoiceId;
    data['paid_amt'] = this.paidAmt;
    data['payment_type'] = this.paymentType;
    return data;
  }
}