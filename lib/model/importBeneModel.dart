
class appMainDataModel {
  dynamic status;
  String? message;
  List<Data>? data;
  List<Category>? category;

  appMainDataModel({this.status, this.message, this.data, this.category});

  appMainDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
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
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? operator;
  String? providerImage;

  Category({this.operator, this.providerImage});

  Category.fromJson(Map<String, dynamic> json) {
    operator = json['operator'];
    providerImage = json['providerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['operator'] = operator;
    data['providerImage'] = providerImage;
    return data;
  }
}

class Data {
  String? bankName;
  String? accountNumber;
  String? beneName;
  String? bank;
  String? recipientMobile;
  String? recipientName;
  String? ifsc;
  String? account;
  String? rs;
  String? desc;
  String? iinno;
  String? providerAlias;
  dynamic id;
  String? operatorId;
  String? operatorName;
  String? category;
  String? viewBill;
  String? bBPSEnabled;
  String? regex;
  String? name;
  String? cn;
  String? ad1withregex;
  String? ad2;
  String? ad3;
  String? ad4;
  String? additionalParamsforpaymentAPI;
  String? ebillCode;
  String? ebillType;
  String? ebillBoard;
  String? aPIPARAMETERS;
  String? fetchBill;
  String? status;
  String? userId;
  String? senderMobile;
  String? beneId;
  String? beneMobile;
  String? beneBank;
  String? beneIfsc;
  String? beneAccount;
  String? amount;
  String? masterTxnId;
  Null clientTxnId;
  String? txnId;
  String? jvmrerenceId;
  String? api;
  String? refundOTP;
  String? paymentStatus;
  String? bankRrn;
  String? feSessionId;
  Null responseCode;
  Null apiResponse;
  String? createdDate;
  String? responseMessage;
  String? chargeAmount;
  String? transferMode;
  String? updateDate;
  String? balStatus;
  Null code;
  Null errorCode;
  String? apiCharge;
  String? source;
  dynamic commission;

  Data(
      {
        this.bankName,
        this.accountNumber,
        this.beneName,
        this.bank,
        this.recipientMobile,
        this.recipientName,
        this.ifsc,
        this.account,
        this.desc,
        this.rs,
        this.iinno,
        this.providerAlias,
        this.id,
        this.operatorId,
        this.operatorName,
        this.category,
        this.viewBill,
        this.bBPSEnabled,
        this.regex,
        this.name,
        this.cn,
        this.ad1withregex,
        this.ad2,
        this.ad3,
        this.ad4,
        this.additionalParamsforpaymentAPI,
        this.ebillCode,
        this.ebillType,
        this.ebillBoard,
        this.aPIPARAMETERS,
        this.fetchBill,
        this.userId,
        this.senderMobile,
        this.beneId,
        this.beneMobile,
        this.beneBank,
        this.beneIfsc,
        this.beneAccount,
        this.amount,
        this.masterTxnId,
        this.clientTxnId,
        this.txnId,
        this.jvmrerenceId,
        this.api,
        this.status,
        this.refundOTP,
        this.paymentStatus,
        this.bankRrn,
        this.feSessionId,
        this.responseCode,
        this.apiResponse,
        this.createdDate,
        this.responseMessage,
        this.chargeAmount,
        this.transferMode,
        this.updateDate,
        this.balStatus,
        this.code,
        this.errorCode,
        this.apiCharge,
        this.source,
        this.commission
      });

  Data.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    beneName = json['beneName'];

