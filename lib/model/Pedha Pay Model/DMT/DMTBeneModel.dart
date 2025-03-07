class DMTBeneDataModel {
  String? statuscode;
  Null actcode;
  String? status;
  Data? data;
  String? timestamp;
  String? ipayUuid;
  Null orderid;
  String? environment;
  Null internalCode;

  DMTBeneDataModel(
      {this.statuscode,
        this.actcode,
        this.status,
        this.data,
        this.timestamp,
        this.ipayUuid,
        this.orderid,
        this.environment,
        this.internalCode});

  DMTBeneDataModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    actcode = json['actcode'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
    ipayUuid = json['ipay_uuid'];
    orderid = json['orderid'];
    environment = json['environment'];
    internalCode = json['internalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statuscode'] = statuscode;
    data['actcode'] = actcode;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = timestamp;
    data['ipay_uuid'] = ipayUuid;
    data['orderid'] = orderid;
    data['environment'] = environment;
    data['internalCode'] = internalCode;
    return data;
  }
}

class Data {
  String? mobileNumber;
  String? firstName;
  String? lastName;
  String? city;
  String? pincode;
  int? limitPerTransaction;
  String? limitTotal;
  String? limitConsumed;
  String? limitAvailable;
  LimitDetails? limitDetails;
  List<Beneficiaries>? beneficiaries;
  bool? isTxnOtpRequired;
  bool? isTxnBioAuthRequired;
  String? validity;
  String? referenceKey;

  Data(
      {this.mobileNumber,
        this.firstName,
        this.lastName,
        this.city,
        this.pincode,
        this.limitPerTransaction,
        this.limitTotal,
        this.limitConsumed,
        this.limitAvailable,
        this.limitDetails,
        this.beneficiaries,
        this.isTxnOtpRequired,
        this.isTxnBioAuthRequired,
        this.validity,
        this.referenceKey});

  Data.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    city = json['city'];
    pincode = json['pincode'];
    limitPerTransaction = json['limitPerTransaction'];
    limitTotal = json['limitTotal'];
    limitConsumed = json['limitConsumed'];
    limitAvailable = json['limitAvailable'];
    limitDetails = json['limitDetails'] != null
        ? LimitDetails.fromJson(json['limitDetails'])
        : null;
    if (json['beneficiaries'] != null) {
      beneficiaries = <Beneficiaries>[];
      json['beneficiaries'].forEach((v) {
        beneficiaries!.add(Beneficiaries.fromJson(v));
      });
    }
    isTxnOtpRequired = json['isTxnOtpRequired'];
    isTxnBioAuthRequired = json['isTxnBioAuthRequired'];
    validity = json['validity'];
    referenceKey = json['referenceKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNumber'] = mobileNumber;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['city'] = city;
    data['pincode'] = pincode;
    data['limitPerTransaction'] = limitPerTransaction;
    data['limitTotal'] = limitTotal;
    data['limitConsumed'] = limitConsumed;
    data['limitAvailable'] = limitAvailable;
    if (limitDetails != null) {
      data['limitDetails'] = limitDetails!.toJson();
    }
    if (beneficiaries != null) {
      data['beneficiaries'] =
          beneficiaries!.map((v) => v.toJson()).toList();
    }
    data['isTxnOtpRequired'] = isTxnOtpRequired;
    data['isTxnBioAuthRequired'] = isTxnBioAuthRequired;
    data['validity'] = validity;
    data['referenceKey'] = referenceKey;
    return data;
  }
}

class LimitDetails {
  String? maximumDailyLimit;
  String? consumedDailyLimit;
  String? availableDailyLimit;
  String? maximumMonthlyLimit;
  String? consumedMonthlyLimit;
  String? availableMonthlyLimit;

  LimitDetails(
      {this.maximumDailyLimit,
        this.consumedDailyLimit,
        this.availableDailyLimit,
        this.maximumMonthlyLimit,
        this.consumedMonthlyLimit,
        this.availableMonthlyLimit});

  LimitDetails.fromJson(Map<String, dynamic> json) {
    maximumDailyLimit = json['maximumDailyLimit'];
    consumedDailyLimit = json['consumedDailyLimit'];
    availableDailyLimit = json['availableDailyLimit'];
    maximumMonthlyLimit = json['maximumMonthlyLimit'];
    consumedMonthlyLimit = json['consumedMonthlyLimit'];
    availableMonthlyLimit = json['availableMonthlyLimit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maximumDailyLimit'] = maximumDailyLimit;
    data['consumedDailyLimit'] = consumedDailyLimit;
    data['availableDailyLimit'] = availableDailyLimit;
    data['maximumMonthlyLimit'] = maximumMonthlyLimit;
    data['consumedMonthlyLimit'] = consumedMonthlyLimit;
    data['availableMonthlyLimit'] = availableMonthlyLimit;
    return data;
  }
}

class Beneficiaries {
  String? id;
  String? name;
  String? account;
  String? ifsc;
  String? bank;
  String? beneficiaryMobileNumber;
  String? verificationDt;

  Beneficiaries(
      {this.id,
        this.name,
        this.account,
        this.ifsc,
        this.bank,
        this.beneficiaryMobileNumber,
        this.verificationDt});

  Beneficiaries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    account = json['account'];
    ifsc = json['ifsc'];
    bank = json['bank'];
    beneficiaryMobileNumber = json['beneficiaryMobileNumber'];
    verificationDt = json['verificationDt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['account'] = account;
    data['ifsc'] = ifsc;
    data['bank'] = bank;
    data['beneficiaryMobileNumber'] = beneficiaryMobileNumber;
    data['verificationDt'] = verificationDt;
    return data;
  }
}