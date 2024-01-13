// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_wash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarWash _$CarWashFromJson(Map<String, dynamic> json) => CarWash(
      id: json['id'] as String?,
      uid: json['uid'] as String?,
      company_name: json['company_name'] as String?,
      phone_number: json['phone_number'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      payment_information: json['payment_information'] == null
          ? null
          : Account.fromJson(
              json['payment_information'] as Map<String, dynamic>),
      kyc: json['kyc'] == null
          ? null
          : carWashDocumentation.fromJson(json['kyc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarWashToJson(CarWash instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'company_name': instance.company_name,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'address': instance.address,
      'payment_information': instance.payment_information,
      'kyc': instance.kyc,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      bank_account_number: json['bank_account_number'] as String?,
      bank_ifsc_code: json['IFSC'] as String?,
      upi_id: json['UPID'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'bank_account_number': instance.bank_account_number,
      'IFSC': instance.bank_ifsc_code,
      'UPID': instance.upi_id,
    };

carWashDocumentation _$carWashDocumentationFromJson(
        Map<String, dynamic> json) =>
    carWashDocumentation(
      gstn: json['gstn'] as String?,
      PAN: json['PAN'] as String?,
      registered_company_name: json['registered_company_name'] as String?,
    );

Map<String, dynamic> _$carWashDocumentationToJson(
        carWashDocumentation instance) =>
    <String, dynamic>{
      'gstn': instance.gstn,
      'PAN': instance.PAN,
      'registered_company_name': instance.registered_company_name,
    };
