class AEPS_BE_Model {
  bool? status;
  String? message;
  Data? data;
  double? statusCode;

  AEPS_BE_Model({this.status, this.message, this.data, this.statusCode});

  AEPS_BE_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    return data;
  }
}

class Data {
  String? terminalId;
  String? requestTransactionTime;
  int? transactionAmount;
  String? transactionStatus;
  double? balanceAmount;
  Null strMiniStatementBalance;
  String? bankRRN;
  String? transactionType;
  String? fpTransactionId;
  Null merchantTxnId;
  Null errorCode;
  Null errorMessage;
  Null merchantTransactionId;
  Null bankAccountNumber;
  Null ifscCode;
  Null bcName;
  Null transactionTime;
  int? agentId;
  Null issuerBank;
  Null customerAadhaarNumber;
  Null customerName;
  Null stan;
  Null rrn;
  Null uidaiAuthCode;
  Null bcLocation;
  Null demandSheetId;
  Null mobileNumber;
  Null urnId;
  Null miniStatementStructureModel;
  Null miniOffusStatementStructureModel;
  bool? miniOffusFlag;
  Null transactionRemark;
  Null bankName;
  Null prospectNumber;
  Null internalReferenceNumber;
  Null biTxnType;
  Null subVillageName;
  Null virtualId;
  Null userProfileResponseModel;
  Null hindiErrorMessage;
  Null loanAccNo;
  String? responseCode;
  Null fpkAgentId;
  Null additionalData;

  Data(
      {this.terminalId,
        this.requestTransactionTime,
        this.transactionAmount,
        this.transactionStatus,
        this.balanceAmount,
        this.strMiniStatementBalance,
        this.bankRRN,
        this.transactionType,
        this.fpTransactionId,
        this.merchantTxnId,
        this.errorCode,
        this.errorMessage,
        this.merchantTransactionId,
        this.bankAccountNumber,
        this.ifscCode,
        this.bcName,
        this.transactionTime,
        this.agentId,
        this.issuerBank,
        this.customerAadhaarNumber,
        this.customerName,
        this.stan,
        this.rrn,
        this.uidaiAuthCode,
        this.bcLocation,
        this.demandSheetId,
        this.mobileNumber,
        this.urnId,
        this.miniStatementStructureModel,
        this.miniOffusStatementStructureModel,
        this.miniOffusFlag,
        this.transactionRemark,
        this.bankName,
        this.prospectNumber,
        this.internalReferenceNumber,
        this.biTxnType,
        this.subVillageName,
        this.virtualId,
        this.userProfileResponseModel,
        this.hindiErrorMessage,
        this.loanAccNo,
        this.responseCode,
        this.fpkAgentId,
        this.additionalData});

  Data.fromJson(Map<String, dynamic> json) {
    terminalId = json['terminalId'];
    requestTransactionTime = json['requestTransactionTime'];
    transactionAmount = json['transactionAmount'];
    transactionStatus = json['transactionStatus'];
    balanceAmount = json['balanceAmount'];
    strMiniStatementBalance = json['strMiniStatementBalance'];
    bankRRN = json['bankRRN'];
    transactionType = json['transactionType'];
    fpTransactionId = json['fpTransactionId'];
    merchantTxnId = json['merchantTxnId'];
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    merchantTransactionId = json['merchantTransactionId'];
    bankAccountNumber = json['bankAccountNumber'];
    ifscCode = json['ifscCode'];
    bcName = json['bcName'];
    transactionTime = json['transactionTime'];
    agentId = json['agentId'];
    issuerBank = json['issuerBank'];
    customerAadhaarNumber = json['customerAadhaarNumber'];
    customerName = json['customerName'];
    stan = json['stan'];
    rrn = json['rrn'];
    uidaiAuthCode = json['uidaiAuthCode'];
    bcLocation = json['bcLocation'];
    demandSheetId = json['demandSheetId'];
    mobileNumber = json['mobileNumber'];
    urnId = json['urnId'];
    miniStatementStructureModel = json['miniStatementStructureModel'];
    miniOffusStatementStructureModel = json['miniOffusStatementStructureModel'];
    miniOffusFlag = json['miniOffusFlag'];
    transactionRemark = json['transactionRemark'];
    bankName = json['bankName'];
    prospectNumber = json['prospectNumber'];
    internalReferenceNumber = json['internalReferenceNumber'];
    biTxnType = json['biTxnType'];
    subVillageName = json['subVillageName'];
    virtualId = json['virtualId'];
    userProfileResponseModel = json['userProfileResponseModel'];
    hindiErrorMessage = json['hindiErrorMessage'];
    loanAccNo = json['loanAccNo'];
    responseCode = json['responseCode'];
    fpkAgentId = json['fpkAgentId'];
    additionalData = json['additionalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['terminalId'] = terminalId;
    data['requestTransactionTime'] = requestTransactionTime;
    data['transactionAmount'] = transactionAmount;
    data['transactionStatus'] = transactionStatus;
    data['balanceAmount'] = balanceAmount;
    data['strMiniStatementBalance'] = strMiniStatementBalance;
    data['bankRRN'] = bankRRN;
    data['transactionType'] = transactionType;
    data['fpTransactionId'] = fpTransactionId;
    data['merchantTxnId'] = merchantTxnId;
    data['errorCode'] = errorCode;
    data['errorMessage'] = errorMessage;
    data['merchantTransactionId'] = merchantTransactionId;
    data['bankAccountNumber'] = bankAccountNumber;
    data['ifscCode'] = ifscCode;
    data['bcName'] = bcName;
    data['transactionTime'] = transactionTime;
    data['agentId'] = agentId;
    data['issuerBank'] = issuerBank;
    data['customerAadhaarNumber'] = customerAadhaarNumber;
    data['customerName'] = customerName;
    data['stan'] = stan;
    data['rrn'] = rrn;
    data['uidaiAuthCode'] = uidaiAuthCode;
    data['bcLocation'] = bcLocation;
    data['demandSheetId'] = demandSheetId;
    data['mobileNumber'] = mobileNumber;
    data['urnId'] = urnId;
    data['miniStatementStructureModel'] = miniStatementStructureModel;
    data['miniOffusStatementStructureModel'] =
        miniOffusStatementStructureModel;
    data['miniOffusFlag'] = miniOffusFlag;
    data['transactionRemark'] = transactionRemark;
    data['bankName'] = bankName;
    data['prospectNumber'] = prospectNumber;
    data['internalReferenceNumber'] = internalReferenceNumber;
    data['biTxnType'] = biTxnType;
    data['subVillageName'] = subVillageName;
    data['virtualId'] = virtualId;
    data['userProfileResponseModel'] = userProfileResponseModel;
    data['hindiErrorMessage'] = hindiErrorMessage;
    data['loanAccNo'] = loanAccNo;
    data['responseCode'] = responseCode;
    data['fpkAgentId'] = fpkAgentId;
    data['additionalData'] = additionalData;
    return data;
  }
}