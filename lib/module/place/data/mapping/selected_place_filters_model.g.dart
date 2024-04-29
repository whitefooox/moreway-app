// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_place_filters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectedPlaceFiltersModel _$SelectedPlaceFiltersModelFromJson(
        Map<String, dynamic> json) =>
    SelectedPlaceFiltersModel(
      search: json['search'] as String?,
      rangeRating: (json['rating'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      distance:
          (json['distance'] as List<dynamic>?)?.map((e) => e as int).toList(),
      type: json['type'] as String?,
      locality: json['locality'] as String?,
    );

Map<String, dynamic> _$SelectedPlaceFiltersModelToJson(
        SelectedPlaceFiltersModel instance) =>
    <String, dynamic>{
      'search': instance.search,
      'rating': _rangeToString(instance.rangeRating),
      'distance': _rangeToString2(instance.distance),
      'type': instance.type,
      'locality': instance.locality,
    };
