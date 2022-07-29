import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:live_tracking/utils/enums.dart';

part 'telematic.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class Telematic extends HiveObject {
   Telematic(
    this.altitude,
    this.bearing,
    this.ion,
    this.hdop,
    this.lat,
  );

  /// Converter from response map data to model
  factory Telematic.fromJson(Map<String, dynamic> json) => _$TelematicFromJson(json);

  /// Converter from model to map data for request
  Map<String, dynamic> toJson() => _$TelematicToJson(this);

  @HiveField(0)
  final num altitude;

  @HiveField(1) 
  final num bearing;
  
  @HiveField(2)
  final num ion;
  
  @HiveField(3)
  final int hdop;
  
  @HiveField(4)
  final num lat ;
  
}