class txnDataModel {
  String? status;
  String? message;
  List<txnData>? data;
  List<UserData>? user;

  txnDataModel({this.status, this.message, this.data});

  txnDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <txnData>[];
      json['data'].forEach((v) {
        data!.add(txnData.fromJson(v));
      });
    }
    if (json['data'] != null) {
      user = <UserData>[];
      json['data'].forEach((v) {
        user!.add(UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class txnData {
  String? id;
  String? userId;
  String? category;
  String? mobile;
  String? amount;
  dynamic txnId;
  String? bbpsRef;
  String? date;
  String? message;
  String? status;
  String? operatorName;
  String? beneMobile;
  String? senderMobile;
  String? beneAccount;
  String? maskAadhar;
  String? txnType;
  String? rrn;
  String? bankRrn;
  String? mode;
  String? bank;
  String? receipt;
  String? requestDate;

  txnData(
      {this.id,
        this.userId,
        this.category,
        this.mobile,
        this.amount,
        this.txnId,
        this.bbpsRef,
        this.date,
        this.message,
        this.status,
        this.operatorName,
        this.beneMobile,
        this.senderMobile,
        this.beneAccount,
        this.maskAadhar,
        this.txnType,
        this.rrn,
        this.bankRrn,
        this.mode,
        this.bank,
        this.receipt,
        this.requestDate,
      });

  txnData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    category = json['category'];
    mobile = json['mobile'];
    amount = json['amount'];
    txnId = json['txnId'];
    bbpsRef = json['bbpsRef'];
    date = json['date'];
    message = json['message'];
    status = json['status'];
    operatorName = json['operatorName'];
    beneMobile = json['beneMobile'];
    senderMobile = json['senderMobile'];
    beneAccount = json['beneAccount'];
    maskAadhar = json['maskAadhar'];
    txnType = json['txnType'];
    rrn = json['rrn'];
    bankRrn = json['bankRrn'];
    id = json['id'];
    userId = json['userId'];
    mode = json['mode'];
    bank = json['bank'];
    receipt = json['receipt'];
    requestDate = json['requestDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['category'] = category;
    data['mobile'] = mobile;
    data['amount'] = amount;
    data['txnId'] = txnId;
    data['bbpsRef'] = bbpsRef;
    data['date'] = date;
    data['message'] = message;
    data['status'] = status;
    data['operatorName'] = operatorName;
    data['beneMobile'] = beneMobile;
    data['senderMobile'] = senderMobile;
    data['beneAccount'] = beneAccount;
    data['maskAadhar'] = maskAadhar;
    data['txnType'] = txnType;
    data['rrn'] = rrn;
    data['bankRrn'] = bankRrn;
    data['mode'] = mode;
    data['bank'] = bank;
    data['receipt'] = receipt;
    data['requestDate'] = requestDate;
     return data;
  }
}

class UserData {
  String? uMemberId;
  String? uId;
  String? uFirstName;
  String? uLastName;
  String? uCompany;
  String? uType;
  String? kycStatus;
  String? uStatus;
  String? uAccountDate;
  String? roleTitle;
  String? statename;
  String? districtname;

  UserData(
      {this.uMemberId,
        this.uId,
        this.uFirstName,
        this.uLastName,
        this.uCompany,
        this.uType,
        this.kycStatus,
        this.uStatus,
        this.uAccountDate,
        this.roleTitle,
        this.statename,
        this.districtname});

  UserData.fromJson(Map<String, dynamic> json) {
    uMemberId = json['uMemberId'];
    uId = json['uId'];
    uFirstName = json['uFirstName'];
    uLastName = json['uLastName'];
    uCompany = json['uCompany'];
    uType = json['uType'];
    kycStatus = json['kycStatus'];
    uStatus = json['uStatus'];
    uAccountDate = json['uAccountDate'];
    roleTitle = json['roleTitle'];
    statename = json['statename'];
    districtname = json['districtname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uMemberId'] = uMemberId;
    data['uId'] = uId;
    data['uFirstName'] = uFirstName;
    data['uLastName'] = uLastName;
    data['uCompany'] = uCompany;
    data['uType'] = uType;
    data['kycStatus'] = kycStatus;
    data['uStatus'] = uStatus;
    data['uAccountDate'] = uAccountDate;
    data['roleTitle'] = roleTitle;
    data['statename'] = statename;
    data['districtname'] = districtname;
    return data;
  }
}