    bank = json['bank'];
    recipientMobile = json['recipient_mobile'];
    recipientName = json['recipient_name'];
    ifsc = json['ifsc'];
    account = json['account'];
    rs = json['rs'];
    desc = json['desc'];
    iinno = json['iinno'];
    providerAlias = json['providerAlias'];
    id = json['id'];
    operatorId = json['OperatorId'];
    operatorName = json['OperatorName'];
    category = json['Category'];
    viewBill = json['ViewBill'];
    bBPSEnabled = json['BBPSEnabled'];
    regex = json['Regex'];
    name = json['Name'];
    cn = json['cn'];
    ad1withregex = json['ad1withregex'];
    ad2 = json['ad2'];
    ad3 = json['ad3'];
    ad4 = json['ad4'];
    additionalParamsforpaymentAPI = json['AdditionalParamsforpaymentAPI'];
    ebillCode = json['ebill_code'];
    ebillType = json['ebill_type'];
    ebillBoard = json['ebill_board'];
    aPIPARAMETERS = json['API_PARAMETERS'];
    fetchBill = json['Fetch_Bill'];
    userId = json['userId'];
    senderMobile = json['senderMobile'];
    beneId = json['beneId'];
    beneMobile = json['beneMobile'];
    beneBank = json['beneBank'];
    beneIfsc = json['beneIfsc'];
    beneAccount = json['beneAccount'];
    amount = json['amount'];
    masterTxnId = json['masterTxnId'];
    clientTxnId = json['clientTxnId'];
    txnId = json['txnId'];
    jvmrerenceId = json['jvmrerenceId'];
    api = json['api'];
    status = json['status'];
    refundOTP = json['refundOTP'];
    paymentStatus = json['paymentStatus'];
    bankRrn = json['bankRrn'];
    feSessionId = json['feSessionId'];
    responseCode = json['response_code'];
    apiResponse = json['apiResponse'];
    createdDate = json['createdDate'];
    responseMessage = json['responseMessage'];
    chargeAmount = json['chargeAmount'];
    transferMode = json['transferMode'];
    updateDate = json['updateDate'];
    balStatus = json['balStatus'];
    code = json['code'];
    errorCode = json['errorCode'];
    apiCharge = json['apiCharge'];
    source = json['source'];
    commission = json['commission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['beneName'] = beneName;
    data['bank'] = bank;
    data['recipient_mobile'] = recipientMobile;
    data['recipient_name'] = recipientName;
    data['ifsc'] = ifsc;
    data['account'] = account;
    data['rs'] = rs;
    data['desc'] = desc;
    data['iinno'] = iinno;
    data['providerAlias'] = providerAlias;
    data['id'] = id;
    data['OperatorId'] = operatorId;
    data['OperatorName'] = operatorName;
    data['Category'] = category;
    data['ViewBill'] = viewBill;
    data['BBPSEnabled'] = bBPSEnabled;
    data['Regex'] = regex;
    data['Name'] = name;
    data['cn'] = cn;
    data['ad1withregex'] = ad1withregex;
    data['ad2'] = ad2;
    data['ad3'] = ad3;
    data['ad4'] = ad4;
    data['AdditionalParamsforpaymentAPI'] = additionalParamsforpaymentAPI;
    data['id'] = id;
    data['ebill_code'] = ebillCode;
    data['ebill_type'] = ebillType;
    data['ebill_board'] = ebillBoard;
    data['API_PARAMETERS'] = aPIPARAMETERS;
    data['Fetch_Bill'] = fetchBill;
    data['userId'] = userId;
    data['senderMobile'] = senderMobile;
    data['beneId'] = beneId;
    data['beneMobile'] = beneMobile;
    data['beneBank'] = beneBank;
    data['beneIfsc'] = beneIfsc;
    data['beneAccount'] = beneAccount;
    data['amount'] = amount;
    data['masterTxnId'] = masterTxnId;
    data['clientTxnId'] = clientTxnId;
    data['txnId'] = txnId;
    data['jvmrerenceId'] = jvmrerenceId;
    data['api'] = api;
    data['status'] = status;
    data['refundOTP'] = refundOTP;
    data['paymentStatus'] = paymentStatus;
    data['bankRrn'] = bankRrn;
    data['feSessionId'] = feSessionId;
    data['response_code'] = responseCode;
    data['apiResponse'] = apiResponse;
    data['createdDate'] = createdDate;
    data['responseMessage'] = responseMessage;
    data['chargeAmount'] = chargeAmount;
    data['transferMode'] = transferMode;
    data['updateDate'] = updateDate;
    data['balStatus'] = balStatus;
    data['code'] = code;
    data['errorCode'] = errorCode;
    data['apiCharge'] = apiCharge;
    data['source'] = source;
    data['commission'] = commission;
    return data;
  }


  @override
  // TODO: implement props
  List<Object?> get props => [
    bank,
    recipientMobile,
    recipientName,
    ifsc,
    account,
    rs,desc
  ];
}






