// class loginDataModel {
//   int? id;
//   String? info;
//   String? value;
//   String? loginid;
//   String? method;
//   String? password;
//
//   loginDataModel({this.id, this.info, this.value,this.loginid, this.method, this.password});
//
//   loginDataModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     info = json['info'];
//     value = json['value'];
//     loginid = json['loginid'];
//     method = json['method'];
//     password = json['password'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['info'] = this.info;
//     data['value'] = this.value;
//     data['loginid'] = this.loginid;
//     data['method'] = this.method;
//     data['password'] = this.password;
//     return data;
//   }
//
// }