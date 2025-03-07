class servicesTxnDataModel {
  String? image;
  String? provider;
  String? service;
  String? mobile;
  String? amount;
  String? status;
  String? transactionID;
  String? date;
  String? description;
  String? afterBalance;
  String? transactionType;
  String? dmtInPutComm;
  String? dmtOutputCom;
  String? remitter;
  String? tid;
  String? isTicketProcess;
  dynamic plid;
  dynamic beneName;

  servicesTxnDataModel({this.image,
    this.provider,
    this.service,
    this.mobile,
    this.amount,
    this.status,
    this.transactionID,
    this.date,
    this.description,
    this.afterBalance,
    this.transactionType,
    this.dmtInPutComm,
    this.dmtOutputCom,
    this.remitter,
    this.tid,
    this.isTicketProcess,
    this.plid,
    this.beneName});

  servicesTxnDataModel.fromJson(Map<String, dynamic> json) {
    image = json['Image'];
    provider = json['Provider'];
    service = json['Service'];
    mobile = json['Mobile'];
    amount = json['Amount'];
    status = json['Status'];
    transactionID = json['TransactionID'];
    date = json['Date'];
    description = json['Description'];
    afterBalance = json['AfterBalance'];
    transactionType = json['TransactionType'];
    dmtInPutComm = json['DmtInPutComm'];
    dmtOutputCom = json['DmtOutputCom'];
    remitter = json['Remitter'];
    tid = json['Tid'];
    isTicketProcess = json['IsTicketProcess'];
    plid = json['plid'];
    beneName = json['BeneName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Image'] = image;
    data['Provider'] = provider;
    data['Service'] = service;
    data['Mobile'] = mobile;
    data['Amount'] = amount;
    data['Status'] = status;
    data['TransactionID'] = transactionID;
    data['Date'] = date;
    data['Description'] = description;
    data['AfterBalance'] = afterBalance;
    data['TransactionType'] = transactionType;
    data['DmtInPutComm'] = dmtInPutComm;
    data['DmtOutputCom'] = dmtOutputCom;
    data['Remitter'] = remitter;
    data['Tid'] = tid;
    data['IsTicketProcess'] = isTicketProcess;
    data['plid'] = plid;
    data['BeneName'] = beneName;
    return data;
  }
}