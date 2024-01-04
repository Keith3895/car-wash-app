// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDetailsAdapter extends TypeAdapter<UserDetails> {
  @override
  final int typeId = 0;

  @override
  UserDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetails(
      email: fields[0] as String?,
      first_name: fields[1] as String?,
      last_name: fields[2] as String?,
      pk: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.first_name)
      ..writeByte(2)
      ..write(obj.last_name)
      ..writeByte(3)
      ..write(obj.pk);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      email: json['email'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      pk: json['pk'] as int?,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'email': instance.email,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'pk': instance.pk,
    };
