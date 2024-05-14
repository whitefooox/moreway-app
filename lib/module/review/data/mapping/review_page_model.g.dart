// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewPageModel _$ReviewPageModelFromJson(Map<String, dynamic> json) =>
    ReviewPageModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cursor:
          ReviewPageModel._cursorFromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewPageModelToJson(ReviewPageModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.cursor,
    };
