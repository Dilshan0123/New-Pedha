class UserBallenceDataModel {
  String? status;
  String? message;
  Balance? balance;
  Profiledata? profiledata;


  UserBallenceDataModel({this.status, this.message, this.balance, this.profiledata});

  UserBallenceDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    balance =
    json['balance'] != null ? Balance.fromJson(json['balance']) : null;
    profiledata = json['profiledata'] != null
        ? Profiledata.fromJson(json['profiledata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (balance != null) {
      data['balance'] = balance!.toJson();
    }
    if (profiledata != null) {
      data['profiledata'] = profiledata!.toJson();
    }
    return data;
  }
}

class Balance {
  String? walletBalance;
  String? aepsWallet;
  String? comWallet;

  Balance({this.walletBalance, this.aepsWallet, this.comWallet});

  Balance.fromJson(Map<String, dynamic> json) {
    walletBalance = json['walletBalance'];
    aepsWallet = json['aepsWallet'];
    comWallet = json['comWallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['walletBalance'] = walletBalance;
    data['aepsWallet'] = aepsWallet;
    data['comWallet'] = comWallet;
    return data;
  }
}

class Profiledata {
  String? uId;
  String? uMemberId;
  String? uFirstName;
  String? uLastName;
  String? uCompany;
  String? uEmail;
  String? uMobile;
  String? uType;
  String? uAccountDate;
  String? uPhoto;
  String? uAadhaarCard;
  String? uPanCard;
  Null beneName;
  Null accountNo;
  Null bankName;
  Null bankBranch;
  Null ifsc;
  String? city;
  String? district;
  String? state;
  String? pin;
  String? addressLine1;

  Profiledata(
      {this.uId,
        this.uMemberId,
        this.uFirstName,
        this.uLastName,
        this.uCompany,
        this.uEmail,
        this.uMobile,
        this.uType,
        this.uAccountDate,
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
        this.addressLine1});

  Profiledata.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    uMemberId = json['uMemberId'];
    uFirstName = json['uFirstName'];
    uLastName = json['uLastName'];
    uCompany = json['uCompany'];
    uEmail = json['uEmail'];
    uMobile = json['uMobile'];
    uType = json['uType'];
    uAccountDate = json['uAccountDate'];
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
    return data;
  }
}


class walletBallenceModel {
  String? status;
  String? message;
  List<WalletData>? walletdata;

  walletBallenceModel({this.status, this.message, this.walletdata});

  walletBallenceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      walletdata = <WalletData>[];
      json['data'].forEach((v) {
        walletdata!.add(WalletData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (walletdata != null) {
      data['data'] = walletdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletData {
  String? userId;
  String? txnId;
  String? walletType;
  String? txnType;
  String? serviceType;
  String? credit;
  String? debit;
  String? charge;
  String? remarks;
  String? oldBalance;
  String? newBalance;
  String? date;

  WalletData(
      {this.userId,
        this.txnId,
        this.walletType,
        this.txnType,
        this.serviceType,
        this.credit,
        this.debit,
        this.charge,
        this.remarks,
        this.oldBalance,
        this.newBalance,
        this.date});

  WalletData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    txnId = json['txnId'];
    walletType = json['walletType'];
    txnType = json['txnType'];
    serviceType = json['serviceType'];
    credit = json['credit'];
    debit = json['debit'];
    charge = json['charge'];
    remarks = json['remarks'];
    oldBalance = json['oldBalance'];
    newBalance = json['newBalance'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['txnId'] = txnId;
    data['walletType'] = walletType;
    data['txnType'] = txnType;
    data['serviceType'] = serviceType;
    data['credit'] = credit;
    data['debit'] = debit;
    data['charge'] = charge;
    data['remarks'] = remarks;
    data['oldBalance'] = oldBalance;
    data['newBalance'] = newBalance;
    data['date'] = date;
    return data;
  }
}