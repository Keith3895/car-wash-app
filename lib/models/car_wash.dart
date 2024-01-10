import 'package:json_annotation/json_annotation.dart';
part 'car_wash.g.dart';

@JsonSerializable()
class CarWash {
  @JsonKey(name: 'car_wash_name')
  String? car_wash_name;
  @JsonKey(name: 'phone_number')
  String? phone_number;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'bank_account')
  Account? bank_account;
  @JsonKey(name: 'documentation')
  carWashDocumentation? documentation;

  CarWash(
      {this.car_wash_name,
      this.phone_number,
      this.email,
      this.address,
      this.bank_account,
      this.documentation});

  factory CarWash.fromflatStructure(
      {String? car_wash_name,
      String? phone_number,
      String? email,
      String? address,
      String? bank_account_number,
      String? IFSC,
      String? UPID,
      String? gstn,
      String? PAN,
      String? registered_company_name}) {
    return CarWash(
        car_wash_name: car_wash_name,
        phone_number: phone_number,
        email: email,
        address: address,
        bank_account: Account(account_number: bank_account_number, IFSC: IFSC, UPID: UPID),
        documentation: carWashDocumentation(
            gstn: gstn, PAN: PAN, registered_company_name: registered_company_name));
  }

  factory CarWash.fromJson(Map<String, dynamic> json) {
    return _$CarWashFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CarWashToJson(this);

  @override
  List get props => [car_wash_name, phone_number, email, address, bank_account, documentation];
}

@JsonSerializable()
class Account {
  @JsonKey(name: 'bank_account_number')
  final String? account_number;
  @JsonKey(name: 'IFSC')
  final String? IFSC;
  @JsonKey(name: 'UPID')
  final String? UPID;

  Account({this.account_number, this.IFSC, this.UPID});

  factory Account.fromJson(Map<String, dynamic> json) {
    return _$AccountFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  List get props => [account_number, IFSC, UPID];
}

@JsonSerializable()
class carWashDocumentation {
  @JsonKey(name: 'gstn')
  final String? gstn;
  @JsonKey(name: 'PAN')
  final String? PAN;
  @JsonKey(name: 'registered_company_name')
  final String? registered_company_name;

  carWashDocumentation({this.gstn, this.PAN, this.registered_company_name});

  factory carWashDocumentation.fromJson(Map<String, dynamic> json) {
    return _$carWashDocumentationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$carWashDocumentationToJson(this);

  @override
  List get props => [gstn, PAN, registered_company_name];
}
