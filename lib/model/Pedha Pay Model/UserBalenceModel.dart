class getUserBalanceModel {
  String? id;
  double? walletBalance;
  double? aEPSBalance;
  double? todayEarning;
  dynamic todaySale;
  dynamic isDmtEnable;
  String? dmtMessage;

  getUserBalanceModel(
      {this.id,
        this.walletBalance,
        this.aEPSBalance,
        this.todayEarning,
        this.todaySale,
        this.isDmtEnable,
        this.dmtMessage});

  getUserBalanceModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    walletBalance = json['WalletBalance'];
    aEPSBalance = json['AEPSBalance'];
    todayEarning = json['todayEarning'];
    todaySale = json['todaySale'];
    isDmtEnable = json['IsDmtEnable'];
    dmtMessage = json['dmtMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['WalletBalance'] = walletBalance;
    data['AEPSBalance'] = aEPSBalance;
    data['todayEarning'] = todayEarning;
    data['todaySale'] = todaySale;
    data['IsDmtEnable'] = isDmtEnable;
    data['dmtMessage'] = dmtMessage;
    return data;
  }
}