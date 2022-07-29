import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:live_tracking/utils/enums.dart';

part 'device.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class Device extends HiveObject {
   Device(
    this.altitude,
    this.speed,
    this.lat,
    this.long,
    this.timestamp
  );

  /// Converter from response map data to model
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  /// Converter from model to map data for request
  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  @HiveField(0)
  final double altitude;
  
  @HiveField(1)
  final double speed;
  
  @HiveField(2)
  final double lat ;

  @HiveField(3)
  final double long ;

  @HiveField(4)
  final DateTime timestamp ;
  
}