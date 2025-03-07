import 'dart:convert';

class P_loginDataModel {
  bool? status;
  String? statuscode;
  String? message;
  String? id;
  String? pkid;
  String? referId;
  String? mobile;
  String? email;
  String? shopName;
  String? isUserActive;
  double? walletBalance;
  double? aepsBalance;
  String? userType;
  String? distributorID;
  String? distributorName;
  String? company;
  String? isPassChange;
  String? ticker;
  String? isDmtActive;
  String? dmtMessage;
  String? isAepsActive;
  String? aepsMessage;
  String? upiId;
  String? image1;
  String? image2;
  String? isTpinRequired;
  String? isBenepopupRequired;
  String? userTypeId;
  String? kycStatus;
  String? panNumber;
  String? adhaarNumber;
  String? isAepsEkycDone;
  String? latitude;
  String? longitude;
  String? isFngTwoFactActive;

  P_loginDataModel(
      {this.status,
        this.statuscode,
        this.message,
        this.id,
        this.pkid,
        this.referId,
        this.mobile,
        this.email,
        this.shopName,
        this.isUserActive,
        this.walletBalance,
        this.aepsBalance,
        this.userType,
        this.distributorID,
        this.distributorName,
        this.company,
        this.isPassChange,
        this.ticker,
        this.isDmtActive,
        this.dmtMessage,
        this.isAepsActive,
        this.aepsMessage,
        this.upiId,
        this.image1,
        this.image2,
        this.isTpinRequired,
        this.isBenepopupRequired,
        this.userTypeId,
        this.kycStatus,
        this.panNumber,
        this.adhaarNumber,
        this.isAepsEkycDone,
        this.latitude,
        this.longitude,
        this.isFngTwoFactActive});

 factory P_loginDataModel.fromJson(Map<String, dynamic> json) {
   return P_loginDataModel(
       status: json['status'],
       statuscode: json['statuscode'],
       message: json['message'],
       id: json['Id'],
       pkid: json['Pkid'],
       referId: json['ReferId'],
       mobile: json['Mobile'],
       email: json['Email'],
       shopName: json['ShopName'],
       isUserActive: json['IsUserActive'],
       walletBalance: json['walletBalance'],
       aepsBalance: json['AepsBalance'],
       userType: json['UserType'],
       distributorID: json['DistributorID'],
       distributorName: json['DistributorName'],
       company: json['Company'],
       isPassChange: json['IsPassChange'],
       ticker: json['Ticker'],
       isDmtActive: json['IsDmtActive'],
       dmtMessage: json['DmtMessage'],
       isAepsActive: json['IsAepsActive'],
       aepsMessage: json['AepsMessage'],
       upiId: json['UpiId'],
       image1: json['Image1'],
       image2: json['Image2'],
       isTpinRequired: json['IsTpinRequired'],
       isBenepopupRequired: json['IsBenepopupRequired'],
       userTypeId: json['UserTypeId'],
       kycStatus: json['kycStatus'],
       panNumber: json['panNumber'],
       adhaarNumber: json['adhaarNumber'],
       isAepsEkycDone: json['isAepsEkycDone'],
       latitude: json['latitude'],
       longitude: json['longitude'],
       isFngTwoFactActive: json['isFngTwoFactActive'],
   );
  }

  Map<String, dynamic> toJson() {
   return{
     'Status': status,
     'Statuscode': statuscode,
     'Message': message,
     'Id': id,
     'Pkid': pkid,
     'ReferId': referId,
     'Mobile': mobile,
     'Email': email,
     'ShopName': shopName,
     'IsUserActive': isUserActive,
     'walletBalance': walletBalance,
     'AepsBalance': aepsBalance,
     'UserType': userType,
     'DistributorID': distributorID,
     'Company': company,
     'IsPassChange': isPassChange,
     'Ticker': ticker,
     'IsDmtActive': isDmtActive,
     'DmtMessage': dmtMessage,
     'IsAepsActive': isAepsActive,
     'AepsMessage': aepsMessage,
     'UpiId': upiId,
     'Image1': image1,
     'Image2': image2,
     'IsTpinRequired': isTpinRequired,
     'IsBenepopupRequired': isBenepopupRequired,
     'UserTypeId': userTypeId,
     'kycStatus': kycStatus,
     'panNumber': panNumber,
     'adhaarNumber': adhaarNumber,
     'isAepsEkycDone': isAepsEkycDone,
     'latitude': latitude,
     'longitude': longitude,
     'isFngTwoFactActive': isFngTwoFactActive,
   };
  }
  String toJsonString() => jsonEncode(toJson());

  // Create a LoginDataModel instance from a JSON string
  factory P_loginDataModel.fromJsonString(String jsonString) =>
      P_loginDataModel.fromJson(jsonDecode(jsonString));
}