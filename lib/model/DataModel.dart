

class userDataModel {
  String? method;
  String? loginId;
  String? password;
  String? latitude;
  String? longitude;

  userDataModel({this.loginId, this.password, this.latitude, this.longitude});

  userDataModel.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    password = json['password'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginId'] = loginId;
    data['password'] = password;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
