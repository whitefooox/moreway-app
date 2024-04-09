// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'lat': instance.latitude,
      'lon': instance.longitude,
    };
