class settlementDataModel {
  String? name;
  String? account;
  String? iFSC;
  String? bankName;

  settlementDataModel({this.name, this.account, this.iFSC, this.bankName});

  settlementDataModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    account = json['Account'];
    iFSC = json['IFSC'];
    bankName = json['BankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Account'] = account;
    data['IFSC'] = iFSC;
    data['BankName'] = bankName;
    return data;
  }
}