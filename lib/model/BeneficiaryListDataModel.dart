class PU_benListDataModel {
  String? status;
  List<Beneficiary>? beneficiary;

  PU_benListDataModel({this.status, this.beneficiary});

  PU_benListDataModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Beneficiary'] != null) {
      beneficiary = <Beneficiary>[];
      json['Beneficiary'].forEach((v) {
        beneficiary!.add(Beneficiary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (beneficiary != null) {
      data['Beneficiary'] = beneficiary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Beneficiary {
  int? id;
  String? name;
  String? bank;
  String? iFSC;
  String? account;
  String? isverify;

  Beneficiary(
      {this.id, this.name, this.bank, this.iFSC, this.account, this.isverify});

  Beneficiary.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    bank = json['Bank'];
    iFSC = json['IFSC'];
    account = json['Account'];
    isverify = json['Isverify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Bank'] = bank;
    data['IFSC'] = iFSC;
    data['Account'] = account;
    data['Isverify'] = isverify;
    return data;
  }
}