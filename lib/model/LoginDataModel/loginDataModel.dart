class loginDataModel {
  String? status;
  String? message;
  Userdata? userdata;


  loginDataModel({this.status, this.message, this.userdata});

  loginDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userdata = json['userdata'] != null
        ? Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (userdata != null) {
      data['userdata'] = userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? uId;
  String? uMemberId;
  String? uFirstName;
  String? uLastName;
  String? uCompany;
  String? uEmail;
  String? uMobile;
  String? uType;
  String? uAccountDate;
  String? passwordToken;
  String? txntoken;
  String? token;
  String? uPhoto;
  String? uAadhaarCard;
  String? uPanCard;
  String? beneName;
  String? accountNo;
  String? bankName;
  String? bankBranch;
  String? ifsc;
  String? city;
  String? district;
  String? state;
  String? pin;
  String? addressLine1;
  String? kycStatus;
  String? aepsEkycStatus;
  String? mercOnboardStatus;
  String? twofactorDate;
  String? rechargeStatus;
  String? bbpsStatus;
  String? aepsStatus;
  String? dmtStatus;
  String? ymPayout;

  Userdata(
      {this.uId,
        this.uMemberId,
        this.uFirstName,
        this.uLastName,
        this.uCompany,
        this.uEmail,
        this.uMobile,
        this.uType,
        this.uAccountDate,
        this.passwordToken,
        this.txntoken,
        this.token,
        this.uPhoto,
        this.uAadhaarCard,
        this.uPanCard,
        this.beneName,
        this.accountNo,
        this.bankName,
        this.bankBranch,
        this.ifsc,
        this.city,
        this.district,
        this.state,
        this.pin,
        this.addressLine1,
        this.kycStatus,
        this.aepsEkycStatus,
        this.mercOnboardStatus,
        this.twofactorDate,
        this.rechargeStatus,
        this.bbpsStatus,
        this.aepsStatus,
        this.dmtStatus,
        this.ymPayout
      });

  Userdata.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    uMemberId = json['uMemberId'];
    uFirstName = json['uFirstName'];
    uLastName = json['uLastName'];
    uCompany = json['uCompany'];
    uEmail = json['uEmail'];
    uMobile = json['uMobile'];
    uType = json['uType'];
    uAccountDate = json['uAccountDate'];
    passwordToken = json['passwordToken'];
    txntoken = json['txntoken'];
    token = json['token'];
    uPhoto = json['uPhoto'];
    uAadhaarCard = json['uAadhaarCard'];
    uPanCard = json['uPanCard'];
    beneName = json['beneName'];
    accountNo = json['accountNo'];
    bankName = json['bankName'];
    bankBranch = json['bankBranch'];
    ifsc = json['ifsc'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    pin = json['pin'];
    addressLine1 = json['addressLine1'];
    kycStatus = json['kycStatus'];
    aepsEkycStatus = json['aepsEkycStatus'];
    mercOnboardStatus = json['mercOnboardStatus'];
    twofactorDate = json['twofactorDate'];
    rechargeStatus = json['rechargeStatus'];
    bbpsStatus = json['bbpsStatus'];
    aepsStatus = json['aepsStatus'];
    dmtStatus = json['dmtStatus'];
    ymPayout = json['ymPayout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uId'] = uId;
    data['uMemberId'] = uMemberId;
    data['uFirstName'] = uFirstName;
    data['uLastName'] = uLastName;
    data['uCompany'] = uCompany;
    data['uEmail'] = uEmail;
    data['uMobile'] = uMobile;
    data['uType'] = uType;
    data['uAccountDate'] = uAccountDate;
    data['passwordToken'] = passwordToken;
    data['txntoken'] = txntoken;
    data['token'] = token;
    data['uPhoto'] = uPhoto;
    data['uAadhaarCard'] = uAadhaarCard;
    data['uPanCard'] = uPanCard;
    data['beneName'] = beneName;
    data['accountNo'] = accountNo;
    data['bankName'] = bankName;
    data['bankBranch'] = bankBranch;
    data['ifsc'] = ifsc;
    data['city'] = city;
    data['district'] = district;
    data['state'] = state;
    data['pin'] = pin;
    data['addressLine1'] = addressLine1;
    data['kycStatus'] = kycStatus;
    data['aepsEkycStatus'] = aepsEkycStatus;
    data['mercOnboardStatus'] = mercOnboardStatus;
    data['twofactorDate'] = twofactorDate;
    data['rechargeStatus'] = rechargeStatus;
    data['bbpsStatus'] = bbpsStatus;
    data['aepsStatus'] = aepsStatus;
    data['dmtStatus'] = dmtStatus;
    data['ymPayout'] = ymPayout;
    return data;
  }
}