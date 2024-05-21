// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexed_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexedPlaceModel _$IndexedPlaceModelFromJson(Map<String, dynamic> json) =>
    IndexedPlaceModel(
      index: json['index'] as int,
      place: PlaceRouteModel.fromJson(json['place'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndexedPlaceModelToJson(IndexedPlaceModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'place': instance.place,
    };
