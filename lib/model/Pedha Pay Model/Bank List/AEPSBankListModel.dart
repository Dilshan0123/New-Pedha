class AEPSBankListDataModel {
  String? responseMessage;
  int? responseCode;
  String? requestId;
  Payload? payload;

  AEPSBankListDataModel(
      {this.responseMessage, this.responseCode, this.requestId, this.payload});

  AEPSBankListDataModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    requestId = json['requestId'];
    payload =
    json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responseMessage'] = responseMessage;
    data['responseCode'] = responseCode;
    data['requestId'] = requestId;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  List<IinList>? iinList;

  Payload({this.iinList});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['iinList'] != null) {
      iinList = <IinList>[];
      json['iinList'].forEach((v) {
        iinList!.add(IinList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iinList != null) {
      data['iinList'] = iinList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IinList {
  String? iin;
  String? name;

  IinList({this.iin, this.name});

  IinList.fromJson(Map<String, dynamic> json) {
    iin = json['iin'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iin'] = iin;
    data['name'] = name;
    return data;
  }
}