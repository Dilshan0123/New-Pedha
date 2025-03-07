class loadRequestBankListModel {
  int? bankId;
  String? bankName;
  String? ifscCode;
  String? accountNo;
  String? transType;
  String? charges;
  String? bankImage;

  loadRequestBankListModel(
      {this.bankId,
        this.bankName,
        this.ifscCode,
        this.accountNo,
        this.transType,
        this.charges,
        this.bankImage});

  loadRequestBankListModel.fromJson(Map<String, dynamic> json) {
    bankId = json['bankId'];
    bankName = json['bankName'];
    ifscCode = json['ifscCode'];
    accountNo = json['accountNo'];
    transType = json['transType'];
    charges = json['charges'];
    bankImage = json['bankImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankId'] = bankId;
    data['bankName'] = bankName;
    data['ifscCode'] = ifscCode;
    data['accountNo'] = accountNo;
    data['transType'] = transType;
    data['charges'] = charges;
    data['bankImage'] = bankImage;
    return data;
  }
}