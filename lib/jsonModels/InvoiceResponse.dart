class InvoiceResponse {
  String? invoiceId;
  String? recoveryOfficerId;
  String? responseType;
  String? comment;

  InvoiceResponse(
      {this.invoiceId,
        this.recoveryOfficerId,
        this.responseType,
        this.comment});

  InvoiceResponse.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoice_id'];
    recoveryOfficerId = json['recovery_officer_id'];
    responseType = json['response_type'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoiceId;
    data['recovery_officer_id'] = this.recoveryOfficerId;
    data['response_type'] = this.responseType;
    data['comment'] = this.comment;
    return data;
  }
}