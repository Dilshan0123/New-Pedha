class providerDataModel {
  String? operatorCode;
  String? operatorName;
  String? service;
  String? operatorId;

  providerDataModel(
      {this.operatorCode, this.operatorName, this.service, this.operatorId});

  providerDataModel.fromJson(Map<String, dynamic> json) {
    operatorCode = json['operatorCode'];
    operatorName = json['operatorName'];
    service = json['service'];
    operatorId = json['operatorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['operatorCode'] = operatorCode;
    data['operatorName'] = operatorName;
    data['service'] = service;
    data['operatorId'] = operatorId;
    return data;
  }

  static List<providerDataModel> parseList(dynamic json) {
    if (json.toString().isNotEmpty) {
      return json
          .map<providerDataModel>(
              (tagJson) => providerDataModel.fromJson(tagJson))
          .toList();
    } else {
      return <providerDataModel>[];
    }
  }
}

// class providerDataModel {
//   String? status;
//   String? message;
//   List<ProviderData>? data;
//
//   providerDataModel({this.status, this.message, this.data});
//
//   providerDataModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <ProviderData>[];
//       json['data'].forEach((v) {
//         data!.add(new ProviderData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
//
//   static List<providerDataModel> parseList(dynamic json) {
//     if (json.toString().isNotEmpty) {
//       return json
//           .map<providerDataModel>(
//               (tagJson) => providerDataModel.fromJson(tagJson))
//           .toList();
//     } else {
//       return <providerDataModel>[];
//     }
//   }
// }
//
// class ProviderData {
//   String? opCode;
//   String? opName;
//   String? serviceId;
//
//   ProviderData({this.opCode, this.opName, this.serviceId});
//
//   ProviderData.fromJson(Map<String, dynamic> json) {
//     opCode = json['opCode'];
//     opName = json['opName'];
//     serviceId = json['serviceId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['opCode'] = this.opCode;
//     data['opName'] = this.opName;
//     data['serviceId'] = this.serviceId;
//     return data;
//   }
// }