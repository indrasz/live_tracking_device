// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telematic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TelematicAdapter extends TypeAdapter<Telematic> {
  @override
  final int typeId = 1;

  @override
  Telematic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Telematic(
      fields[0] as num,
      fields[1] as num,
      fields[2] as num,
      fields[3] as int,
      fields[4] as num,
    );
  }

  @override
  void write(BinaryWriter writer, Telematic obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.altitude)
      ..writeByte(1)
      ..write(obj.bearing)
      ..writeByte(2)
      ..write(obj.ion)
      ..writeByte(3)
      ..write(obj.hdop)
      ..writeByte(4)
      ..write(obj.lat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelematicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Telematic _$TelematicFromJson(Map<String, dynamic> json) => Telematic(
      json['altitude'] as num,
      json['bearing'] as num,
      json['ion'] as num,
      json['hdop'] as int,
      json['lat'] as num,
    );

Map<String, dynamic> _$TelematicToJson(Telematic instance) => <String, dynamic>{
      'altitude': instance.altitude,
      'bearing': instance.bearing,
      'ion': instance.ion,
      'hdop': instance.hdop,
      'lat': instance.lat,
    };
