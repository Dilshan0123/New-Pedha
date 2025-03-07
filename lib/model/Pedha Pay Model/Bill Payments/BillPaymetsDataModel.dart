class subCategoryDataModel {
  int? providerId;
  String? providerName;
  String? providerAlias;
  int? serviceId;
  String? providerImage;
  String? isBBPSEnables;
  String? fieldRegex;
  String? fieldName;
  String? fieldValidation;
  String? fieldConnectionNo;
  String? fieldNumber;


  subCategoryDataModel(
      {this.providerId,
        this.providerName,
        this.providerAlias,
        this.serviceId,
        this.providerImage,
        this.isBBPSEnables,
        this.fieldRegex,
        this.fieldName,
        this.fieldValidation,
        this.fieldConnectionNo,
        this.fieldNumber});

  subCategoryDataModel.fromJson(Map<String, dynamic> json) {
    providerId = json['providerId'];
    providerName = json['providerName'];
    providerAlias = json['providerAlias'];
    serviceId = json['serviceId'];
    providerImage = json['providerImage'];
    isBBPSEnables = json['IsBBPSEnables'];
    fieldRegex = json['FieldRegex'];
    fieldName = json['FieldName'];
    fieldValidation = json['FieldValidation'];
    fieldConnectionNo = json['FieldConnectionNo'];
    fieldNumber = json['FieldNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['providerId'] = providerId;
    data['providerName'] = providerName;
    data['providerAlias'] = providerAlias;
    data['serviceId'] = serviceId;
    data['providerImage'] = providerImage;
    data['IsBBPSEnables'] = isBBPSEnables;
    data['FieldRegex'] = fieldRegex;
    data['FieldName'] = fieldName;
    data['FieldValidation'] = fieldValidation;
    data['FieldConnectionNo'] = fieldConnectionNo;
    data['FieldNumber'] = fieldNumber;
    return data;
  }
}