import 'package:car_wash/services/auth_service.dart';
import 'package:file_picker/file_picker.dart';
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
  Address? address;
  @JsonKey(name: 'payment_information')
  Account? payment_information;
  @JsonKey(name: 'kyc')
  KYC? kyc;
  @JsonKey(name: 'vendor_images')
  List<FileUploadResponse>? vendor_images;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<PlatformFile>? vendor_images_files;

  CarWash(
      {this.id,
      this.uid,
      this.company_name,
      this.phone_number,
      this.email,
      this.address,
      this.payment_information,
      this.kyc,
      this.vendor_images,
      this.vendor_images_files});

  factory CarWash.fromflatStructure({
    String? company_name,
    String? phone_number,
    String? email,
    Address? address,
    String? bank_account_number,
    String? IFSC,
    String? UPID,
    String? gstn,
    String? PAN,
    String? registered_company_name,
    String? id,
    List<FileUploadResponse>? vendor_images,
    List<PlatformFile>? vendor_images_files,
    String? adhar_number,
    PlatformFile? gst_certificate_file,
    String? gst_certificate,
  }) {
    return CarWash(
        id: id,
        uid: AuthService.instance.currentUser!.id,
        company_name: company_name,
        phone_number: phone_number,
        email: email,
        address: address,
        vendor_images: vendor_images,
        vendor_images_files: vendor_images_files,
        payment_information:
            Account(bank_account_number: bank_account_number, bank_ifsc_code: IFSC, upi_id: UPID),
        kyc: KYC(
            gstn: gstn,
            PAN: PAN,
            registered_company_name: registered_company_name,
            gst_certificate: gst_certificate,
            adhar_number: adhar_number,
            gst_certificate_file: gst_certificate_file));
  }

  factory CarWash.fromJson(Map<String, dynamic> json) {
    return _$CarWashFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CarWashToJson(this);

  @override
  List get props =>
      [id, company_name, phone_number, email, address, payment_information, kyc, vendor_images];
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
class KYC {
  @JsonKey(name: 'gstn')
  final String? gstn;
  @JsonKey(name: 'PAN')
  final String? PAN;
  @JsonKey(name: 'registered_company_name')
  final String? registered_company_name;
  @JsonKey(name: 'gst_certificate')
  String? gst_certificate;
  @JsonKey(name: 'adhar_number')
  final String? adhar_number;

  @JsonKey(includeFromJson: false, includeToJson: false)
  PlatformFile? gst_certificate_file;

  KYC(
      {this.gstn,
      this.PAN,
      this.registered_company_name,
      this.gst_certificate,
      this.adhar_number,
      this.gst_certificate_file});

  factory KYC.fromJson(Map<String, dynamic> json) {
    return _$KYCFromJson(json);
  }

  Map<String, dynamic> toJson() => _$KYCToJson(this);

  @override
  List get props =>
      [gstn, PAN, registered_company_name, gst_certificate, adhar_number, gst_certificate_file];
}

@JsonSerializable()
class Address {
  @JsonKey(name: 'street')
  final String? street;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'zip_code')
  final String? zip_code;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'location')
  final LocationGIS? location;

  Address(
      {this.street,
      this.city,
      this.state,
      this.zip_code,
      this.country,
      this.address,
      this.location});

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List get props => [street, city, state, zip_code, country, address, location];
}

@JsonSerializable()
class FileUploadResponse {
  final String? id;
  final String? created_at;
  final String? updated_at;
  final String? document_url;
  final String? document_type;
  final String? document_name;

  FileUploadResponse(
      {this.id,
      this.created_at,
      this.updated_at,
      this.document_url,
      this.document_type,
      this.document_name});

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) {
    return _$FileUploadResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FileUploadResponseToJson(this);

  @override
  List get props => [id, created_at, updated_at, document_url, document_type, document_name];
}

@JsonSerializable()
class LocationGIS {
  String type;
  List<double> coordinates;

  LocationGIS({
    required this.type,
    required this.coordinates,
  });

  factory LocationGIS.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
