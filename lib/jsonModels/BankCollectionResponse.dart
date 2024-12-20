class BankCollectionResponse {
  BankCollectionResponseData? data;

  BankCollectionResponse({this.data});

  BankCollectionResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new BankCollectionResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BankCollectionResponseData {
  ChequeTransfer? chequeTransfer;
  ChequeTransfer? onlineTransfer;
  String? totalChequeTransfer;
  int? totalChequeCount;

  BankCollectionResponseData(
      {this.chequeTransfer,
        this.onlineTransfer,
        this.totalChequeTransfer,
        this.totalChequeCount});

  BankCollectionResponseData.fromJson(Map<String, dynamic> json) {
    chequeTransfer = json['cheque_transfer'] != null
        ? new ChequeTransfer.fromJson(json['cheque_transfer'])
        : null;
    onlineTransfer = json['online_transfer'] != null
        ? new ChequeTransfer.fromJson(json['online_transfer'])
        : null;
    totalChequeTransfer = json['total_cheque_transfer'];
    totalChequeCount = json['total_cheque_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chequeTransfer != null) {
      data['cheque_transfer'] = this.chequeTransfer!.toJson();
    }
    if (this.onlineTransfer != null) {
      data['online_transfer'] = this.onlineTransfer!.toJson();
    }
    data['total_cheque_transfer'] = this.totalChequeTransfer;
    data['total_cheque_count'] = this.totalChequeCount;
    return data;
  }
}

class ChequeTransfer {
  String? total;
  int? count;

  ChequeTransfer({this.total, this.count});

  ChequeTransfer.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    return data;
  }
}
