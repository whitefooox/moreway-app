// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersPageModel _$UsersPageModelFromJson(Map<String, dynamic> json) =>
    UsersPageModel(
      users: (json['data'] as List<dynamic>)
          .map((e) => UserRelationshipModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cursor:
          UsersPageModel._cursorFromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsersPageModelToJson(UsersPageModel instance) =>
    <String, dynamic>{
      'data': instance.users,
      'meta': instance.cursor,
    };
