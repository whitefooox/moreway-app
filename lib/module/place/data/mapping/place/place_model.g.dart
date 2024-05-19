// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      image: PlaceModel._imageFromJson(json['image'] as Map<String, dynamic>),
      distance: (json['distance'] as num).toDouble(),
      locality: PlaceModel._localityFromJson(
          json['locality'] as Map<String, dynamic>),
      type: PlaceModel._typeFromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
      'rating': instance.rating,
      'image': instance.image,
      'distance': instance.distance,
      'locality': instance.locality,
      'type': instance.type,
    };
