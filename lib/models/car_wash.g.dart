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
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      payment_information: json['payment_information'] == null
          ? null
          : Account.fromJson(json['payment_information'] as Map<String, dynamic>),
      kyc: json['kyc'] == null ? null : KYC.fromJson(json['kyc'] as Map<String, dynamic>),
      vendor_images: (json['vendor_images'] as List<dynamic>?)
          ?.map((e) => FileUploadResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'vendor_images': instance.vendor_images,
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

KYC _$KYCFromJson(Map<String, dynamic> json) => KYC(
      gstn: json['gstn'] as String?,
      PAN: json['PAN'] as String?,
      registered_company_name: json['registered_company_name'] as String?,
      gst_certificate: json['gst_certificate'] as String?,
      adhar_number: json['adhar_number'] as String?,
    );

Map<String, dynamic> _$KYCToJson(KYC instance) => <String, dynamic>{
      'gstn': instance.gstn,
      'PAN': instance.PAN,
      'registered_company_name': instance.registered_company_name,
      'gst_certificate': instance.gst_certificate,
      'adhar_number': instance.adhar_number,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zip_code: json['zip_code'] as String?,
      country: json['country'] as String?,
      address: json['address'] as String?,
      location: json['location'] == null
          ? null
          : LocationGIS.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zip_code': instance.zip_code,
      'country': instance.country,
      'address': instance.address,
      'location': instance.location,
    };

FileUploadResponse _$FileUploadResponseFromJson(Map<String, dynamic> json) => FileUploadResponse(
      id: json['id'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      document_url: json['document_url'] as String?,
      document_type: json['document_type'] as String?,
      document_name: json['document_name'] as String?,
    );

Map<String, dynamic> _$FileUploadResponseToJson(FileUploadResponse instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'document_url': instance.document_url,
      'document_type': instance.document_type,
      'document_name': instance.document_name,
    };

LocationGIS _$LocationFromJson(Map<String, dynamic> json) => LocationGIS(
      type: json['type'] as String,
      coordinates:
          (json['coordinates'] as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
    );

Map<String, dynamic> _$LocationToJson(LocationGIS instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
