// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_me_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMeModel _$UserMeModelFromJson(Map<String, dynamic> json) => UserMeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserMeModelToJson(UserMeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
    };
