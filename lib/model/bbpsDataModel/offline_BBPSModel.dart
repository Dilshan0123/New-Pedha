class offBBPSModel {
  int? status;
  String? operator;
  String? mobile;
  List<Rdata>? rdata;

  offBBPSModel({this.status, this.operator, this.mobile, this.rdata});

  offBBPSModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    operator = json['operator'];
    mobile = json['mobile'];
    if (json['rdata'] != null) {
      rdata = <Rdata>[];
      json['rdata'].forEach((v) {
        rdata!.add(Rdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['operator'] = operator;
    data['mobile'] = mobile;
    if (rdata != null) {
      data['rdata'] = rdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rdata {
  String? customerName;
  String? billamount;
  String? billdate;
  String? duedate;
  int? status;

  Rdata(
      {this.customerName,
        this.billamount,
        this.billdate,
        this.duedate,
        this.status});

  Rdata.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    billamount = json['Billamount'];
    billdate = json['Billdate'];
    duedate = json['Duedate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerName'] = customerName;
    data['Billamount'] = billamount;
    data['Billdate'] = billdate;
    data['Duedate'] = duedate;
    data['status'] = status;
    return data;
  }
}