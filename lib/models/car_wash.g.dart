// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_wash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarWash _$CarWashFromJson(Map<String, dynamic> json) => CarWash(
      car_wash_name: json['car_wash_name'] as String?,
      phone_number: json['phone_number'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      bank_account: json['bank_account'] == null
          ? null
          : Account.fromJson(json['bank_account'] as Map<String, dynamic>),
      documentation: json['documentation'] == null
          ? null
          : carWashDocumentation
              .fromJson(json['documentation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarWashToJson(CarWash instance) => <String, dynamic>{
      'car_wash_name': instance.car_wash_name,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'address': instance.address,
      'bank_account': instance.bank_account,
      'documentation': instance.documentation,
    };

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      account_number: json['bank_account_number'] as String?,
      IFSC: json['IFSC'] as String?,
      UPID: json['UPID'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'bank_account_number': instance.account_number,
      'IFSC': instance.IFSC,
      'UPID': instance.UPID,
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
