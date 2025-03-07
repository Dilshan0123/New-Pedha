class viewloadModel {
  String? transType;
  String? bankName;
  String? accountNo;
  String? tid;
  String? requestDate;
  String? amount;
  String? status;
  String? finalremark;
  String? approvedDate;
  String? utrNo;
  String? slip;

  viewloadModel(
      {this.transType,
        this.bankName,
        this.accountNo,
        this.tid,
        this.requestDate,
        this.amount,
        this.status,
        this.finalremark,
        this.approvedDate,
        this.utrNo,
        this.slip
      });

  viewloadModel.fromJson(Map<String, dynamic> json) {
    transType = json['transType'];
    bankName = json['bankName'];
    accountNo = json['accountNo'];
    tid = json['tid'];
    requestDate = json['requestDate'];
    amount = json['amount'];
    status = json['status'];
    finalremark = json['finalremark'];
    approvedDate = json['approvedDate'];
    utrNo = json['utrNo'];
    slip = json['slip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transType'] = transType;
    data['bankName'] = bankName;
    data['accountNo'] = accountNo;
    data['tid'] = tid;
    data['requestDate'] = requestDate;
    data['amount'] = amount;
    data['status'] = status;
    data['finalremark'] = finalremark;
    data['approvedDate'] = approvedDate;
    data['utrNo'] = utrNo;
    data['slip'] = slip;
    return data;
  }
}