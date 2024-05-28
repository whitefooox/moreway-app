// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacePageModel _$PlacePageModelFromJson(Map<String, dynamic> json) =>
    PlacePageModel(
      places: (json['data'] as List<dynamic>)
          .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      next_cursor:
          PlacePageModel._cursorFromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlacePageModelToJson(PlacePageModel instance) =>
    <String, dynamic>{
      'data': instance.places,
      'meta': instance.next_cursor,
    };
