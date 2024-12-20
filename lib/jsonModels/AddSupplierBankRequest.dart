class AddSupplierBankRequest {
  String? supplierId;
  String? bankName;
  String? iban;
  String? accountNumber;
  String? address;

  AddSupplierBankRequest(
      {this.supplierId,
        this.bankName,
        this.iban,
        this.accountNumber,
        this.address});

  AddSupplierBankRequest.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    bankName = json['bank_name'];
    iban = json['iban'];
    accountNumber = json['account_number'];
    address = json['address'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['supplier_id'] = this.supplierId ?? "";
    data['bank_name'] = this.bankName ?? "";
    data['iban'] = this.iban ?? "";
    data['account_number'] = this.accountNumber ?? "";
    data['address'] = this.address ?? "";
    return data;
  }
}
