// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => RouteModel(
      id: json['id'] as int,
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      routePoints: (json['routePoints'] as List<dynamic>)
          .map((e) => RoutePointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      creator:
          UserPreviewModel.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'routePoints': instance.routePoints,
      'creator': instance.creator,
    };
