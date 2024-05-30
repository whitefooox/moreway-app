// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_detailed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteDetailedModel _$RouteDetailedModelFromJson(Map<String, dynamic> json) =>
    RouteDetailedModel(
      id: json['id'] as int,
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      routePoints: (json['routePoints'] as List<dynamic>)
          .map((e) =>
              RoutePointDetailedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      creator:
          UserPreviewModel.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RouteDetailedModelToJson(RouteDetailedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'routePoints': instance.routePoints,
      'creator': instance.creator,
    };
