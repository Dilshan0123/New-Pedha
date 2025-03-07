class getPlanDataModel {
  String? tel;
  Null nOperator;
  List<Records>? records;
  int? status;
  double? time;

  getPlanDataModel(
      {this.tel, this.nOperator, this.records, this.status, this.time});

  getPlanDataModel.fromJson(Map<String, dynamic> json) {
    tel = json['tel'];
    nOperator = json['_operator'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
    status = json['status'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tel'] = tel;
    data['_operator'] = nOperator;
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['time'] = time;
    return data;
  }
}

class Records {
  String? rs;
  String? desc;

  Records({this.rs, this.desc});

  Records.fromJson(Map<String, dynamic> json) {
    rs = json['rs'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rs'] = rs;
    data['desc'] = desc;
    return data;
  }
}