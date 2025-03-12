class RecivedChequeRequest {
  String? serviceInvoiceId;
  String? paidAmt;
  String? descrp;
  String? isSettlement;
  String? paymentType;
  String? bankId;
  String? chequeAmount;
  String? chequeNo;
  String? chequeDate;

  RecivedChequeRequest(
      {this.serviceInvoiceId,
        this.paidAmt,
        this.descrp,
        this.isSettlement,
        this.paymentType,
        this.bankId,
        this.chequeAmount,
        this.chequeNo,
        this.chequeDate});

  RecivedChequeRequest.fromJson(Map<String, dynamic> json) {
    serviceInvoiceId = json['service_invoice_id'];
    paidAmt = json['paid_amt'];
    descrp = json['descrp'];
    isSettlement = json['is_settlement'];
    paymentType = json['payment_type'];
    bankId = json['bank_id'];
    chequeAmount = json['cheque_amount'];
    chequeNo = json['cheque_no'];
    chequeDate = json['cheque_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_invoice_id'] = this.serviceInvoiceId;
    data['paid_amt'] = this.paidAmt;
    data['descrp'] = this.descrp;
    data['is_settlement'] = this.isSettlement;
    data['payment_type'] = this.paymentType;
    data['bank_id'] = this.bankId;
    data['cheque_amount'] = this.chequeAmount;
    data['cheque_no'] = this.chequeNo;
    data['cheque_date'] = this.chequeDate;
    return data;
  }
}
