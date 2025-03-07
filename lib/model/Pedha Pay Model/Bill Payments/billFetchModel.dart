class billFetchDataModel {
  bool? success;
  List<Data>? data;
  Null message;

  billFetchDataModel({this.success, this.data, this.message});

  billFetchDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? billAmount;
  String? billnetamount;
  String? billdate;
  String? dueDate;
  bool? acceptPayment;
  bool? acceptPartPay;
  String? cellNumber;
  String? userName;

  Data(
      {this.billAmount,
        this.billnetamount,
        this.billdate,
        this.dueDate,
        this.acceptPayment,
        this.acceptPartPay,
        this.cellNumber,
        this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    billAmount = json['billAmount'];
    billnetamount = json['billnetamount'];
    billdate = json['billdate'];
    dueDate = json['dueDate'];
    acceptPayment = json['acceptPayment'];
    acceptPartPay = json['acceptPartPay'];
    cellNumber = json['cellNumber'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billAmount'] = billAmount;
    data['billnetamount'] = billnetamount;
    data['billdate'] = billdate;
    data['dueDate'] = dueDate;
    data['acceptPayment'] = acceptPayment;
    data['acceptPartPay'] = acceptPartPay;
    data['cellNumber'] = cellNumber;
    data['userName'] = userName;
    return data;
  }
}