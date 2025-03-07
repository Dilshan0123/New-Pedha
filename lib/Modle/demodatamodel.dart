/// name : "Centro Universitário de Brasília, UNICEUB"
/// web_pages : ["https://www.uniceub.br"]
/// domains : ["sempreceub.com","uniceub.br"]
/// alpha_two_code : "BR"
/// country : "Brazil"
/// state-province : null
library;

class Demodatamodel {
  Demodatamodel({
      String? name, 
      List<String>? webPages, 
      List<String>? domains, 
      String? alphaTwoCode, 
      String? country, 
      dynamic stateprovince,}){
    _name = name;
    _webPages = webPages;
    _domains = domains;
    _alphaTwoCode = alphaTwoCode;
    _country = country;
    _stateprovince = stateprovince;
}

  Demodatamodel.fromJson(dynamic json) {
    _name = json['name'];
    _webPages = json['web_pages'] != null ? json['web_pages'].cast<String>() : [];
    _domains = json['domains'] != null ? json['domains'].cast<String>() : [];
    _alphaTwoCode = json['alpha_two_code'];
    _country = json['country'];
    _stateprovince = json['state-province'];
  }
  String? _name;
  List<String>? _webPages;
  List<String>? _domains;
  String? _alphaTwoCode;
  String? _country;
  dynamic _stateprovince;
Demodatamodel copyWith({  String? name,
  List<String>? webPages,
  List<String>? domains,
  String? alphaTwoCode,
  String? country,
  dynamic stateprovince,
}) => Demodatamodel(  name: name ?? _name,
  webPages: webPages ?? _webPages,
  domains: domains ?? _domains,
  alphaTwoCode: alphaTwoCode ?? _alphaTwoCode,
  country: country ?? _country,
  stateprovince: stateprovince ?? _stateprovince,
);
  String? get name => _name;
  List<String>? get webPages => _webPages;
  List<String>? get domains => _domains;
  String? get alphaTwoCode => _alphaTwoCode;
  String? get country => _country;
  dynamic get stateprovince => _stateprovince;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['web_pages'] = _webPages;
    map['domains'] = _domains;
    map['alpha_two_code'] = _alphaTwoCode;
    map['country'] = _country;
    map['state-province'] = _stateprovince;
    return map;
  }

}