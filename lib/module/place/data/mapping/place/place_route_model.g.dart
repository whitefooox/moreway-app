// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceRouteModel _$PlaceRouteModelFromJson(Map<String, dynamic> json) =>
    PlaceRouteModel(
      id: json['id'] as int,
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      image:
          PlaceRouteModel._imageFromJson(json['image'] as Map<String, dynamic>),
      locality: PlaceRouteModel._localityFromJson(
          json['locality'] as Map<String, dynamic>),
      type: PlaceRouteModel._typeFromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceRouteModelToJson(PlaceRouteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
      'rating': instance.rating,
      'image': instance.image,
      'locality': instance.locality,
      'type': instance.type,
    };
