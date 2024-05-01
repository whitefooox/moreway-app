// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_filter_options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceFilterOptionsModel _$PlaceFilterOptionsModelFromJson(
        Map<String, dynamic> json) =>
    PlaceFilterOptionsModel(
      localities: (json['localities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      minDistance: json['minDistance'] as int,
      maxDistance: json['maxDistance'] as int,
    );

Map<String, dynamic> _$PlaceFilterOptionsModelToJson(
        PlaceFilterOptionsModel instance) =>
    <String, dynamic>{
      'localities': instance.localities,
      'types': instance.types,
      'minDistance': instance.minDistance,
      'maxDistance': instance.maxDistance,
    };
