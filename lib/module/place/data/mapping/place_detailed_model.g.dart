// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detailed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailedModel _$PlaceDetailedModelFromJson(Map<String, dynamic> json) =>
    PlaceDetailedModel(
      id: json['id'] as int,
      distance: (json['distance'] as num).toDouble(),
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String,
      images: PlaceDetailedModel._imagesFromJson(json['images'] as List),
      locality: PlaceDetailedModel._localityFromJson(
          json['locality'] as Map<String, dynamic>),
      type: PlaceDetailedModel._typeFromJson(
          json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceDetailedModelToJson(PlaceDetailedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'distance': instance.distance,
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
      'rating': instance.rating,
      'description': instance.description,
      'images': instance.images,
      'locality': instance.locality,
      'type': instance.type,
    };
