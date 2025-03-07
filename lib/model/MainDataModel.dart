
class ParameterDataModel {
  String? senderMobile;
  String? custName;
  String? custOtp;
  String? beneAccount;
  String? beneIfscCode;
  String? beneBank;
  String? beneMobile;
  String? beneName;
  String? beneId;
  String? amount;
  String? transferMode;
  String? requestId;
  String? txnId;

  ParameterDataModel({
    this.senderMobile,
    this.custName,
    this.custOtp,
   this.beneAccount,
    this.beneIfscCode,
    this.beneBank,
  this.beneMobile,
    this.beneName,
    this.amount,
    this.beneId,
    this.requestId,
    this.transferMode,
    this.txnId,
  });

  ParameterDataModel.fromJson(Map<String, dynamic> json) {
    senderMobile = json['senderMobile'];
    custName = json['custName'];
    custOtp = json['custOtp'];
    beneAccount = json['beneAccount'];
    beneIfscCode =json['beneIfscCode'];
    beneBank = json['beneBank'];
    beneMobile = json['beneMobile'];
    beneName = json['beneName'];
    amount = json['amount'];
    beneId = json['beneId'];
    transferMode = json['transferMode'];
    requestId = json['requestId'];
    txnId = json['txnId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderMobile'] = senderMobile;
    data["custName"] = custName;
    data['custOtp'] = custOtp;
    data['beneAccount'] = beneAccount;
    data['beneIfscCode'] = beneIfscCode;
    data['beneBank'] = beneBank;
    data['beneMobile'] = beneMobile;
    data['beneName'] = beneName;
    data['beneId'] = beneId;
    data['amount'] = amount;
    data['transferMode'] = transferMode;
    data['requestId'] = requestId;
    data['txnId'] = txnId;
    return data;
  }
}

class AePSParameterDataModel {
  String? outletId;
  String? outlettoken;
  String? mobile;
  String? verificationToken;
  String? otp;
  String? aadhaarno;
  PidBlock? pidBlock;
  String? txnType;
  String? txnId;
  String? bankiin;
  String? amount;
  String? lat;
  String? long;
  String? terminalId;
  String? agentName;
  String? shopName;
  String? shopAddress;
  String? shopCity;
  String? shopState;
  int? shopPincode;

  AePSParameterDataModel({
    this.outletId,
    this.outlettoken,
    this.mobile,
    this.verificationToken,
    this.otp,
    this.aadhaarno,
    this.pidBlock,
    this.txnId,
    this.txnType,
    this.amount,
    this.shopName,
    this.agentName,
    this.bankiin,
    this.lat,
    this.long,
    this.shopAddress,
    this.shopCity,
    this.shopPincode,
    this.shopState,
    this.terminalId,
  });

  AePSParameterDataModel.fromJson(Map<String, dynamic> json) {
    outletId = json['outletId'];
    outlettoken = json['outlettoken'];
    mobile = json['mobile'];
    verificationToken = json['verificationToken'];
    otp = json['otp'];
    aadhaarno = json['aadhaarno'];
    amount = json['amount'];
    shopName =json[shopName];
    agentName = json[agentName];
    bankiin = json[bankiin];
    lat = json['lat'];
    long = json['long'];
    shopAddress = json[shopAddress];
    shopCity = json[shopCity];
    shopPincode = json[shopPincode];
    shopState = json[shopState];
    terminalId = json[terminalId];
    pidBlock = json['pidBlock'] != null
        ? PidBlock.fromJson(json['pidBlock'])
        : null;
    txnType = json['txnType'];
    txnId = json['txnId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['outletId'] = outletId;
    data['outlettoken'] = outlettoken;
    data['mobile'] = mobile;
    data['verificationToken'] = verificationToken;
    data['otp'] = otp;
    data['aadhaarno'] = aadhaarno;
    if (pidBlock != null) {
      data['pidBlock'] = pidBlock!.toJson();
    }
    data['txnId'] = txnId;
    data['txnType'] = txnType;
    return data;
  }
}
class PidBlock {
  String? biometricType;
  String? ci;
  String? hmac;
  String? pid;
  String? pidTs;
  String? registeredDeviceCode;
  String? registeredDeviceModelID;
  String? registeredDeviceProviderCode;
  String? registeredDevicePublicKeyCertificate;
  String? registeredDeviceServiceID;
  String? registeredDeviceServiceVersion;
  String? serviceType;
  String? skey;
  String? subType;
  String? udc;

  PidBlock(
      {this.biometricType,
        this.ci,
        this.hmac,
        this.pid,
        this.pidTs,
        this.registeredDeviceCode,
        this.registeredDeviceModelID,
        this.registeredDeviceProviderCode,
        this.registeredDevicePublicKeyCertificate,
        this.registeredDeviceServiceID,
        this.registeredDeviceServiceVersion,
        this.serviceType,
        this.skey,
        this.subType,
        this.udc,
      });

  PidBlock.fromJson(Map<String, dynamic> json) {
    biometricType = json['biometricType'];
    ci = json['ci'];
    hmac = json['hmac'];
    pid = json['pid'];
    pidTs = json['pidTs'];
    registeredDeviceCode = json['registeredDeviceCode'];
    registeredDeviceModelID = json['registeredDeviceModelID'];
    registeredDeviceProviderCode = json['registeredDeviceProviderCode'];
    registeredDevicePublicKeyCertificate =
    json['registeredDevicePublicKeyCertificate'];
    registeredDeviceServiceID = json['registeredDeviceServiceID'];
    registeredDeviceServiceVersion = json['registeredDeviceServiceVersion'];
    serviceType = json['serviceType'];
    skey = json['skey'];
    subType = json['subType'];
    udc = json['udc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['biometricType'] = biometricType;
    data['ci'] = ci;
    data['hmac'] = hmac;
    data['pid'] = pid;
    data['pidTs'] = pidTs;
    data['registeredDeviceCode'] = registeredDeviceCode;
    data['registeredDeviceModelID'] = registeredDeviceModelID;
    data['registeredDeviceProviderCode'] = registeredDeviceProviderCode;
    data['registeredDevicePublicKeyCertificate'] =
        registeredDevicePublicKeyCertificate;
    data['registeredDeviceServiceID'] = registeredDeviceServiceID;
    data['registeredDeviceServiceVersion'] =
        registeredDeviceServiceVersion;
    data['serviceType'] = serviceType;
    data['skey'] = skey;
    data['subType'] = subType;
    data['udc'] = udc;
    return data;
  }
}