// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_point_detailed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePointDetailedModel _$RoutePointDetailedModelFromJson(
        Map<String, dynamic> json) =>
    RoutePointDetailedModel(
      id: json['id'] as int,
      index: json['index'] as int,
      place: PlaceRouteModel.fromJson(json['place'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoutePointDetailedModelToJson(
        RoutePointDetailedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'place': instance.place,
    };
