// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendsPageModel _$FriendsPageModelFromJson(Map<String, dynamic> json) =>
    FriendsPageModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserPreviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cursor: FriendsPageModel._cursorFromJson(
          json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendsPageModelToJson(FriendsPageModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.cursor,
    };
