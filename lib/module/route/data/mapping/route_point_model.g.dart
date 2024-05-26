// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_point_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePointModel _$RoutePointModelFromJson(Map<String, dynamic> json) =>
    RoutePointModel(
      id: json['id'] as int,
      index: json['index'] as int,
      place: PlaceRouteModel.fromJson(json['place'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoutePointModelToJson(RoutePointModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'place': instance.place,
    };
