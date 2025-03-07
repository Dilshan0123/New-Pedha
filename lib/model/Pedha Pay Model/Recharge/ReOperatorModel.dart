class RechargeOperatorDataModel {
  int? providerId;
  String? providerName;
  String? providerAlias;
  int? serviceId;
  String? providerImage;

  RechargeOperatorDataModel(
      {this.providerId,
        this.providerName,
        this.providerAlias,
        this.serviceId,
        this.providerImage});

  RechargeOperatorDataModel.fromJson(Map<String, dynamic> json) {
    providerId = json['providerId'];
    providerName = json['providerName'];
    providerAlias = json['providerAlias'];
    serviceId = json['serviceId'];
    providerImage = json['providerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['providerId'] = providerId;
    data['providerName'] = providerName;
    data['providerAlias'] = providerAlias;
    data['serviceId'] = serviceId;
    data['providerImage'] = providerImage;
    return data;
  }
}