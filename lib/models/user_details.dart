import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_details.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class UserDetails {
  @HiveField(0)
  @JsonKey(name: 'email')
  final String? email;
  @HiveField(1)
  @JsonKey(name: 'first_name')
  final String? first_name;
  @HiveField(2)
  @JsonKey(name: 'last_name')
  final String? last_name;
  @HiveField(3)
  @JsonKey(name: 'pk')
  final int? pk;

  UserDetails({this.email, this.first_name, this.last_name, this.pk});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return _$UserDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);

  @override
  List get props => [email, first_name, last_name, pk];
}
