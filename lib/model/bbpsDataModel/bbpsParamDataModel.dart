class bbpsParameterModel {
  String? circle;
  String? operatorId;
  BillParams? billParams;

  bbpsParameterModel({this.circle, this.operatorId, this.billParams});

  bbpsParameterModel.fromJson(Map<String, dynamic> json) {
    circle = json['circle'];
    operatorId = json['operatorId'];
    billParams = json['billParams'] != null
        ? BillParams.fromJson(json['billParams'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['circle'] = circle;
    data['operatorId'] = operatorId;
    if (billParams != null) {
      data['billParams'] = billParams!.toJson();
    }
    return data;
  }
}

class BillParams {
  String? consumerNumber;

  BillParams({this.consumerNumber});

  BillParams.fromJson(Map<String, dynamic> json) {
    consumerNumber = json['Consumer_Number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Consumer_Number'] = consumerNumber;
    return data;
  }
}



// class bbpsParamDataModel {
//   String? method;
//   int? t;
//   String? AccountId;
//   String? id;
//   String? mobile;
//
//   bbpsParamDataModel({this.method, this.t,
//     this.id,
//     this.mobile,
//     this.AccountId
//   });
//
//   bbpsParamDataModel.fromJson(Map<String, dynamic> json) {
//     method = json['method'];
//     t = json['t'];
//     id = json["id"];
//     mobile = json["mobile"];
//     AccountId = json['AccountId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['method'] = this.method;
//     data['t'] = this.t;
//     data['id'] = this.id;
//     data['mobile'] = this.mobile;
//     data['AccountId'] = this.AccountId;
//     return data;
//   }
// }