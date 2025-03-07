class DMTBankListModel {
  String? statuscode;
  Null actcode;
  String? status;
  List<Data>? data;
  String? timestamp;
  String? ipayUuid;
  Null orderid;
  String? environment;

  DMTBankListModel(
      {this.statuscode,
        this.actcode,
        this.status,
        this.data,
        this.timestamp,
        this.ipayUuid,
        this.orderid,
        this.environment});

  DMTBankListModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    actcode = json['actcode'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
    ipayUuid = json['ipay_uuid'];
    orderid = json['orderid'];
    environment = json['environment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statuscode'] = statuscode;
    data['actcode'] = actcode;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = timestamp;
    data['ipay_uuid'] = ipayUuid;
    data['orderid'] = orderid;
    data['environment'] = environment;
    return data;
  }
}

class Data {
  int? bankId;
  String? name;
  String? ifscAlias;
  String? ifscGlobal;
  int? neftEnabled;
  String? neftFailureRate;
  int? impsEnabled;
  String? impsFailureRate;
  int? upiEnabled;
  String? upiFailureRate;

  Data(
      {this.bankId,
        this.name,
        this.ifscAlias,
        this.ifscGlobal,
        this.neftEnabled,
        this.neftFailureRate,
        this.impsEnabled,
        this.impsFailureRate,
        this.upiEnabled,
        this.upiFailureRate});

  Data.fromJson(Map<String, dynamic> json) {
    bankId = json['bankId'];
    name = json['name'];
    ifscAlias = json['ifscAlias'];
    ifscGlobal = json['ifscGlobal'];
    neftEnabled = json['neftEnabled'];
    neftFailureRate = json['neftFailureRate'];
    impsEnabled = json['impsEnabled'];
    impsFailureRate = json['impsFailureRate'];
    upiEnabled = json['upiEnabled'];
    upiFailureRate = json['upiFailureRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bankId'] = bankId;
    data['name'] = name;
    data['ifscAlias'] = ifscAlias;
    data['ifscGlobal'] = ifscGlobal;
    data['neftEnabled'] = neftEnabled;
    data['neftFailureRate'] = neftFailureRate;
    data['impsEnabled'] = impsEnabled;
    data['impsFailureRate'] = impsFailureRate;
    data['upiEnabled'] = upiEnabled;
    data['upiFailureRate'] = upiFailureRate;
    return data;
  }
}