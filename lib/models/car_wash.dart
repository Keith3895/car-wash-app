import 'package:car_wash/services/auth_service.dart';
import 'package:json_annotation/json_annotation.dart';
part 'car_wash.g.dart';

@JsonSerializable()
class CarWash {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'uid')
  String? uid;
  @JsonKey(name: 'company_name')
  String? company_name;
  @JsonKey(name: 'phone_number')
  String? phone_number;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'payment_information')
  Account? payment_information;
  @JsonKey(name: 'kyc')
  carWashDocumentation? kyc;

  CarWash(
      {this.id,
      this.uid,
      this.company_name,
      this.phone_number,
      this.email,
      this.address,
      this.payment_information,
      this.kyc});

  factory CarWash.fromflatStructure(
      {String? company_name,
      String? phone_number,
      String? email,
      String? address,
      String? bank_account_number,
      String? IFSC,
      String? UPID,
      String? gstn,
      String? PAN,
      String? registered_company_name,
      String? id}) {
    return CarWash(
        id: id,
        uid: AuthService.instance.currentUser!.id,
        company_name: company_name,
        phone_number: phone_number,
        email: email,
        address: address,
        payment_information:
            Account(bank_account_number: bank_account_number, bank_ifsc_code: IFSC, upi_id: UPID),
        kyc: carWashDocumentation(
            gstn: gstn, PAN: PAN, registered_company_name: registered_company_name));
  }

  factory CarWash.fromJson(Map<String, dynamic> json) {
    return _$CarWashFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CarWashToJson(this);

  @override
  List get props => [id, company_name, phone_number, email, address, payment_information, kyc];
}

@JsonSerializable()
class Account {
  @JsonKey(name: 'bank_account_number')
  final String? bank_account_number;
  @JsonKey(name: 'IFSC')
  final String? bank_ifsc_code;
  @JsonKey(name: 'UPID')
  final String? upi_id;

  Account({this.bank_account_number, this.bank_ifsc_code, this.upi_id});

  factory Account.fromJson(Map<String, dynamic> json) {
    return _$AccountFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @override
  List get props => [bank_account_number, bank_ifsc_code, upi_id];
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
