import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:live_tracking/utils/enums.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class User extends HiveObject {
   User(
    this.token,
    this.permissions,
  );

  /// Converter from response map data to model
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converter from model to map data for request
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @HiveField(0)
  @JsonKey(name: 'user_api_hash')
  final String token;

  @HiveField(1)
  final Map<String, dynamic> permissions;
}
