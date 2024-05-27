// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePageModel _$RoutePageModelFromJson(Map<String, dynamic> json) =>
    RoutePageModel(
      routes: (json['data'] as List<dynamic>)
          .map((e) => RouteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cursor:
          RoutePageModel._cursorFromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoutePageModelToJson(RoutePageModel instance) =>
    <String, dynamic>{
      'data': instance.routes,
      'meta': instance.cursor,
    };
